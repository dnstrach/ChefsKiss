//
//  RecipeSearchGridView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 3/19/24.
//

import SwiftUI

struct RecipeSearchGridView: View {
    
    let recipes: [APIRecipe]
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(recipes, id: \.id) { recipe in
                NavigationLink(destination: RecipeDetailView( recipe: recipe)) {
                    VStack {
                        AsyncImage(url: URL(string: recipe.image), scale: 3) { image in
                            image
                                .resizable()
                                .scaledToFit()
                            Text(recipe.title)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    RecipeSearchGridView(recipes: APIRecipe.dummyRecipes)
}
