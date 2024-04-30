//
//  SavedRecipesView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 4/7/24.
//

import SwiftData
import SwiftUI

struct SavedRecipesView: View {
    
    @EnvironmentObject var favoritess: Favorites
    
    let columns = [
        GridItem(.adaptive(minimum: 150), spacing: 30)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                // use condition or change to switch to add a view when exceeded daily call limit
                //                if shouldShowSpinner {
                //                    ProgressView()
                //     } else {
                LazyVGrid(columns: columns) {
                    ForEach(Array(favoritess.savedRecipes), id: \.id) { recipe in
                        NavigationLink(destination: APIRecipeDetailView( recipe: recipe)) {
                            VStack {
                                GeometryReader { geometry in
                                    AsyncImage(url: URL(string: recipe.image), scale: 3) { phase in
                                        if let image = phase.image {
                                            image
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: geometry.size.width, height: geometry.size.height)
                                                .overlay(alignment: .bottomTrailing) {
                                                    Button {
                                                        if favoritess.contains(recipe) {
                                                            favoritess.remove(recipe)
                                                        } else {
                                                            favoritess.add(recipe)
                                                        }
                                                        
                                                    } label: {
                                                        Image(systemName: favoritess.contains(recipe) ? "heart.fill" : "heart")
                                                    }
                                                    .offset(x: 10, y: -5)

                                                }
                                            
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
                                                .overlay(alignment: .bottomTrailing) {
                                                    Button {
                                                        if favoritess.contains(recipe) {
                                                            favoritess.remove(recipe)
                                                        } else {
                                                            favoritess.add(recipe)
                                                        }
                                                        
                                                    } label: {
                                                        Image(systemName: favoritess.contains(recipe) ? "heart.fill" : "heart")
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
            .navigationTitle("Saved Recipes")
        }
    }
}

#Preview {
    SavedRecipesView()
        .environmentObject(Favorites())
}
