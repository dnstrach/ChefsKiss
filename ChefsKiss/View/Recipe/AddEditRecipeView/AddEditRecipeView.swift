//
//  AddEditRecipeView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 6/26/24.
//

import Combine
import PhotosUI
import SwiftUI

struct AddEditRecipeView: View {
    @StateObject private var viewModel = AddEditRecipeViewModel()
    
    let recipe: Recipe?
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationBarView(viewModel: viewModel, recipe: recipe)
            
            Form {
                Section {
                    TitleSummaryView(viewModel: viewModel)
                }
                .listRowBackground(Color.textfield)
                
                Section {
                    ImagePickerView(
                        viewModel: viewModel, recipe: recipe
                    )
                    .onAppear(perform: showSavedImage)
                }
                .listRowBackground(Color.textfield)
                
                Section {
                    ServingsPickerView(viewModel: viewModel)
                }
                .listRowBackground(Color.textfield)
                
                Section {
                    PrepTimePickerView(viewModel: viewModel)
                }
                .listRowBackground(Color.textfield)
                
                Section {
                    CookTimePickerView(viewModel: viewModel)
                }
                .listRowBackground(Color.textfield)
                
                Section {
                    IngredientsListView(viewModel: viewModel)
                }
                .listRowBackground(Color.textfield)
                
                Section {
                    EquipmentListView(viewModel: viewModel)
                }
                .listRowBackground(Color.textfield)
                
                Section {
                    InstructionsListView(viewModel: viewModel)
                }
                .listRowBackground(Color.textfield)
            }
            .scrollContentBackground(.hidden)
            .background(.accent1)
            .onAppear {
                if let recipe {
                    viewModel.title = recipe.title
                    viewModel.summary = recipe.summary
                    viewModel.servings = recipe.servings
                    viewModel.prepTime = recipe.prepTime
                    viewModel.cookTime = recipe.cookTime
                    viewModel.ingredients = recipe.ingredients
                    viewModel.instructions = recipe.instructions
                    viewModel.appliances = recipe.appliances
                }
            }
            .scrollDismissesKeyboard(.immediately)
            .sheet(item: $viewModel.selectedEquipment) { equipment in
                EditEquipmentSheetView(viewModel: viewModel, equipment: equipment)
                    .sheetBackground()
                    .presentationDetents([.fraction(0.25)])
            }
            .sheet(item: $viewModel.selectedInstruction) { instruction in
                EditInstructionSheetView(viewModel: viewModel, instruction: instruction)
                    .sheetBackground()
                    .presentationDetents([.fraction(0.25)])
            }
            .sheet(item: $viewModel.selectedIngredient) { ingredient in
                EditIngredientSheetView(viewModel: viewModel, ingredient: ingredient)
                    .sheetBackground()
                    .presentationDetents([.fraction(0.40)])
            }
        }
        .background(.textfield)
    }
    
    func showSavedImage() {
        if let recipe = recipe {
            if recipe.image != nil {
                viewModel.imageState = .savedImage
            }
        }
    }
}

#Preview {
    do {
        let previewer = try RecipePreview()
        
        return AddEditRecipeView(recipe: previewer.recipe)
            .modelContainer(previewer.container)
    } catch {
        fatalError("Failed to create preview container.")
    }
}
