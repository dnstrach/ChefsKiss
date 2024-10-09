//
//  RecipeDetailView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 4/3/24.
//

import SwiftData
import SwiftUI

struct RecipeDetailView: View {
    @StateObject var viewModel = RecipeDetailViewModel()
    
    @Bindable var recipe: Recipe
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                ScrollView {
                    VStack {
                        TitleView(recipe: recipe)
                        
                      //  ImageView(recipe: recipe, geo: geo)
                        
                        ServingsView(recipe: recipe)
                        
                        PrepCookTimeView(recipe: recipe)
                        
                        SummaryView(recipe: recipe)
                        
                        IngredientsView(viewModel: viewModel, recipe: recipe)
                        
                        EquipmentView(viewModel: viewModel, recipe: recipe)
                        
                        InstructionsView(recipe: recipe)

                    }
                    .safeAreaInset(edge: .top) {
                        ImageView(recipe: recipe, geo: geo)
                            .overlay(alignment: .topTrailing) {
                                EditButtonView(viewModel: viewModel)
                            }
                            .overlay(alignment: .topLeading) {
                                BackButtonView()
                            }
                    }
                    .ignoresSafeArea(.container, edges: .top)

                }
            }
            .ignoresSafeArea(.all, edges: .top)
            .toolbar(.hidden, for: .navigationBar)
            .statusBarHidden(true)
          //  .navigationTitle(viewModel.navigationTitle(recipe: recipe))
            .sheet(isPresented: $viewModel.isEditViewPresented) {
//               EditRecipeView(recipe: recipe)
                 AddEditRecipeView(recipe: recipe)
            }
//            .toolbar {
//                ToolbarItem(placement: .topBarTrailing) {
//                    Button("Edit") {
//                        viewModel.isEditViewPresented.toggle()
//                    }
//                }
//            }
        }
    }
}

#Preview {
    do {
        let preview = try RecipePreview()
        
        return RecipeDetailView(recipe: preview.recipe)
            .modelContainer(preview.container)
    } catch {
        fatalError("Failed to create preview container.")
    }
}
