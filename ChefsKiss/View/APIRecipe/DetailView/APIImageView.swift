//
//  APIImageView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 9/16/24.
//

import SwiftData
import SwiftUI

struct APIImageView: View {
    @Environment(\.modelContext) var modelContext
    
    let recipe: APIRecipe
    
    var body: some View {
        AsyncImage(url: URL(string: recipe.image), scale: 3) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity)
            } else if phase.error != nil {
                Image("Placeholder")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity)
            } else {
                KissAnimation()
                    .frame(maxWidth: .infinity)
                    .frame(height: 400)
                
            }
            
        }
        .overlay(alignment: .bottomTrailing) {
            HeartButtonView(recipe: recipe)
                .scaleEffect(1.5)
                .padding(.trailing)
        }
    }
}

#Preview {
    do {
        let preview = try APIRecipePreview()

        return APIImageView(recipe: preview.recipe)
            .frame(width: 200, height: 200)
            .modelContainer(preview.container)
    } catch {
        fatalError("Failed to create preview container.")
    }
}
