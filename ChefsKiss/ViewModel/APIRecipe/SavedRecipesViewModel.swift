//
//  SavedRecipesViewModel.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 5/21/24.
//

import Foundation
import SwiftUI
import SwiftData

@MainActor
class SavedRecipesViewModel: ObservableObject {
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    func querySavedRecipes(_ savedRecipes: [APIRecipe]) -> [APIRecipe] {
        var recipes = [APIRecipe]()
        
        for recipe in savedRecipes {
            recipes.append(recipe)
        }
        
        return recipes
    }
}
