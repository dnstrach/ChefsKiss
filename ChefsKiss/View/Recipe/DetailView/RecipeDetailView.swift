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

                    TitleView(viewModel: viewModel, recipe: recipe)
                    
                    ImageView(recipe: recipe, geo: geo)
                    
                    PrepCookTimeView(recipe: recipe)
                    
                    ServingsView(recipe: recipe)
                    
                    SummaryView(recipe: recipe)
                    
                    IngredientsView(recipe: recipe)
                    
                    EquipmentView(recipe: recipe)
                    
                    InstructionsView(recipe: recipe)
                }
            }
            .navigationTitle(viewModel.navigationTitle(recipe: recipe))
            .sheet(isPresented: $viewModel.isEditViewPresented) {
//               EditRecipeView(recipe: recipe)
                 AddEditRecipeView(recipe: recipe)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Edit") {
                        viewModel.isEditViewPresented.toggle()
                    }
                }
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
