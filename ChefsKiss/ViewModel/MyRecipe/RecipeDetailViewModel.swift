//
//  RecipeDetailViewModel.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 9/17/24.
//

import Foundation
import SwiftUI

class RecipeDetailViewModel: ObservableObject {
    @Published var isEditViewPresented = false
    
    let min: String = "min"
    let mins: String = "mins"
    
    let columns = [
        GridItem(.flexible(minimum: 40, maximum: 200)),
        GridItem(.flexible(minimum: 40, maximum: 200))
    ]
    
    // characters instead
//    func navigationTitle(recipe: MyRecipe) -> String {
//        let title = recipe.title
//        let titleWords = title.split(separator: " ")
//        let threeWords = titleWords.prefix(3)
//        let navigationTitle = threeWords.joined(separator: " ")
//        
//        return navigationTitle
//    }
//    
//    func remainingTitle(recipe: MyRecipe) -> String {
//        let title = recipe.title
//        let titleWords = title.split(separator: " ")
//        let remainingWords = titleWords.dropFirst(3)
//        let remainingTitle = remainingWords.joined(separator: " ")
//        
//        return remainingTitle
//    }
    
    func isServingsZero(recipe: MyRecipe) -> Bool {
        recipe.servings == 0
    }
    
    func isPrepTimeZero(recipe: MyRecipe) -> Bool {
        recipe.prepTime == 0
    }
    
    func isCookTimeZero(recipe: MyRecipe) -> Bool {
        recipe.cookTime == 0
    }

    func showServings(recipe: MyRecipe) -> Bool {
        !isServingsZero(recipe: recipe)
    }
    
    func showPrepTime(recipe: MyRecipe) -> Bool {
        !isPrepTimeZero(recipe: recipe)
    }
    
    func showCookTime(recipe: MyRecipe) -> Bool {
        !isCookTimeZero(recipe: recipe)
    }
}
