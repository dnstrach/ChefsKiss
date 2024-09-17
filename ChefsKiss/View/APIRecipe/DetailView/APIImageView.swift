//
//  APIImageView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 9/16/24.
//

import SwiftUI

struct APIImageView: View {
    let recipe: APIRecipe
    
    // add placeholder image when there's no image
    var body: some View {
        AsyncImage(url: URL(string: recipe.image), scale: 3) { image in
            image
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity)
        } placeholder: {
            ProgressView()
        }
    }
}

#Preview {
    do {
        let preview = try APIRecipePreview()
        
        return APIImageView(recipe: preview.recipe)
            .modelContainer(preview.container)
    } catch {
        fatalError("Failed to create preview container.")
    }
}
