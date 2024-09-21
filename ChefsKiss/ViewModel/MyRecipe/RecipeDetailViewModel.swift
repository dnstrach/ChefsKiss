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
}
