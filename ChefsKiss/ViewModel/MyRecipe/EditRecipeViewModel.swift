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
    
    let measureTypes = ["tsp", "tbsp", "c", "pt", "qt", "gal", "oz", "fl oz", "lb", "mL", "L", "g", "kg"]
    
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
    
   private func loadTransferrable(from selectedImage: PhotosPickerItem) -> Progress {
        return selectedImage.loadTransferable(type: Data.self) { result in
            DispatchQueue.main.async {
                // why self????
                guard selectedImage == self.selectedImage else { return }
                switch result {
                case .success(nil):
                    self.imageState = .empty
                case .success(let imageData?):
                    self.imageState = .success(imageData)
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
 // recipe property in view model
 // photo not working 
 // not able to separate recipe into view model with current version deleting items from environment with model context
 // @MainActor
 @Observable final class EditRecipeViewModel: ObservableObject {
     var recipe: Recipe
     
     init(recipe: Recipe) {
         self.recipe = recipe
     }
     
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
     
     var sortedIngredients: [Recipe.Ingredient] {
         recipe.ingredients.sorted(by: {$0.name < $1.name} )
     }

     var sortedEquipment: [Recipe.Equipment] {
         recipe.appliances.sorted(by: {$0.name < $1.name} )
     }
     
     var equipmentName: String = ""
     
     var disableEquipment: Bool {
         equipmentName.isReallyEmpty
     }
     
     var sortedInstructions: [Recipe.Instruction] {
         recipe.instructions.sorted(by: {$0.index < $1.index} )
     }
     
     var stepNumber: Int = 0
     var step: String = ""
     
     var disableStep: Bool {
         step.isReallyEmpty
     }
     
     var disableForm: Bool {
         recipe.title.isReallyEmpty
     }
     
    private func loadTransferrable(from selectedImage: PhotosPickerItem) -> Progress {
         return selectedImage.loadTransferable(type: Data.self) { result in
             DispatchQueue.main.async {
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
     
     func showSavedImage() {
         if recipe.image != nil {
             imageState = .savedImage
         }
     }
     
     func clearPhoto() {
         imageState = .empty
     }
     
     func addIngredient() {
         let newIngredient = Recipe.Ingredient(name: ingredientName, measurement: measureAmount ?? 0, measurementType: measurement)
         recipe.ingredients.append(newIngredient)
         ingredientName = ""
         measureAmount = nil
         measurement = ""
     }
     
     func deleteIngredient(_ ingredient: Recipe.Ingredient) {
         var sorted = sortedIngredients
         sorted.removeAll(where: { $0.id == ingredient.id })
         recipe.ingredients = sorted
     }
     
 //    func deleteIngredient(at offsets: IndexSet) {
 //        var sorted = sortedIngredients
 //        sorted.remove(atOffsets: offsets)
 //        recipe.ingredients = sorted
 //    }
     
     func addEquipment() {
         let newEquipment = Recipe.Equipment(name: equipmentName)
         recipe.appliances.append(newEquipment)
         equipmentName = ""
     }
     
     func deleteEquipment(_ equipment: Recipe.Equipment) {
         var sorted = sortedEquipment
         sorted.removeAll(where: { $0.id == equipment.id })
         recipe.appliances = sorted
     }
     
 //    func deleteEquipment(at offsets: IndexSet) {
 //        var sorted = sortedEquipment
 //        sorted.remove(atOffsets: offsets)
 //        recipe.appliances = sorted
 //    }
     
     func addStep() {
         var sortedSteps = sortedInstructions
         
         stepNumber = sortedSteps.count
         let newStep = Recipe.Instruction(index: stepNumber, step: step)
         sortedSteps.append(newStep)
         step = ""
         recipe.instructions = sortedSteps
     }
     
     func deleteStep(_ step: Recipe.Instruction) {
         // get the current sorted steps
         var sortedSteps = sortedInstructions
         
       //   reindex the remaining steps
 //        for (index, step) in sortedSteps.enumerated() {
 //            step.index = index
 //        }
         
         for (index, sortedStep) in sortedSteps.enumerated() {
             if index > step.index {
                 sortedStep.index -= 1
             }
         }
         
         sortedSteps.removeAll(where: { $0.id == step.id })
         
         print("Sorted Steps")
         for step in sortedSteps {
             print(step.step)
         }
         print("Sorted Steps")
         
         // binding to instructions in AddRecipeViewModel?
         // recipe.instructions not getting updated???
         recipe.instructions = sortedSteps
         
         print("Recipe Steps")
         for step in recipe.instructions {
             print(step.step)
         }
        // print("Recipe Steps")
         
     }
     
     func moveStep(index: IndexSet, destination: Int) {
         var sortedSteps = sortedInstructions
         
         sortedSteps.move(fromOffsets: index, toOffset: destination)
         
         for index in index {
             
             if index - destination < 0 {
                 for i in index..<destination {
                   //  print("index \(i) being changed -")
                     sortedSteps[i].index -= 1
                     }
                 
                 sortedSteps[destination - 1].index = destination - 1
                 
             } else if index - destination > 0 {
                 for i in destination..<index + 1 {
                   //  print("index \(i) being changed +")
                     sortedSteps[i].index += 1
                     }

                 sortedSteps[destination].index = destination
                 
             }
         }
         
         recipe.instructions = sortedSteps
     }
 }
 */

/*
 // @Published instead of @Observable
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
