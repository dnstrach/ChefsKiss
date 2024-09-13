//
//  APIRecipe.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 3/14/24.
//

import Foundation
import SwiftData

class Response: Codable {
    var results: [APIRecipe]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
    
    init(results: [APIRecipe]) {
        self.results = results
    }
    
    // manually write Decodable/Encodable because class instead of struct
    // class for SwiftData saved recipes
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.results = try container.decode([APIRecipe].self, forKey: .results)
    }
    
    // conform to Encodable
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(results, forKey: .results)
    }
}

@Model
class APIRecipe: Codable, Hashable {
    // used for saved recipes
    static func == (lhs: APIRecipe, rhs: APIRecipe) -> Bool {
        lhs.id == rhs.id
    }
    
    // used for saved recipes
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id: Int
    let title: String
    let summary: String
    let image: String
    let imageType: String
    let isVegetarian: Bool
    let isVegan: Bool
    let isGlutenFree: Bool
    let isDairyFree: Bool
    let readyInMinutes: Int
    let servings: Int
    let sourceUrl: String
    let analyzedInstructions: [Instruction]?
    
    static let dummyRecipes = [
        APIRecipe(
            id: 1,
            title: "Sample Recipe",
            summary: "This is a sample recipe summary",
            image: "https",
            imageType: "jpg",
            isVegetarian: true,
            isVegan: false,
            isGlutenFree: true,
            isDairyFree: false,
            readyInMinutes: 30,
            servings: 4,
            sourceUrl: "https://sampleurl.com",
            analyzedInstructions: [
                Instruction(
                    steps: [
                        Step(
                            number: 1,
                            step: "Step 1",
                            ingredients: [
                                Ingredient(
                                    id: 1,
                                    name: "Ingredient 1" //,
                                    // image: "ingredient_image"
                                )
                            ],
                            equipment: [
                                Equipment(
                                    id: 0,
                                    name: "pot"
                                )
                            ]
                        )
                    ]
                )
            ]
        ),
        
        APIRecipe(
            id: 2,
            title: "Sample Recipe Long Text Sample Recipe",
            summary: "This is a sample recipe summary",
            image: "https://spoonacular.com/recipeImages/794538-312x231.jpg",
            imageType: "jpg",
            isVegetarian: true,
            isVegan: false,
            isGlutenFree: true,
            isDairyFree: false,
            readyInMinutes: 30,
            servings: 4,
            sourceUrl: "https://sampleurl.com",
            analyzedInstructions: [
                Instruction(
                    steps: [
                        Step(
                            number: 1,
                            step: "Step 1",
                            ingredients: [
                                Ingredient(
                                    id: 1,
                                    name: "Ingredient 1" //,
                                    // image: "ingredient_image"
                                )
                            ],
                            equipment: [
                                Equipment(
                                    id: 0,
                                    name: "pot"
                                )
                            ]
                        )
                    ]
                )
            ]
        ),
        
        APIRecipe(
            id: 3,
            title: "Sample Recipe Long Text Sample Recipe",
            summary: "This is a sample recipe summary",
            image: "https://spoonacular.com/recipeImages/794538-312x231.jpg",
            imageType: "jpg",
            isVegetarian: true,
            isVegan: false,
            isGlutenFree: true,
            isDairyFree: false,
            readyInMinutes: 30,
            servings: 4,
            sourceUrl: "https://sampleurl.com",
            analyzedInstructions: [
                Instruction(
                    steps: [
                        Step(
                            number: 1,
                            step: "Step 1",
                            ingredients: [
                                Ingredient(
                                    id: 1,
                                    name: "Ingredient 1" //,
                                    // image: "ingredient_image"
                                )
                            ],
                            equipment: [
                                Equipment(
                                    id: 0,
                                    name: "pot"
                                )
                            ]
                        )
                    ]
                )
            ]
        ),
        
        APIRecipe(
            id: 4,
            title: "Sample Recipe",
            summary: "This is a sample recipe summary",
            image: "https://spoonacular.com/recipeImages/794538-312x231.jpg",
            imageType: "jpg",
            isVegetarian: true,
            isVegan: false,
            isGlutenFree: true,
            isDairyFree: false,
            readyInMinutes: 30,
            servings: 4,
            sourceUrl: "https://sampleurl.com",
            analyzedInstructions: [
                Instruction(
                    steps: [
                        Step(
                            number: 1,
                            step: "Step 1",
                            ingredients: [
                                Ingredient(
                                    id: 1,
                                    name: "Ingredient 1"//,
                                    // image: "ingredient_image"
                                )
                            ],
                            equipment: [
                                Equipment(
                                    id: 0,
                                    name: "pot"
                                )
                            ]
                        )
                    ]
                )
            ]
        )
    ]
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case summary
        case image
        case imageType
        case isVegetarian = "vegetarian"
        case isVegan = "vegan"
        case isGlutenFree = "glutenFree"
        case isDairyFree = "dairyFree"
        case readyInMinutes
        case servings
        case sourceUrl
        case analyzedInstructions
    }
    
    init(id: Int, title: String, summary: String, image: String, imageType: String, isVegetarian: Bool, isVegan: Bool, isGlutenFree: Bool, isDairyFree: Bool, readyInMinutes: Int, servings: Int, sourceUrl: String, analyzedInstructions: [Instruction]) {
        self.id = id
        self.title = title
        self.summary = summary
        self.image = image
        self.imageType = imageType
        self.isVegetarian = isVegetarian
        self.isVegan = isVegan
        self.isGlutenFree = isGlutenFree
        self.isDairyFree = isDairyFree
        self.readyInMinutes = readyInMinutes
        self.servings = servings
        self.sourceUrl = sourceUrl
        self.analyzedInstructions = analyzedInstructions
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.summary = try container.decode(String.self, forKey: .summary)
        self.image = try container.decode(String.self, forKey: .image)
        self.imageType = try container.decode(String.self, forKey: .imageType)
        self.isVegetarian = try container.decode(Bool.self, forKey: .isVegetarian)
        self.isVegan = try container.decode(Bool.self, forKey: .isVegan)
        self.isGlutenFree = try container.decode(Bool.self, forKey: .isGlutenFree)
        self.isDairyFree = try container.decode(Bool.self, forKey: .isDairyFree)
        self.readyInMinutes = try container.decode(Int.self, forKey: .readyInMinutes)
        self.servings = try container.decode(Int.self, forKey: .servings)
        self.sourceUrl = try container.decode(String.self, forKey: .sourceUrl)
        self.analyzedInstructions = try container.decode([Instruction].self, forKey: .analyzedInstructions)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(summary, forKey: .summary)
        try container.encode(image, forKey: .image)
        try container.encode(imageType, forKey: .imageType)
        try container.encode(isVegetarian, forKey: .isVegetarian)
        try container.encode(isVegan, forKey: .isVegan)
        try container.encode(isGlutenFree, forKey: .isGlutenFree)
        try container.encode(isDairyFree, forKey: .isDairyFree)
        try container.encode(readyInMinutes, forKey: .readyInMinutes)
        try container.encode(servings, forKey: .servings)
        try container.encode(sourceUrl, forKey: .sourceUrl)
        try container.encode(analyzedInstructions, forKey: .analyzedInstructions)
    }
}

class Instruction: Codable {
    let steps: [Step]
    
    enum CodingKeys: String, CodingKey {
        case steps
    }
    
    init(steps: [Step]) {
        self.steps = steps
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.steps = try container.decode([Step].self, forKey: .steps)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(steps, forKey: .steps)
    }
}

class Step: Codable {
    let number: Int
    let step: String
    let ingredients: [Ingredient]
    let equipment: [Equipment]
    
    enum CodingKeys: String, CodingKey {
        case number
        case step
        case ingredients
        case equipment
    }
    
    init(number: Int, step: String, ingredients: [Ingredient], equipment: [Equipment]) {
        self.number = number
        self.step = step
        self.ingredients = ingredients
        self.equipment = equipment
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.number = try container.decode(Int.self, forKey: .number)
        self.step = try container.decode(String.self, forKey: .step)
        self.ingredients = try container.decode([Ingredient].self, forKey: .ingredients)
        self.equipment = try container.decode([Equipment].self, forKey: .equipment)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(number, forKey: .number)
        try container.encode(step, forKey: .step)
        try container.encode(ingredients, forKey: .ingredients)
        try container.encode(equipment, forKey: .equipment)
    }
}

class Ingredient: Codable {
    let id: Int
    let name: String
   // let image: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
    }
}

class Equipment: Codable {
   let id: Int
   let name: String
   
   enum CodingKeys: String, CodingKey {
       case id
       case name
   }
   
   init(id: Int, name: String) {
       self.id = id
       self.name = name
   }
   
   required init(from decoder: any Decoder) throws {
       let container = try decoder.container(keyedBy: CodingKeys.self)
       self.id = try container.decode(Int.self, forKey: .id)
       self.name = try container.decode(String.self, forKey: .name)
   }
   
   func encode(to encoder: Encoder) throws {
       var container = encoder.container(keyedBy: CodingKeys.self)
       try container.encode(id, forKey: .id)
       try container.encode(name, forKey: .name)
   }
}
