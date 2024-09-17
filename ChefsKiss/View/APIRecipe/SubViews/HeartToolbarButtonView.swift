//
//  HeartToolbarView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 9/16/24.
//

import SwiftData
import SwiftUI

struct HeartToolbarButtonView: View {
    @Environment(\.modelContext) var modelContext
    @Query var savedRecipes: [APIRecipe]
    
    let viewModel: SavedRecipesViewModel
    
    let recipe: APIRecipe
    
    var body: some View {
        Button {
            let recipes = viewModel.querySavedRecipes(savedRecipes)
            
            if recipes.contains(where: { $0.id == recipe.id }) {
                modelContext.delete(recipe)
            } else {
                modelContext.insert(recipe)
            }
            
        } label: {
            let recipes = viewModel.querySavedRecipes(savedRecipes)
            
            Image(systemName: recipes.contains(where: { $0.id == recipe.id }) ? "heart.fill" : "heart")
                .imageScale(.large)
        }
    }
}

#Preview {
    do {
        let preview = try APIRecipePreview()
        
        return HeartToolbarButtonView(viewModel: SavedRecipesViewModel(), recipe: preview.recipe)
            .modelContainer(preview.container)
            .environmentObject(SavedRecipesViewModel())
    } catch {
        fatalError("Failed to create preview container.")
    }
}
