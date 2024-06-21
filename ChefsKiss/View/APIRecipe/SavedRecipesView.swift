//
//  SavedRecipesView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 4/7/24.
//

import SwiftData
import SwiftUI

struct SavedRecipesView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query(
        sort: \APIRecipe.title,
        order: .forward
    ) var savedRecipes: [APIRecipe]
    
    @EnvironmentObject var viewModel: SavedRecipesViewModel
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                // use condition or change to switch to add a view when exceeded daily call limit
                //                if shouldShowSpinner {
                //                    ProgressView()
                //     } else {
                LazyVGrid(columns: columns) {
                    ForEach(savedRecipes, id: \.id) { recipe in
                        NavigationLink(destination: APIRecipeDetailView(recipe: recipe)) {
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
                                                        let recipes = viewModel.querySavedRecipes(savedRecipes)
                                                        
                                                        if recipes.contains(where: { $0.id == recipe.id }) {
                                                            modelContext.delete(recipe)
                                                        } else {
                                                            modelContext.insert(recipe)
                                                        }
                                                        
                                                    } label: {
                                                        let recipes = viewModel.querySavedRecipes(savedRecipes)
                                                        
                                                        ZStack {
                                                            Image(systemName: "circle.fill")
                                                                .resizable()
                                                                .foregroundStyle(.accent)
                                                                .frame(width: 35, height: 35)
                                                                .opacity(0.3)
                                                            
                                                            Image(systemName: recipes.contains(where: { $0.id == recipe.id }) ? "heart.fill" : "heart")
                                                                .imageScale(.large)
                                                        }
                                                    }
                                                    .offset(x: -5, y: -10)
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
                                                        let recipes = viewModel.querySavedRecipes(savedRecipes)
                                                        
                                                        if recipes.contains(where: { $0.id == recipe.id }) {
                                                            modelContext.delete(recipe)
                                                        } else {
                                                            modelContext.insert(recipe)
                                                        }
                                                        
                                                    } label: {
                                                        let recipes = viewModel.querySavedRecipes(savedRecipes)
                                                        
                                                        ZStack {
                                                            Image(systemName: "circle.fill")
                                                                .resizable()
                                                                .foregroundStyle(.accent)
                                                                .frame(width: 35, height: 35)
                                                                .opacity(0.3)
                                                            
                                                            Image(systemName: recipes.contains(where: { $0.id == recipe.id }) ? "heart.fill" : "heart")
                                                                .imageScale(.large)
                                                        }
                                                    }
                                                    .offset(x: -5, y: -10)
                                                }
                                            
                                            Text(recipe.title)
                                                .multilineTextAlignment(.center)
                                                .lineLimit(2)
                                            //  .frame(width: 200)
                                                .fixedSize(horizontal: false, vertical: true)
                                                .font(.title3)
                                                .foregroundStyle(Color.primary)
                                            
                                        } else {
                                            ProgressView()
                                                .frame(width: geometry.size.width, height: geometry.size.height)
                                        }
                                        
                                    }
                                }
                                .aspectRatio(contentMode: .fit)
                            }
                            .frame(width: 175, height: 225)
                            .padding(.bottom)
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
}

