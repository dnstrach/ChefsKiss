//
//  APIRecipe.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 3/14/24.
//

import Foundation

struct Response: Codable {
    var results: [APIRecipe]
}

struct APIRecipe: Codable {
    let id: Int
    let title: String
    let summary: String
    let image: String
    let imageType: String
    // icons
    let vegetarian: Bool
    let vegan: Bool
    let glutenFree: Bool
    let dairyFree: Bool
    let veryHealthy: Bool
    let sustainable: Bool
    //
    let readyInMinutes: Int
    let servings: Int
    let sourceUrl: String
    let cuisines: [String]?
    let dishTypes: [String]?
    let sideDish: [String]?
    let diets: [String]?
    let analyzedInstructions: [Instruction]
    
    static let dummyRecipe = APIRecipe(
        id: 1,
        title: "Sample Recipe",
        summary: "This is a sample recipe summary",
        image: "sample_image", imageType: "jpg",
        vegetarian: true,
        vegan: false,
        glutenFree: true,
        dairyFree: false,
        veryHealthy: false,
        sustainable: true,
        readyInMinutes: 30,
        servings: 4,
        sourceUrl: "https://sampleurl.com",
        cuisines: ["Italian"],
        dishTypes: ["Main Course"],
        sideDish: nil, diets: nil,
        analyzedInstructions: [
            Instruction(steps: [Step(number: 1, step: "Step 1", ingredients: [Ingredient(id: 1, name: "Ingredient 1", image: "ingredient_image")])])
        ]
    )
}

struct Instruction: Codable {
    let steps: [Step]
}

struct Step: Codable {
    let number: Int
    let step: String
    let ingredients: [Ingredient]
}

struct Ingredient: Codable {
    let id: Int
    let name: String
    let image: String
}
