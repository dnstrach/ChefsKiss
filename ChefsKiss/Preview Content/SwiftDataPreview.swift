//
//  SwiftDataPreview.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 3/14/24.
//

import Foundation
import SwiftData

@MainActor
struct Previewer {
    let container: ModelContainer
    let recipe: Recipe

    init() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        container = try ModelContainer(for: Recipe.self, configurations: config)

        recipe = Recipe(
            title: "Pesto Pasta",
            summary: "This is recipe summary.",
            servings: 6,
            prepHrTime: 30,
            prepMinTime: 30,
            cookHrTime: 2,
            cookMinTime: 45,
            ingredients: [
                Recipe.Ingredient(
                    name: "basil",
                    measurement: 1,
                    measurementType: "cup"
                )],
            steps: [
                Recipe.Step(
                    index: 0,
                    stepDetail: "chop basil leaves"
                )]
        )

        container.mainContext.insert(recipe)
    }
}

