//
//  RecipeDetailViewModel.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 9/17/24.
//

import Foundation

class RecipeDetailViewModel: ObservableObject {
    @Published var isEditViewPresented = false
    
    
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
}
