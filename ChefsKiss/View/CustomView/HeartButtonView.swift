//
//  HeartToolbarView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 9/16/24.
//

import SwiftData
import SwiftUI


/* BUG: DISCONNECT WHEN REMOVING A RECIPE FROM @QUERY SAVED RECIPES
 FROM EXPLOREVIEW --- RECIPEGRIDVIEW, BUT NOT FROM SAVEDRECIPESVIEW
 
 AFTER CLICKING HEART BUTTON @QUERY SAVEDRECIPES DOES NOT UPDATE
 FOR ADDING OR DELETING A RECIPE UNTIL NEXT CLICK
*/
struct HeartButtonView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query var savedRecipes: [APIRecipe]

    let recipe: APIRecipe
    
    var body: some View {
        Button {
            print("[")
            for recipe in savedRecipes {
                print("ID: \(recipe.id), \(recipe.title)")
            }
            print("]")
            print("TAPPED RECIPE: \(recipe.id) \(recipe.title)")
            
            if savedRecipes.contains(where: { $0.id == recipe.id }) {
                modelContext.delete(recipe)
                print("FOUND AND DELETED")
            } else {
                modelContext.insert(recipe)
                print("FOUND AND ADDED")
            }
            
            print("[")
            for recipe in savedRecipes {
                print("ID: \(recipe.id), \(recipe.title)")
            }
            print("]")
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
