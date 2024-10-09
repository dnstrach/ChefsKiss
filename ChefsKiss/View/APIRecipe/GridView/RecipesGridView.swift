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
            //  ProgressView()
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
                                                .shadow(radius: 5)
                                                .overlay(alignment: .bottomTrailing) {
                                                        HeartButton(savedRecipesViewModel: savedRecipesViewModel, recipe: recipe)
                                                }
                                            
                                            Text(recipe.title)
                                                .titleStyle()
                                        } else if phase.error != nil {
                                            // Display a placeholder when loading failed
                                            Image("Placeholder")
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: geometry.size.width, height: geometry.size.height)
                                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                                .shadow(radius: 5)
                                            
//                                            Image(systemName: "questionmark.diamond")
//                                                .imageScale(.large)
//                                                .frame(width: geometry.size.width, height: geometry.size.height)
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

struct HeartButton: View {
    @Environment(\.modelContext) var modelContext
    @Query var savedRecipes: [APIRecipe]
    
    let savedRecipesViewModel: SavedRecipesViewModel
    
    let recipe: APIRecipe
    
    var body: some View {
        HeartButtonView(viewModel: savedRecipesViewModel, recipe: recipe)
            .offset(x: 5)
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .multilineTextAlignment(.center)
            .lineLimit(2)
            .fixedSize(horizontal: false, vertical: true)
            .font(.title3)
            .foregroundStyle(Color.primary)
    }
}

//struct Image: ViewModifier {
//    func body(content: Content) -> some View {
//        content
//    }
//}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
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


