//
//  RecipePreview.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 5/15/24.
//

import Foundation
import SwiftData
import UIKit

@MainActor
struct MyRecipePreview {
    let container: ModelContainer
    let recipe: Recipe

    init() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        container = try ModelContainer(for: Recipe.self, configurations: config)
        
        let image = UIImage(named: "italian")
        let imageData = image?.jpegData(compressionQuality: 1.0)

        recipe = Recipe(
            title: "Pesto Lemon Pasta with Vegetables",
            summary: "This is recipe summary.",
            image: imageData,
            servings: 6,
            prepTime: 30,
            cookTime: 2,
            ingredients: [
                Recipe.Ingredient(
                    name: "basil",
                    measurement: 1,
                    measurementType: "cup"
                )],
            steps: [
                Recipe.Instruction(
                    index: 0,
                    step: "chop basil leaves"
                )],
            appliances: [
                Recipe.Equipment(
                    name: "bowl"
                )]
        )

        container.mainContext.insert(recipe)
    }
}

