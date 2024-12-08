//
//  PrepCookTimeView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 9/17/24.
//

import SwiftUI

struct DurationServingsView: View {
    @ObservedObject var viewModel: RecipeDetailViewModel
    
    let recipe: Recipe
    
    var body: some View {
        HStack(spacing: 10) {
            if viewModel.showPrepTime(recipe: recipe) {
                PrepTimeView(viewModel: viewModel, recipe: recipe)
            }
            
            if viewModel.showServings(recipe: recipe) {
                ServingsView(viewModel: viewModel, recipe: recipe)
            }
            
            if viewModel.showCookTime(recipe: recipe) {
                CookTimeView(viewModel: viewModel, recipe: recipe)
            }
        }
        .padding(.horizontal, 5)
    }
}

//#Preview {
//    do {
//        let preview = try RecipePreview()
//        
//        return DurationServingsView(viewModel: RecipeDetailViewModel(), recipe: preview.recipe)
//            .modelContainer(preview.container)
//    } catch {
//        fatalError("Failed to create preview container.")
//    }
//}


