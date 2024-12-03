//
//  AddRecipeViewModel.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 4/9/24.
//

import Foundation
import PhotosUI
import SwiftData
import SwiftUI
import UIKit

enum PhotoError: Error {
    case badConversion
}

enum ImageState {
    case empty
    case loading(Progress)
    case success(Data)
    case cameraImage
    case savedImage
    case failure(Error)
}

@MainActor
@Observable final class AddEditRecipeViewModel: ObservableObject {
    let recipe: Recipe? = nil
    
    var title: String = ""
    var summary: String = ""
    
    var imageState: ImageState = .empty

    var selectedCameraImage: UIImage? 
    var selectedPhoto: PhotosPickerItem? {
        didSet {
            if let selectedPhoto {
                let progress = loadTransferable(from: selectedPhoto)
                imageState = .loading(progress)
            } else {
                imageState = .empty
            }
        }
    }
    
    var savedImage: UIImage? = nil
    
    var servings: Double = 4
    var servingsGreaterThanMinimum: Bool {
        servings > 0.5
    }
    
    var prepTime: Int = 0
    let prepTimeRange = 0..<1500

    var cookTime: Int = 0
    let cookTimeRange = 0..<1500
    
    var ingredients: [Recipe.Ingredient] = []
    var ingredientName: String = ""
    var measurement: Double? = nil
    var amountDouble: Double?
    var measurementType: String = ""
    var selectedIngredient: Recipe.Ingredient?
    let measureTypes = ["tsp", "tbsp", "c", "pt", "qt", "gal", "oz", "fl oz", "lb", "mL", "L", "g", "kg"]
    var sortedIngredients: [Recipe.Ingredient] {
        ingredients.sorted(by: {$0.name < $1.name}) }
    
    var disableIngredient: Bool {
        ingredientName.isReallyEmpty
    }
    
    var appliances: [Recipe.Equipment] = []
    var equipmentName: String = ""
    var selectedEquipment: Recipe.Equipment?
    var sortedEquipment: [Recipe.Equipment] { appliances.sorted(by: {$0.name < $1.name}) }
    var disableEquip: Bool { equipmentName.isReallyEmpty }
    
    var instructions: [Recipe.Instruction] = []
    var stepNumber: Int = 0
    var step: String = ""
    var selectedInstruction: Recipe.Instruction?
    var sortedInstructions: [Recipe.Instruction] { instructions.sorted(by: {$0.index < $1.index}) }
    var disableStep: Bool { step.isReallyEmpty }
    
    var disableForm: Bool {
        title.isReallyEmpty
    }
    
    func loadRecipeData() {
        if let recipe = recipe {
            title = recipe.title
            summary = recipe.summary
            servings = recipe.servings
            prepTime = recipe.prepTime
            cookTime = recipe.cookTime
            ingredients = recipe.ingredients
            instructions = recipe.instructions
            appliances = recipe.appliances
        }
    }
        
    func clearPhoto(recipe: Recipe?) {
        imageState = .empty
        selectedPhoto = nil
        selectedCameraImage = nil
        recipe?.image = nil
    }
    
    private func loadTransferable(from selectedImage: PhotosPickerItem) -> Progress {
        return selectedImage.loadTransferable(type: Data.self) { result in
            DispatchQueue.main.async {
                guard selectedImage == self.selectedPhoto else { return }
                switch result {
                case .success(nil):
                    self.imageState = .empty
                case .success(let imageData?):
                    self.imageState = .success(imageData)
                    self.selectedCameraImage = nil
                case .failure(let error):
                    self.imageState = .failure(error)
                }
            }
        }
    }
    
    func saveImage(_ recipe: Recipe) {
        // check if there's a camera image
        if let selectedImage = selectedCameraImage {
            if let imageData = selectedImage.jpegData(compressionQuality: 0.8) {
                recipe.image = imageData
            }
        }
        // check if there's a selected photo from the library
        else if let selectedPhoto {
            Task {
                do {
                    let data = try await selectedPhoto.loadTransferable(type: Data.self)
                    
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
    
    func addIngredient() {
        let newIngredient = Recipe.Ingredient(name: ingredientName, measurement: measurement ?? 0, measurementType: measurementType)
        ingredients.append(newIngredient)
        ingredientName = ""
        measurement = nil
        measurementType = ""
    }
    
    func deleteIngredient(_ ingredient: Recipe.Ingredient) {
        ingredients.removeAll(where: { $0.id == ingredient.id })
    }
    
    func addEquipment() {
        let newEquipment = Recipe.Equipment(name: equipmentName)
        appliances.append(newEquipment)
        equipmentName = ""
    }
    
    func deleteEquipment(_ equipment: Recipe.Equipment) {
        appliances.removeAll(where: { $0.id == equipment.id })
    }
    
    func addStep(at index: Int) {
        let newStep = Recipe.Instruction(index: index, step: step)
        instructions.append(newStep)
        step = ""
    }
    
    func deleteStep(_ step: Recipe.Instruction) {
        instructions.removeAll(where: { $0.id == step.id })
        
        for (index, step) in instructions.enumerated() {
            step.index = index
        }
    }
    
    func moveStep(index: IndexSet, destination: Int) {
        var sorted = sortedInstructions
        
        sorted.move(fromOffsets: index, toOffset: destination)

        for index in index {
            print("index: \(index)")
            print("destination: \(destination)")
            
            // if + number then item is being moved forward
            if index - destination > 0 {
                // range is from destination index to included original index
                for i in destination..<index + 1 {
                        sorted[i].index += 1
                    }
                
                // update destination index since it's included in range
                sorted[destination].index = destination
                
            // if - number then item is being moved backwards
            } else if index - destination < 0 {
                // range - original index to destination index
                // note: destination is index + 1
                for i in index..<destination {
                        sorted[i].index -= 1
                    }
                
                // update destination index since it's included in range
                sorted[destination - 1].index = destination - 1
            }
            
            instructions = sorted
        }
        
        for step in instructions {
            print("index: \(step.index) step: \(step.step)")
        }
        
        print("end")
        
    }
}

