//
//  APIRecipePreview.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 5/15/24.
//

import Foundation
import SwiftData

@MainActor
struct APIRecipePreviewer {
    let container: ModelContainer
    let recipe: APIRecipe

    init() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        container = try ModelContainer(for: APIRecipe.self, configurations: config)

        recipe = APIRecipe(
            id: 1,
            title: "Sample Recipe",
            summary: "This is a sample recipe summary",
            image: "https",
            imageType: "jpg",
//            vegetarian: true,
//            vegan: false,
//            glutenFree: true,
//            dairyFree: false,
//            veryHealthy: false,
//            sustainable: true,
            readyInMinutes: 30,
            servings: 4,
            sourceUrl: "https://sampleurl.com",
//            cuisines: ["Italian"],
//            dishTypes: ["Main Course"],
           // sideDish: nil, diets: nil,
            analyzedInstructions: [
                Instruction(steps: [
                    Step(number: 1,
                         step: "Step 1",
                         ingredients: [
                            Ingredient(id: 1,
                                       name: "Ingredient 1" //,
                                      // image: "ingredient_image"
                                      )],
                         equipment: [Equipment(id: 0,
                                               name: "pot"
                                              )
                         ])
                ])
            ]
        )

        container.mainContext.insert(recipe)
    }
}