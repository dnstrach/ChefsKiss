//
//  RecipeRowView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 4/2/24.
//

import SwiftData
import SwiftUI

struct RecipeRowView: View {
    let recipe: Recipe
    
    var body: some View {
        HStack {
            if let imageData = recipe.image,
               let uiImage = UIImage(data: imageData) {
                
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.secondary))
                    .shadow(radius: 5)
            } else {
                Image("Placeholder")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.secondary))
                    .shadow(radius: 5)
            }
            
            Text(recipe.title)
                .padding()
                .font(.system(size: 25))
                .fontDesign(.rounded)
                .lineLimit(2)
        }
    }
}

#Preview {
    do {
        let preview = try MyRecipePreview()

        return RecipeRowView(recipe: preview.recipe)
            .modelContainer(preview.container)
    } catch {
        fatalError("Failed to create preview container.")
    }
}
