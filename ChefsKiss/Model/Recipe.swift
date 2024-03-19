//
//  Recipe.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 3/14/24.
//

import Foundation
import SwiftData

// decide on how data will be inputted - stepper, picker, textfield

@Model
// for cloudkit will need all optionals or defaults
class Recipe {
    var title: String
    var instructions: String
    @Attribute(.externalStorage) var photo: Data?
    // var servings: Double // stepper
    // var duration: Int // sliders. picker, or text field for hour and minute
        // maybe include prep time
    
    
    init(title: String, instructions: String) {
        self.title = title
        self.instructions = instructions
    }
}
