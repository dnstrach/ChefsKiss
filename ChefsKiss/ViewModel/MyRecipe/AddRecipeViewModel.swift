//
//  AddRecipeViewModel.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 4/9/24.
//

import Foundation
import PhotosUI
import SwiftUI
import UIKit

enum PhotoError: Error {
    case badConversion
}

enum ImageState {
    case empty
    case loading(Progress)
    case success(Data)
    case savedImage
    case failure(Error)
}

@MainActor
@Observable final class AddRecipeViewModel: ObservableObject {
    var title: String = ""
    var summary: String = ""
    
    var imageState: ImageState = .empty

    var selectedImage: PhotosPickerItem? {
        didSet {
            if let selectedImage {
                let progress = loadTransferable(from: selectedImage)
                imageState = .loading(progress)
            } else {
                imageState = .empty
            }
        }
    }
    
    var servings: Double = 4
    
    var prepHrTime: Int = 0
    var prepMinTime: Int = 0
    
    let prepHrRange = 0..<24
    let prepMinRange = 0..<60
    
    var cookHrTime: Int = 0
    var cookMinTime: Int = 0
    
    let cookHrRange = 0..<24
    let cookMinRange = 0..<60
    
    var ingredients: [Recipe.Ingredient] = []
    var ingredientName: String = ""
    var measureAmount: Double? = nil
    var amountDouble: Double?
    var measurement: String = ""
    
    let measureTypes = ["tsp", "tbsp", "c", "pt", "qt", "gal", "oz", "fl oz", "lb", "mL", "L", "g", "kg"]
    
    var sortedIngredients: [Recipe.Ingredient] {
        ingredients.sorted(by: {$0.name < $1.name} )
    }
    
    var disableIngredient: Bool {
        ingredientName.isReallyEmpty
    }
    
    var appliances: [Recipe.Equipment] = []
    var equipmentName: String = ""
    
    var sortedEquipment: [Recipe.Equipment] {
        appliances.sorted(by: {$0.name < $1.name} )
    }
    
    var disableEquip: Bool {
        equipmentName.isReallyEmpty
    }
    
    var instructions: [Recipe.Instruction] = []
    var stepNumber: Int = 0
    var step: String = ""
    
    var sortedInstructions: [Recipe.Instruction] {
        instructions.sorted(by: {$0.index < $1.index} )
    }
    
    var disableStep: Bool {
        step.isReallyEmpty
    }
    
    var disableForm: Bool {
        title.isReallyEmpty
    }
    
    func clearPhoto() {
        imageState = .empty
    }
    
    private func loadTransferable(from selectedImage: PhotosPickerItem) -> Progress {
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
    
    func addIngredient() {
        let newIngredient = Recipe.Ingredient(name: ingredientName, measurement: measureAmount ?? 0, measurementType: measurement)
        ingredients.append(newIngredient)
        ingredientName = ""
        measureAmount = nil
        measurement = ""
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

extension Data {
    func toUIImage() -> UIImage? {
        return UIImage(data: self)
    }
}

