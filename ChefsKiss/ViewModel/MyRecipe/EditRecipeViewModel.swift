//
//  EditRecipeViewModel.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 4/10/24.
//

import Foundation
import PhotosUI
import SwiftUI

@MainActor
@Observable final class EditRecipeViewModel: ObservableObject {
    let prepHrRange = 0..<24
    let prepMinRange = 0..<60
    let cookHrRange = 0..<24
    let cookMinRange = 0..<60
    
    var imageState: ImageState = .empty
    
    var selectedImage: PhotosPickerItem? {
        didSet {
            if let selectedImage {
                let progress = loadTransferrable(from: selectedImage)
                imageState = .loading(progress)
            } else {
                imageState = .empty
            }
        }
    }
    
    var ingredientName: String = ""
    var measureAmount: Double? = nil
    var amountDouble: Double?
    var measurement: String = ""
    
    let measureTypes = ["tsp", "tbsp", "c", "pt", "qt", "gal", "oz", "fl oz", "lb", "mL", "L", "g", "kg"]
    
    var disableIngredient: Bool {
        ingredientName.isReallyEmpty
    }
    
    var equipmentName: String = ""
    
    var disableEquipment: Bool {
        equipmentName.isReallyEmpty
    }
    
    var stepNumber: Int = 0
    var step: String = ""
    
    var disableStep: Bool {
        step.isReallyEmpty
    }
    
    func clearPhoto() {
        imageState = .empty
    }
    
   private func loadTransferrable(from selectedImage: PhotosPickerItem) -> Progress {
        return selectedImage.loadTransferable(type: Data.self) { result in
            DispatchQueue.main.async {
                // why self????
                guard selectedImage == self.selectedImage else { return }
                switch result {
                case .success(let imageData?):
                    self.imageState = .success(imageData)
                case .success(nil):
                    self.imageState = .empty
                case .failure(let error):
                    self.imageState = .failure(error)
                }
            }
        }
    }
    
    func saveImage(_ recipe: Recipe) {
        guard let selectedImage else { return }
        
        Task {
            do {
                let data = try await selectedImage.loadTransferable(type: Data.self)
                
                guard let data, let uiImage = UIImage(data: data) else {
                    throw PhotoError.badConversion
                }
                
                if let imageData = uiImage.jpegData(compressionQuality: 0.8) {
                    recipe.image = imageData
                }

            } catch {
                print(error)
            }
        }
        
    }
}

/*
 @MainActor
 final class EditRecipeViewModel: ObservableObject {
     let prepHrRange = 0..<24
     let prepMinRange = 0..<60
     let cookHrRange = 0..<24
     let cookMinRange = 0..<60
     
     @Published var imageState: ImageState = .empty
     
     @Published var selectedImage: PhotosPickerItem? {
         didSet {
             if let selectedImage {
                 let progress = loadTransferrable(from: selectedImage)
                 imageState = .loading(progress)
             } else {
                 imageState = .empty
             }
         }
     }
     
     @Published var ingredientName: String = ""
     @Published var measureAmount: Double? = nil
     @Published var amountDouble: Double?
     @Published var measurement: String = ""
     
     let measureTypes = ["tsp", "tbsp", "c", "pt", "qt", "gal", "oz", "fl oz", "lb", "mL", "L", "g", "kg"]
     
     var disableIngredient: Bool {
         ingredientName.isReallyEmpty
     }
     
     @Published var equipmentName: String = ""
     
     var disableEquipment: Bool {
         equipmentName.isReallyEmpty
     }
     
     @Published var step: String = ""
     
     var disableStep: Bool {
         step.isReallyEmpty
     }
     
     func clearPhoto() {
         imageState = .empty
     }
     
    private func loadTransferrable(from selectedImage: PhotosPickerItem) -> Progress {
         return selectedImage.loadTransferable(type: Data.self) { result in
             DispatchQueue.main.async {
                 // why self????
                 guard selectedImage == self.selectedImage else { return }
                 switch result {
                 case .success(let imageData?):
                     self.imageState = .success(imageData)
                 case .success(nil):
                     self.imageState = .empty
                 case .failure(let error):
                     self.imageState = .failure(error)
                 }
             }
         }
     }
     
     func saveImage(_ recipe: Recipe) {
         guard let selectedImage else { return }
         
         Task {
             do {
                 let data = try await selectedImage.loadTransferable(type: Data.self)
                 
                 guard let data, let uiImage = UIImage(data: data) else {
                     throw PhotoError.badConversion
                 }
                 
                 if let imageData = uiImage.jpegData(compressionQuality: 0.8) {
                     recipe.image = imageData
                 }

             } catch {
                 print(error)
             }
         }
         
     }
 }

 */
