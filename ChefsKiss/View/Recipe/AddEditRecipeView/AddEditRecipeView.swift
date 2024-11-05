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
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    
    @StateObject private var viewModel = AddEditRecipeViewModel()
    
    let recipe: Recipe?
    
    var body: some View {
        NavigationStack {
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
                } header: {
                    Text("PREP TIME")
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                }
                .listRowBackground(Color.textfield)
                
                Section {
                    CookTimePickerView(viewModel: viewModel)
                } header: {
                    Text("COOK TIME")
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
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
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(recipe == nil ? "Add Recipe" : "Edit Recipe")
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        withAnimation {
                            save()
                            dismiss()
                        }
                    }
                    .disabled(viewModel.disableForm)
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .scrollDismissesKeyboard(.immediately)
        }
        .sheet(item: $viewModel.selectedEquipment) { equipment in
            EditEquipmentSheetView(viewModel: viewModel, equipment: equipment)
                .sheetBackground()
        }
        .sheet(item: $viewModel.selectedInstruction) { instruction in
            EditInstructionSheetView(viewModel: viewModel, instruction: instruction)
                .sheetBackground()
        }
        .sheet(item: $viewModel.selectedIngredient) { ingredient in
            EditIngredientSheetView(viewModel: viewModel, ingredient: ingredient)
                .sheetBackground()
        }
    }
    
    func showSavedImage() {
        if let recipe = recipe {
            if recipe.image != nil {
                viewModel.imageState = .savedImage
            }
        }
    }
    
    func save() {
        if let recipe {
            recipe.title = viewModel.title
            recipe.summary = viewModel.summary
            recipe.servings = viewModel.servings
            recipe.prepTime = viewModel.prepTime
            recipe.cookTime = viewModel.cookTime
            recipe.ingredients = viewModel.ingredients
            recipe.instructions = viewModel.instructions
            recipe.appliances = viewModel.appliances
            
            viewModel.saveImage(recipe)
        } else {
            let newRecipe = Recipe(
                title: viewModel.title,
                summary: viewModel.summary,
                servings: viewModel.servings,
                prepTime: viewModel.prepTime,
                cookTime: viewModel.cookTime,
                ingredients: viewModel.ingredients,
                steps: viewModel.instructions,
                appliances: viewModel.appliances
            )
            
            viewModel.saveImage(newRecipe)
            context.insert(newRecipe)
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
