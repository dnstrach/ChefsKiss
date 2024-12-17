//
//  HeartToolbarView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 9/16/24.
//

import SwiftData
import SwiftUI

struct HeartButtonView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query var savedRecipes: [APIRecipe]

    let recipe: APIRecipe
    
    var body: some View {
        Button {
            print("TAPPED RECIPE: \(recipe.id) \(recipe.title)")
            print("[")
            for recipe in savedRecipes {
                print("ID: \(recipe.id), \(recipe.title)")
            }
            print("]")
            
            if savedRecipes.contains(where: { $0.id == recipe.id }) {
                modelContext.delete(recipe)
            } else {
                modelContext.insert(recipe)
            }
            
            print("[")
            for recipe in savedRecipes {
                print("ID: \(recipe.id), \(recipe.title)")
            }
            
        } label: {
            ZStack {
                Image(systemName: "circle.fill")
                    .resizable()
                    .foregroundStyle(.white)
                    .frame(width: 35, height: 35)
                    .opacity(0.4)
                
                Image(systemName: savedRecipes.contains(where: { $0.id == recipe.id }) ? "heart.fill" : "heart")
                    .foregroundStyle(.accent)
                    .imageScale(.large)
            }
            .shadow(color: Color.shadow, radius: 5)
        }
        .offset(x: -10, y: -10)
    }
}

#Preview {
    do {
        let preview = try APIRecipePreview()
        
        return HeartButtonView(recipe: preview.recipe)
            .modelContainer(preview.container)
    } catch {
        fatalError("Failed to create preview container.")
    }
}
