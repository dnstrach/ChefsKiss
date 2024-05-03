//
//  RecipesGridView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 3/18/24.
//

import SwiftUI

struct CategoryGridView: View {
    @EnvironmentObject var favorites: Favorites
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
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
                        NavigationLink(destination: APIRecipeDetailView( recipe: recipe)) {
                            VStack {
                                GeometryReader { geometry in
                                    AsyncImage(url: URL(string: recipe.image), scale: 3) { phase in
                                        if let image = phase.image {
                                            image
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: geometry.size.width, height: geometry.size.height)
                                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                                .shadow(radius: 5)
                                                .overlay(alignment: .bottomTrailing) {
                                                    Button {
                                                        if favorites.contains(recipe) {
                                                            favorites.remove(recipe)
                                                        } else {
                                                            favorites.add(recipe)
                                                        }
                                                        
                                                    } label: {
                                                        Image(systemName: favorites.contains(recipe) ? "heart.fill" : "heart")
                                                    }
                                                 //   .offset(x: 10, y: -5)

                                                }
                                            
                                            Text(recipe.title)
                                                .multilineTextAlignment(.center)
                                                .lineLimit(2)
                                            //  .frame(width: 200)
                                                .fixedSize(horizontal: false, vertical: true)
                                                .font(.title3)
                                                .foregroundStyle(Color.primary)
                                        } else if phase.error != nil {
                                            // Display a placeholder when loading failed
                                            Image(systemName: "questionmark.diamond")
                                                .imageScale(.large)
                                                .frame(width: geometry.size.width, height: geometry.size.height)
                                                .overlay(alignment: .bottomTrailing) {
                                                    Button {
                                                        if favorites.contains(recipe) {
                                                            favorites.remove(recipe)
                                                        } else {
                                                            favorites.add(recipe)
                                                        }
                                                        
                                                    } label: {
                                                        Image(systemName: favorites.contains(recipe) ? "heart.fill" : "heart")
                                                    }
                                                    .offset(x: 10, y: -5)

                                                }
                                            
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
                            }
                            .aspectRatio(contentMode: .fit)
                        }
                        .frame(width: 175, height: 225)
                        .padding(.bottom)
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
    }
}

#Preview {
    CategoryGridView(recipes: APIRecipe.dummyRecipes, shouldShowSpinner: false)
        .environmentObject(Favorites())
}
