//
//  RecipeTitleView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 9/17/24.
//

import SwiftUI

struct TitleView: View {
    let viewModel: RecipeDetailViewModel
    
    let recipe: Recipe
    
    var body: some View {
        HStack {
            Text(viewModel.remainingTitle(recipe: recipe))
                .font(.system(size: 34, weight: .bold))
                .padding(.leading)
            
            Spacer()
        }
    }
}

#Preview {
    do {
        let preview = try RecipePreview()
        
        return TitleView(viewModel: RecipeDetailViewModel(), recipe: preview.recipe)
            .modelContainer(preview.container)
    } catch {
        fatalError("Failed to create preview container.")
    }
}