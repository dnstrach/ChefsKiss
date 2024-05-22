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
class EditRecipeViewModel: ObservableObject {
//    @Bindable var recipe: Recipe
//    
//    init(recipe: Recipe) {
//        self.recipe = recipe
//    }
//    
//    var disableForm: Bool {
//        recipe.title.isReallyEmpty
//    }
//    
//    @Published var uiImageDisplayed: UIImage? = nil
//    @Published var showNewImage: Bool = false
//    
//    var sortedIngredients: [Recipe.Ingredient] {
//        recipe.ingredients.sorted(by: {$0.name < $1.name} )
//    }
//    @Published var ingredientName: String = ""
//    @Published var measureAmount: Double? = nil
//    @Published var amountDouble: Double?
//    @Published var measurement: String = ""
//    
//    var sortedEquipment: [Recipe.Equipment] {
//        recipe.appliances.sorted(by: {$0.name < $1.name} )
//    }
//    @Published var equipmentName: String = ""
//    
//    var sortedSteps: [Recipe.Step] {
//        recipe.steps.sorted(by: {$0.index < $1.index} )
//    }
//    @Published var stepNumber: Int = 0
//    @Published var step: String = ""
//    
//    let prepHrRange = 0..<24
//    let prepMinRange = 0..<60
//    let cookHrRange = 0..<24
//    let cookMinRange = 0..<60
//    let measureTypes = ["tsp", "tbsp", "c", "pt", "qt", "gal", "oz", "fl oz", "lb", "mL", "L", "g", "kg"]
    
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
    
    func clearPhoto() {
        imageState = .empty
    }
    
   private func loadTransferrable(from selectedImage: PhotosPickerItem) -> Progress {
        return selectedImage.loadTransferable(type: Image.self) { result in
            DispatchQueue.main.async {
                // why self????
                guard selectedImage == self.selectedImage else { return }
                switch result {
                case .success(let image?):
                    self.imageState = .success(image)
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
    
//    func showSavedImage() {
//        if recipe.image != nil {
//            imageState = .savedImage
//        }
//    }
//    
//    func addIngredient() {
//        let newIngredient = Recipe.Ingredient(name: ingredientName, measurement: measureAmount ?? 0, measurementType: measurement)
//        recipe.ingredients.append(newIngredient)
//        ingredientName = ""
//        measureAmount = nil
//        measurement = ""
//    }
//    
//    func deleteIngredient(at offsets: IndexSet) {
//        var sorted = sortedIngredients
//        sorted.remove(atOffsets: offsets)
//        recipe.ingredients = sorted
//    }
//    
//    func addEquipment() {
//        let newEquipment = Recipe.Equipment(name: equipmentName)
//        recipe.appliances.append(newEquipment)
//        equipmentName = ""
//    }
//    
//    func deleteEquipment(at offsets: IndexSet) {
//        var sorted = sortedEquipment
//        sorted.remove(atOffsets: offsets)
//        recipe.appliances = sorted
//    }
//    
//    func addStep() {
//        var sortedSteps = sortedSteps
//        
//        stepNumber = sortedSteps.count
//        let newStep = Recipe.Step(index: stepNumber, stepDetail: step)
//        sortedSteps.append(newStep)
//        step = ""
//        recipe.steps = sortedSteps
//    }
//    
////    func deleteStep2(at offsets: IndexSet) {
////
////        recipe.steps = sortedSteps()
////
////       // editMode = .active
////    }
//    
//    func deleteStep(_ step: Recipe.Step) {
//        var sortedSteps = sortedSteps
//        
//        for i in step.index..<sortedSteps.count {
//            sortedSteps[i].index -= 1
//        }
//        
//        sortedSteps.removeAll(where: { $0.id == step.id })
//        
//        recipe.steps = sortedSteps
//    }
//    
//    // walk through code
//    func moveStep(index: IndexSet, destination: Int) {
//        var sortedSteps = sortedSteps
//        
//        print("old steps")
//        
//        for step in sortedSteps {
//            print("index: \(step.index) step: \(step.stepDetail)")
//        }
//        
//        sortedSteps.move(fromOffsets: index, toOffset: destination)
//        
//        print("steps with moved step")
//        
//        for step in sortedSteps {
//            print("index: \(step.index) step: \(step.stepDetail)")
//        }
//        
//        for index in index {
//            print("index: \(index)")
//            print("destination: \(destination)")
//            
//            if index - destination < 0 {
//                for i in index..<destination {
//                    print("index \(i) being changed -")
//                    sortedSteps[i].index -= 1
//                    }
//                
//                sortedSteps[destination - 1].index = destination - 1
//                
//            } else if index - destination > 0 {
//                for i in destination..<index + 1 {
//                    print("index \(i) being changed +")
//                    sortedSteps[i].index += 1
//                    }
//
//                sortedSteps[destination].index = destination
//                
//            }
//        }
//        
//        recipe.steps = sortedSteps
//        
//        print("new steps")
//        
//        for step in recipe.steps {
//            print("index: \(step.index) step: \(step.stepDetail)")
//        }
//        
//        print("end")
//
//    }
}
