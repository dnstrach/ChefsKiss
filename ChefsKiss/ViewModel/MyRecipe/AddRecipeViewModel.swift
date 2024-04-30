//
//  AddRecipeViewModel.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 4/9/24.
//

import Foundation
import PhotosUI
import SwiftUI

enum PhotoError: Error {
    case badConversion
}

// view model currently only handling logic for photo picker -- same as EditRecipeViewModel -- should I use the same vm for add and edit recipe view???
@MainActor
class AddRecipeViewModel: ObservableObject {
    @Published private(set) var processedImage: UIImage? = nil
    
    @Published var selectedImage: PhotosPickerItem? = nil {
        didSet {
            // Data -> UIImage
            setImage(from: selectedImage)
        }
    }
    
    private func setImage(from selection: PhotosPickerItem?) {
        guard let selection else { return }
        
        Task {
            do {
                let data = try await selection.loadTransferable(type: Data.self)
                
                guard let data, let uiImage = UIImage(data: data) else {
                    throw PhotoError.badConversion
                }
                
                processedImage = uiImage
            } catch {
                print(error)
            }
        }   
    }
    
    func storeImageInRecipe(_ recipe: Recipe) {
        if let processedImage = processedImage,
           let imageData = processedImage.jpegData(compressionQuality: 0.8) {
            recipe.image = imageData
        }
    }
}


