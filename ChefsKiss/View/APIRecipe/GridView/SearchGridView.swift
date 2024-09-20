//
//  RecipeSearchGridView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 3/19/24.
//

import SwiftData
import SwiftUI

// dismiss keyboard
struct SearchGridView: View {
    @Environment(\.modelContext) var modelContext
    @Query var savedRecipes: [APIRecipe]
    @EnvironmentObject var savedRecipesViewModel: SavedRecipesViewModel
    
    let recipes: [APIRecipe]
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationStack {
            LazyVGrid(columns: columns) {
                ForEach(recipes, id: \.id) { recipe in
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
                                                HeartButton(savedRecipesViewModel: savedRecipesViewModel, recipe: recipe)
                                            }
                                        
                                        
                                        Text(recipe.title)
                                            .titleStyle()
                                        
                                    } else if phase.error != nil {
                                        Image("Placeholder")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: geometry.size.width, height: geometry.size.height)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                            .shadow(radius: 5)
                                            .overlay(alignment: .bottomTrailing) {
                                                HeartButton(savedRecipesViewModel: savedRecipesViewModel, recipe: recipe)
                                            }
                                        
                                        Text(recipe.title)
                                            .titleStyle()
                                        
                                    } else {
                                        KissAnimation()
                                       // ProgressView()
                                            .frame(width: geometry.size.width, height: geometry.size.height)
                                    }
                                    
                                }
                            }
                            .aspectRatio(contentMode: .fit)
                        }
                        .frame(width: 175, height: 225)
                        .padding(.bottom)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                        }
                    }
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
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: APIRecipe.self, configurations: config)
        
        return SearchGridView(recipes: APIRecipe.dummyRecipes)
            .environmentObject(SavedRecipesViewModel())
    } catch {
        return Text("Failed to create container \(error.localizedDescription)")
    }
}
