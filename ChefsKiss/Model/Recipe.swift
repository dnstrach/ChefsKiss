//
//  Recipe.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 3/14/24.
//

import Foundation
import SwiftData
import SwiftUI

// add enum for types

@Model
class Recipe: Identifiable {
    var id = UUID()
    var title: String = ""
    var summary: String = ""
    var image: Data? = nil
//    var type: String = ""
//    var isVegetarian: Bool = false
//    var isVegan: Bool = false
//    var isGlutenFree: Bool = false
//    var isDairyFree: Bool = false
    var servings: Double = 0
    var prepTime: Int = 0
    var cookTime: Int = 0
    var ingredients: [Ingredient]
    var instructions: [Instruction]
    var appliances: [Equipment]
    
    var sortedIngredients: [Recipe.Ingredient] {
        ingredients.sorted(by: {$0.name < $1.name} )
    }
    
    var sortedEquipment: [Recipe.Equipment] {
        appliances.sorted(by: {$0.name < $1.name} )
    }
    
    var sortedInstructions: [Recipe.Instruction] {
        instructions.sorted(by: {$0.index < $1.index} )
    }
    
    init(id: UUID = UUID(), title: String, summary: String, image: Data? = nil, servings: Double, prepTime: Int, cookTime: Int, ingredients: [Ingredient], steps: [Instruction], appliances: [Equipment]) {
        self.id = id
        self.title = title
        self.summary = summary
        self.image = image
        self.servings = servings
        self.prepTime = prepTime
        self.cookTime = cookTime
        self.ingredients = ingredients
        self.instructions = steps
        self.appliances = appliances
    }

    @Model
    class Ingredient: Identifiable {
        var id = UUID()
        var name: String
        var measurement: Double
        var measurementType: String
        
        init(id: UUID = UUID(), name: String, measurement: Double, measurementType: String) {
            self.id = id
            self.name = name
            self.measurement = measurement
            self.measurementType = measurementType
        }
    }
    
    @Model
    class Equipment: Identifiable {
        var id = UUID()
        var name: String
        
        init(id: UUID = UUID(), name: String) {
            self.id = id
            self.name = name
        }
    }
    
    @Model
    class Instruction: Identifiable {
        var id = UUID()
        var index: Int
        var step: String
        
        init(id: UUID = UUID(), index: Int, step: String) {
            self.id = id
            self.index = index
            self.step = step
        }
    }
}


