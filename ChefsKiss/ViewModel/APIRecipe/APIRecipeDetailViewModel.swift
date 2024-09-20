//
//  APIRecipeDetailViewModel.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 5/21/24.
//

import Foundation
import SwiftData
import SwiftUI

@MainActor
class APIRecipeDetailViewModel: ObservableObject {
    let columns = Array(repeating: GridItem(.flexible(minimum: 40)), count: 2)
    
    func navigationTitle(recipe: APIRecipe) -> String {
        let title = recipe.title

        let titleWords = title.split(separator: " ")
        
        let threeWords = titleWords.prefix(3)
        
        let navigationTitle = threeWords.joined(separator: " ")
        
        return navigationTitle
    }
    
    func remainingTitle(recipe: APIRecipe) -> String {
        let title = recipe.title
        
        let titleWords = title.split(separator: " ")
        
        let remainingWords = titleWords.dropFirst(3)
        
        let remainingTitle = remainingWords.joined(separator: " ")
        
        return remainingTitle
    }
    
    func removeDuplicateIngredients(from ingredients: [Ingredient]) -> [Ingredient] {
        var ingredientSet = Set<String>()
        var uniqueIngredients = [Ingredient]()
        
        for ingredient in ingredients {
            if !ingredientSet.contains(ingredient.name) {
                uniqueIngredients.append(ingredient)
                ingredientSet.insert(ingredient.name)
            }
        }
        
        return uniqueIngredients
    }
    
    func removeDuplicateEquipment(from equipment: [Equipment]) -> [Equipment] {
        var equipmentSet = Set<String>()
        var uniqueEquipment = [Equipment]()
        
        for equipment in equipment {
            if !equipmentSet.contains(equipment.name) {
                uniqueEquipment.append(equipment)
                equipmentSet.insert(equipment.name)
            }
        }
        
        return uniqueEquipment
    }
    
    func removeDuplicateEquipment(recipe: APIRecipe) {
        let allEquipment = recipe.analyzedInstructions?.flatMap { $0.steps.flatMap { $0.equipment } }
        
        // Remove duplicates from all ingredients
        let equipment = removeDuplicateEquipment(from: allEquipment ?? [])
    }
    
}
