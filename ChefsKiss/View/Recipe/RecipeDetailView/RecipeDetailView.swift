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
    
    @State private var showScrollToTopButton = false
    
    @Bindable var recipe: Recipe
    
    var body: some View {
        NavigationStack {
            ScrollViewReader { value in
                GeometryReader { geo in
                    ScrollView {
                        LazyVStack {
                            TitleView(recipe: recipe)
                            
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
                                .id(1)
                                .overlay(alignment: .topLeading) {
                                    BackButtonView()
                                }
                        }
                        .ignoresSafeArea(.container, edges: .top)
                        .modifier(DetectScroll(isButtonShown: $showScrollToTopButton, geoProxy: geo))
                    }
                    .modifier(ScrollButton(isButtonShown: $showScrollToTopButton, scrollProxy: value))
                }
            }
            .ignoresSafeArea(.all, edges: .top)
            .toolbar(.hidden, for: .navigationBar)
            .statusBarHidden(true)
            .sheet(isPresented: $viewModel.isEditViewPresented) {
                AddEditRecipeView(recipe: recipe)
            }
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
