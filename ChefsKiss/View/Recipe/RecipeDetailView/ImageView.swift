//
//  RecipeImageView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 9/17/24.
//

import SwiftUI

struct ImageView: View {
    let recipe: Recipe
    
    let geo: GeometryProxy
    
    var body: some View {
        VStack {
            if let imageData = recipe.image,
               let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geo.size.width, height: 400)
                    .clipped()
            } else {
                Image("Placeholder")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geo.size.width, height: 400)
                    .clipped()

            }
        }
    }
}

//#Preview {
//    do {
//        let preview = try RecipePreview()
//
//        return
//            GeometryReader { geo in
//            ImageView(recipe: preview.recipe, geo: geo)
//                .modelContainer(preview.container)
//        }
//    } catch {
//        fatalError("Failed to create preview container.")
//    }
//}
