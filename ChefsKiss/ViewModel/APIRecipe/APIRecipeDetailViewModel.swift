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
    let columns = [
        GridItem(.flexible(minimum: 40, maximum: 200)),
        GridItem(.flexible(minimum: 40, maximum: 200))
    ]
    
    // API contains duplicates
    func removeDuplicateIngredients(from ingredients: [Ingredient]) -> [Ingredient] {
        var ingredientSet = Set<String>()
        var uniqueIngredients = [Ingredient]()
        
        for ingredient in ingredients {
            if !ingredientSet.contains(ingredient.name) {
                uniqueIngredients.append(ingredient)
                // will only insert ingredient if set does not already contain ingredient
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
                // will only insert equipment if set does not already contain equipment
                equipmentSet.insert(equipment.name)
            }
        }
        
        return uniqueEquipment
    }
}
