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
                    .frame(maxWidth: .infinity, maxHeight: 300)
            } else {
                KissAnimation()
            }
            
        }
        
//        AsyncImage(url: URL(string: recipe.image), scale: 3) { image in
//            image
//                .resizable()
//                .scaledToFill()
//                .frame(maxWidth: .infinity)
//        } placeholder: {
//            Image("Placeholder")
//                .resizable()
//                .scaledToFill()
//                .frame(maxWidth: .infinity, maxHeight: 300)
//           // KissAnimation()
//           // ProgressView()
//        }
        
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
