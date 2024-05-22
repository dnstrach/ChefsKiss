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

enum ImageState {
    case empty
    case loading(Progress)
    case success(Image)
    case savedImage
    case failure(Error)
}

enum PrepDurationState {
    case prepTimeNotEmpty
    case emptyPrepHour
    case emptyPrepMinute
    case emptyPrepHrAndMin
}

enum CookDurationState {
    case cookTimeNotEmpty
    case emptyCookHour
    case emptyCookMinute
    case emptyCookHrAndMin
}

@MainActor
class AddRecipeViewModel: ObservableObject {
    @Published private(set) var imageState: ImageState = .empty

    @Published var selectedImage: PhotosPickerItem? {
        didSet {
            if let selectedImage {
                let progress = loadTransferable(from: selectedImage)
                imageState = .loading(progress)
            } else {
                imageState = .empty
            }
        }
    }
    
    // or just disable if title is empty
    var disableForm: Bool {
        title.isReallyEmpty
    }
    
    var disableIngred: Bool {
        ingredientName.isReallyEmpty
    }
    
    var disableEquip: Bool {
        equipmentName.isReallyEmpty
    }
    
    var disableStep: Bool {
        step.isReallyEmpty
    }
    
    @Published var prepDurationState: PrepDurationState = .prepTimeNotEmpty
    @Published var cookDurationState: CookDurationState = .cookTimeNotEmpty
    
    @Published var title: String = ""
    @Published var summary: String = ""
    
    @Published var servings: Double = 4
    
    @Published var prepHrTime: Int = 0
    @Published var prepMinTime: Int = 0
    let prepHrRange = 0..<24
    let prepMinRange = 0..<60
    
    @Published var cookHrTime: Int = 0
    @Published var cookMinTime: Int = 0
    let cookHrRange = 0..<24
    let cookMinRange = 0..<60
    
    var sortedIngredients: [Recipe.Ingredient] {
        ingredients.sorted(by: {$0.name < $1.name} )
    }
    @Published var ingredients: [Recipe.Ingredient] = []
    @Published var ingredientName: String = ""
    @Published var measureAmount: Double? = nil
    @Published var amountDouble: Double?
    @Published var measurement: String = ""
    let measureTypes = ["tsp", "tbsp", "c", "pt", "qt", "gal", "oz", "fl oz", "lb", "mL", "L", "g", "kg"]
    
    var sortedEquipment: [Recipe.Equipment] {
        appliances.sorted(by: {$0.name < $1.name} )
    }
    @Published var appliances: [Recipe.Equipment] = []
    @Published var equipmentName: String = ""
    
    var sortedSteps: [Recipe.Step] {
        steps.sorted(by: {$0.index < $1.index} )
    }
    @Published var steps: [Recipe.Step] = []
    @Published var stepNumber: Int = 0
    @Published var step: String = ""
    
    func clearPhoto() {
        imageState = .empty
    }
    
    private func loadTransferable(from selectedImage: PhotosPickerItem) -> Progress {
        return selectedImage.loadTransferable(type: Image.self) { result in
            DispatchQueue.main.async {
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
    
//    func deleteIngredient(at offsets: IndexSet) {
//        ingredients = sortedIngredients
//        ingredients.remove(atOffsets: offsets)
//    }
    
    func addEquipment() {
        let newEquipment = Recipe.Equipment(name: equipmentName)
        appliances.append(newEquipment)
        equipmentName = ""
    }
    
    func deleteEquipment(_ equipment: Recipe.Equipment) {
        appliances.removeAll(where: { $0.id == equipment.id })
    }
    
//    func deleteEquipment(at offsets: IndexSet) {
//        appliances = sortedEquipment
//        appliances.remove(atOffsets: offsets)
//    }
    
    func addStep(at index: Int) {
        let newStep = Recipe.Step(index: index, stepDetail: step)
        steps.append(newStep)
        step = ""
    }
    
    func deleteStep(_ step: Recipe.Step) {
        for i in step.index..<steps.count {
            steps[i].index -= 1
        }
        
        steps.removeAll(where: { $0.id == step.id })
    }
    
//    func deleteStep(at offsets: IndexSet) {
//        steps.remove(atOffsets: offsets)
//    }
    
    func moveStep(index: IndexSet, destination: Int) {
        var sorted = sortedSteps
        
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
            
            steps = sorted
        }
        
        for step in steps {
            print("index: \(step.index) step: \(step.stepDetail)")
        }
        
        print("end")
        
    }
}


