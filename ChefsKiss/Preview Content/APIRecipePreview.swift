//
//  APIRecipePreview.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 5/15/24.
//

import Foundation
import SwiftData

@MainActor
struct APIRecipePreview {
    let container: ModelContainer
    let recipe: APIRecipe

    init() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        container = try ModelContainer(for: APIRecipe.self, configurations: config)

        recipe = APIRecipe(
            id: 1,
            title: "Sample Recipe",
            summary: "This is a sample recipe summary",
            image: "https://img.spoonacular.com/recipes/756814-312x231.jpg",
            imageType: "jpg",
            isVegetarian: true,
            isVegan: false,
            isGlutenFree: true,
            isDairyFree: false,
            readyInMinutes: 30,
            servings: 4,
            sourceUrl: "https://sampleurl.com",
            analyzedInstructions: [
                Instruction(steps: [
                    Step(number: 1,
                         step: "Lorem ipsum odor amet, consectetuer adipiscing elit. Phasellus dis egestas ornare interdum fermentum pretium eu rutrum.",
                         ingredients: [
                            Ingredient(
                                id: 1,
                                name: "Ingredient 1"
                            ),
                            Ingredient(
                                id: 2,
                                name: "Ingredient 2"
                            ),
                            Ingredient(
                                id: 3,
                                name: "Ingredient 3"
                            ),
                            Ingredient(
                                id: 4,
                                name: "Ingredient 4"
                            ),
                            Ingredient(
                                id: 5,
                                name: "Ingredient 5"
                            ),
                            Ingredient(
                                id: 6,
                                name: "Ingredient 6"
                            ),
                            Ingredient(
                                id: 7,
                                name: "Ingredient 7"
                            ),
                            Ingredient(
                                id: 8,
                                name: "Ingredient 8"
                            ),
                            Ingredient(
                                id: 9,
                                name: "Ingredient 9"
                            )],
                         equipment: [
                            Equipment(
                                id: 0,
                                name: "Equipment 1"
                            ),
                            Equipment(
                                id: 1,
                                name: "Equipment 2"
                            ),
                            Equipment(
                                id: 2,
                                name: "Equipment 3"
                            ),
                            Equipment(
                                id: 3,
                                name: "Equipment 4"
                            ),
                            Equipment(
                                id: 4,
                                name: "Equipment 5"
                            )
                         ])
                ])
            ]
        )

        container.mainContext.insert(recipe)
    }
}
