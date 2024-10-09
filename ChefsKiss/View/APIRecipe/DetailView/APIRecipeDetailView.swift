//
//  RecipeDetailView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 3/14/24.
//

import SwiftData
import SwiftUI

struct APIRecipeDetailView: View {
    @Environment(\.openURL) var openURL
    @Environment(\.modelContext) var modelContext
    
    @EnvironmentObject var savedRecipesViewModel: SavedRecipesViewModel
 //   @Query var savedRecipes: [APIRecipe]
    
    @StateObject var viewModel = APIRecipeDetailViewModel()
    
    @Environment(\.dismiss) private var dismiss
    
    let recipe: APIRecipe
    
    var body: some View {
        NavigationStack {
            ScrollView {
                // .sorted for NavTitle
               // APITitleView(viewModel: viewModel, recipe: recipe)
                
              //  APIImageView(recipe: recipe)
                   // .ignoresSafeArea(.container, edges: .top)
                   // .edgesIgnoringSafeArea(.top)
                
                VStack {
                    APITitleView(viewModel: viewModel, recipe: recipe)
                    
                    IconView(recipe: recipe, viewModel: viewModel)
                    
                    APIServingsDurationView(recipe: recipe)
                    
                    APISummaryView(recipe: recipe)
                    
                    APIIngredientsView(viewModel: viewModel, recipe: recipe)
                    
                    APIEquipmentView(viewModel: viewModel, recipe: recipe)
                    
                    APIInstructionsView(recipe: recipe)
                    
                    LinkButtonView(recipe: recipe)
                }
                .safeAreaInset(edge: .top) {
                    APIImageView(recipe: recipe)
                        .overlay(alignment: .topLeading) {
                            BackButtonView()
                        }
                }
                .ignoresSafeArea(.all, edges: .all)
            }
            .ignoresSafeArea(.all, edges: .top)
            .toolbar(.hidden, for: .navigationBar)
            .statusBarHidden(true)
//            .navigationTitle(viewModel.navigationTitle(recipe: recipe)) // first 3 words
//            .navigationBarTitleDisplayMode(.large)
            
//            .toolbar {
//                ToolbarItem(placement: .topBarTrailing) {
//                    HeartToolbarButtonView(viewModel: savedRecipesViewModel, recipe: recipe)
//                }
//
        }
    }
}

#Preview {
    do {
        let preview = try APIRecipePreview()
        
        return APIRecipeDetailView(recipe: preview.recipe)
            .modelContainer(preview.container)
            .environmentObject(SavedRecipesViewModel())
    } catch {
        fatalError("Failed to create preview container.")
    }
}


