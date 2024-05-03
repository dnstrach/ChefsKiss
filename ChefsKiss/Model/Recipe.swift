//
//  Recipe.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 3/14/24.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class Recipe {
    var id = UUID()
    var title: String = ""
    var summary: String = ""
    var image: Data? = nil
    var servings: Double = 0
    var prepHrTime: Int = 0
    var prepMinTime: Int = 0
    var cookHrTime: Int = 0
    var cookMinTime: Int = 0
    var ingredients: [Ingredient]
    var steps: [Step]
    
    var sortedIngredients: [Recipe.Ingredient] {
        ingredients.sorted(by: {$0.name < $1.name} )
    }
    
    var sortedSteps: [Recipe.Step] {
        steps.sorted(by: {$0.index < $1.index} )
    }
    
    init(id: UUID = UUID(), title: String, summary: String, image: Data? = nil, servings: Double, prepHrTime: Int, prepMinTime: Int, cookHrTime: Int, cookMinTime: Int, ingredients: [Ingredient], steps: [Step]) {
        self.id = id
        self.title = title
        self.summary = summary
        self.image = image
        self.servings = servings
        self.prepHrTime = prepHrTime
        self.prepMinTime = prepMinTime
        self.cookHrTime = cookHrTime
        self.cookMinTime = cookMinTime
        self.ingredients = ingredients
        self.steps = steps
    }

    // added as relationship to recipe
    @Model
    class Ingredient {
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
    
    // added as relationship to recipe
    @Model
    class Step {
        var id = UUID()
        var index: Int
        var stepDetail: String
        
        init(id: UUID = UUID(), index: Int, stepDetail: String) {
            self.id = id
            self.index = index
            self.stepDetail = stepDetail
        }
    }
}


