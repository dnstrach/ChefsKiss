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
    let recipe: MyRecipe

    init() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        container = try ModelContainer(for: MyRecipe.self, configurations: config)
        
        let image = UIImage(named: "italian")
        let imageData = image?.jpegData(compressionQuality: 1.0)

        recipe = MyRecipe(
            title: "Pesto Lemon Pasta with Vegetables",
            summary: "This is recipe summary.",
            image: imageData,
            servings: 6,
            prepTime: 30,
            cookTime: 2,
            ingredients: [
                MyRecipe.Ingredient(
                    name: "basil",
                    measurement: 1,
                    measurementType: "cup"
                )],
            steps: [
                MyRecipe.Instruction(
                    index: 0,
                    step: "chop basil leaves"
                )],
            appliances: [
                MyRecipe.Equipment(
                    name: "bowl"
                )]
        )

        container.mainContext.insert(recipe)
    }
}

