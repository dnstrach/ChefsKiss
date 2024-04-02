//
//  RecipesGridView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 3/18/24.
//

import SwiftUI

struct CategoryGridView: View {
    let columns = [
        GridItem(.adaptive(minimum: 150), spacing: 30)
    ]
    
    var recipes: [APIRecipe]
    
    var shouldShowSpinner: Bool
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            // use condition or change to switch to add a view when exceeded daily call limit
            if shouldShowSpinner {
                ProgressView()
            } else {
                LazyVGrid(columns: columns) {
                    ForEach(recipes, id: \.id) { recipe in
                        NavigationLink(destination: RecipeDetailView( recipe: recipe)) {
                            VStack {
                                GeometryReader { geometry in
                                    AsyncImage(url: URL(string: recipe.image), scale: 3) { phase in
                                        if let image = phase.image {
                                            image
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: geometry.size.width, height: geometry.size.height)
                                            
                                            Text(recipe.title)
                                                .multilineTextAlignment(.center)
                                                .lineLimit(2)
                                            //  .frame(width: 200)
                                                .fixedSize(horizontal: false, vertical: true)
                                        } else if phase.error != nil {
                                            // Display a placeholder when loading failed
                                            Image(systemName: "questionmark.diamond")
                                                .imageScale(.large)
                                                .frame(width: geometry.size.width, height: geometry.size.height)
                                            
                                            Text(recipe.title)
                                                .multilineTextAlignment(.center)
                                                .lineLimit(2)
                                                .fixedSize(horizontal: false, vertical: true)
                                        } else {
                                            ProgressView()
                                                .frame(width: geometry.size.width, height: geometry.size.height)
                                        }
                                        
                                    }
                                }
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 150, height: 200)
                            }
                        }
                    }
                }
            }
            
            
        }
        
    }
}

#Preview {
    CategoryGridView(recipes: APIRecipe.dummyRecipes, shouldShowSpinner: false)
}
