//
//  RecipesGridView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 3/18/24.
//

import SwiftData
import SwiftUI

struct RecipesGridView: View {
    @Environment(\.modelContext) var modelContext
    @Query var savedRecipes: [APIRecipe]
    @EnvironmentObject var savedRecipesViewModel: SavedRecipesViewModel

    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]

    let recipes: [APIRecipe]

    var shouldShowSpinner: Bool

    var body: some View {
        if shouldShowSpinner {
                KissAnimation()
        } else {
        ScrollView(showsIndicators: false) {
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
                                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.secondary))
                                                .shadow(color: Color.shadow, radius: 5)
                                                .overlay(alignment: .bottomTrailing) {
                                                    HeartButtonView(viewModel: savedRecipesViewModel, recipe: recipe)
                                                }

                                            Text(recipe.title)
                                                .titleFont()
                                        } else if phase.error != nil {
                                            Image("Placeholder")
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: geometry.size.width, height: geometry.size.height)
                                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.secondary))
                                                .shadow(color: Color.shadow, radius: 5)
                                                .overlay(alignment: .bottomTrailing) {
                                                    HeartButtonView(viewModel: savedRecipesViewModel, recipe: recipe)
                                                }

                                            Text(recipe.title)
                                                .titleFont()
                                        } else {
                                            KissAnimation()
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
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: APIRecipe.self, configurations: config)
        
        return RecipesGridView(recipes: APIRecipe.dummyRecipes, shouldShowSpinner: false)
            .environmentObject(SavedRecipesViewModel())
    } catch {
        return Text("Failed to create container \(error.localizedDescription)")
    }
}


