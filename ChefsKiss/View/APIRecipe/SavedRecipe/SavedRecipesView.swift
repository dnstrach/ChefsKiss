//
//  SavedRecipesView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 4/7/24.
//

import SwiftData
import SwiftUI

struct SavedRecipesView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query(
        sort: \APIRecipe.title,
        order: .forward
    ) var savedRecipes: [APIRecipe]
    
    var body: some View {
        NavigationStack {
            Group {
                if savedRecipes.isEmpty {
                    ContentUnavailableView("No Saved Recipes", systemImage: "heart.circle.fill", description: Text("Tap on heart buttons to save recipes."))
                        .foregroundStyle(.accent)
                    
                } else {
                    RecipesGridView(recipes: savedRecipes, shouldShowSpinner: false)
                }
            }
            .navigationTitle("Saved Recipes")
        }
    }
}

#Preview {
    SavedRecipesView()
}

