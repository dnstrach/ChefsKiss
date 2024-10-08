//
//  RecipeServingsView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 9/17/24.
//

import SwiftUI

struct ServingsView: View {
    let recipe: Recipe
    
    var body: some View {
        VStack {
            Text("Servings: \(recipe.servings.formatted())")
                .padding(.vertical)
        }
    }
}

#Preview {
    do {
        let preview = try RecipePreview()
        
        return ServingsView(recipe: preview.recipe)
            .modelContainer(preview.container)
    } catch {
        fatalError("Failed to create preview container.")
    }
}
