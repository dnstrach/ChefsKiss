//
//  RecipesGridView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 3/18/24.
//

import SwiftUI

struct CategoryGridView: View {
    let columns = [
        GridItem(.adaptive(minimum: 150), spacing:  50)
    ]
    
    var recipes: [APIRecipe]
    
    var shouldShowSpinner: Bool
    
    var body: some View {
        ScrollView {
            // use condition or change to switch to add a view when exceeded daily call limit
            if shouldShowSpinner {
                ProgressView()
            } else {
                LazyVGrid(columns: columns) {
                    ForEach(recipes, id: \.id) { recipe in
                        NavigationLink(destination: RecipeDetailView( recipe: recipe)) {
                            VStack {
                                AsyncImage(url: URL(string: recipe.image), scale: 3) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                   
                                    Text(recipe.title)

                                    
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                        }
                    }
                }
            }
        }
        
    }
}

#Preview {
    CategoryGridView(recipes: APIRecipe.dummyRecipeArray, shouldShowSpinner: false)
}
