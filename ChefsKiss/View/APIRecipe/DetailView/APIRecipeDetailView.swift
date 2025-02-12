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
    @Environment(\.dismiss) private var dismiss

    @StateObject var viewModel = APIRecipeDetailViewModel()
    
    @State private var showScrollToTopButton = false
    
    let recipe: APIRecipe
    
    var body: some View {
        NavigationStack {
            ScrollViewReader { value in
                GeometryReader { geo in
                    ScrollView {
                        LazyVStack {
                            APITitleView(recipe: recipe)
                            
                            IconView(recipe: recipe)
                            
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
                                .id(1)
                        }
                        .ignoresSafeArea(.all, edges: .all)
                        .showScrollButton($showScrollToTopButton, geoProxy: geo)
                    }
                    .scrollButton($showScrollToTopButton, scrollProxy: value)
                }
            }
            .ignoresSafeArea(.all, edges: .top)
            .toolbar(.hidden, for: .navigationBar)
            .statusBarHidden(true)
        }
    }
}

#Preview {
    do {
        let preview = try APIRecipePreview()

        return APIRecipeDetailView(recipe: preview.recipe)
            .modelContainer(preview.container)
    } catch {
        fatalError("Failed to create preview container.")
    }
}


