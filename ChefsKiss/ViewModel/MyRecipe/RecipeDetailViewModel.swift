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
    func navigationTitle(recipe: Recipe) -> String {
        let title = recipe.title
        let titleWords = title.split(separator: " ")
        let threeWords = titleWords.prefix(3)
        let navigationTitle = threeWords.joined(separator: " ")
        
        return navigationTitle
    }
    
    func remainingTitle(recipe: Recipe) -> String {
        let title = recipe.title
        let titleWords = title.split(separator: " ")
        let remainingWords = titleWords.dropFirst(3)
        let remainingTitle = remainingWords.joined(separator: " ")
        
        return remainingTitle
    }
    
    func isServingsZero(recipe: Recipe) -> Bool {
        recipe.servings == 0
    }
    
    func isPrepTimeZero(recipe: Recipe) -> Bool {
        recipe.prepTime == 0
    }
    
    func isCookTimeZero(recipe: Recipe) -> Bool {
        recipe.cookTime == 0
    }

    func showServings(recipe: Recipe) -> Bool {
        !isServingsZero(recipe: recipe)
    }
    
    func showPrepTime(recipe: Recipe) -> Bool {
        !isPrepTimeZero(recipe: recipe)
    }
    
    func showCookTime(recipe: Recipe) -> Bool {
        !isCookTimeZero(recipe: recipe)
    }
}
