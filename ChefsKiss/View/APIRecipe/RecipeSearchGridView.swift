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
        GridItem(.adaptive(minimum: 150), spacing: 30)
    ]
    
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(recipes, id: \.id) { recipe in
                NavigationLink(destination: APIRecipeDetailView( recipe: recipe)) {
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
                    }
                    .frame(width: 150, height: 200)
                }
            }
        }
        .padding(.bottom, UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?
            .windows
            .first { $0.isKeyWindow }?
            .safeAreaInsets.bottom ?? 0)
    }
}

#Preview {
    RecipeSearchGridView(recipes: APIRecipe.dummyRecipes)
}
