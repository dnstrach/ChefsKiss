//
//  APIImageView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 9/16/24.
//

import SwiftUI

struct APIImageView: View {
    @EnvironmentObject var savedRecipesViewModel: SavedRecipesViewModel
    
    let recipe: APIRecipe
    
    var body: some View {
        //  VStack {
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
            HeartButtonView(viewModel: savedRecipesViewModel, recipe: recipe)
                .scaleEffect(1.5)
                .padding(.trailing)
        }
    }
}

//#Preview {
//    do {
//        let preview = try APIRecipePreview()
//
//        return APIImageView(recipe: preview.recipe)
//            .frame(width: 200, height: 200)
//            .modelContainer(preview.container)
//            .environmentObject(SavedRecipesViewModel())
//    } catch {
//        fatalError("Failed to create preview container.")
//    }
//}
