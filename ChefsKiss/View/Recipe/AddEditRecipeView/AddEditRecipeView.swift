//
//  AddEditRecipeView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 6/26/24.
//

import PhotosUI
import SwiftUI

struct AddEditRecipeView: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    
    @StateObject private var viewModel = AddEditRecipeViewModel()
    
    let recipe: Recipe?
    
    private var editorTitle: String {
        recipe == nil ? "Add Recipe" : "Edit Recipe"
    }
    
    var body: some View {
        NavigationStack {
            ScrollViewReader { value in
                Form {
                    TitleSummaryView(viewModel: viewModel)
                    
                    Section {
                        ImagePickerView(
                            imageState: viewModel.imageState, recipe: recipe, viewModel: viewModel
                        )
                        .onAppear(perform: showSavedImage)
                    }
                    
                    Section("Servings") {
                        ServingsPickerView(viewModel: viewModel)
                    }
                    
                    Section("Prep Time") {
                        PrepTimePickerView(viewModel: viewModel)
                    }
                    
                    Section("Cook Time") {
                        CookTimePickerView(viewModel: viewModel)
                    }
                    
                    Section("Ingredients") {
                        IngredientsListView(viewModel: viewModel)
                    }
                    .id(1)
                    .onChange(of: viewModel.ingredientName) { _, _ in
                      //  viewModel.isIngredientTextFieldTapped = true
                        value.scrollTo(1)
                    }
                    
                    Section("Equipment") {
                        EquipmentListView(viewModel: viewModel)
                    }
                    .id(2)
                    .onChange(of: viewModel.equipmentName) { _, _ in
                      //  viewModel.isEquipmentTextFieldTapped = true
                        value.scrollTo(2)
                        
                        (print("tapped equipment"))
                    }
                    
                    Section("Instructions") {
                        InstructionsListView(viewModel: viewModel)
                    }
                    .id(3)
                    .onChange(of: viewModel.step) { _, _ in
                        print(viewModel.step)
                        value.scrollTo(3)
                    }
                    

                
                }
                .onAppear {
                    if let recipe {
                        viewModel.title = recipe.title
                        viewModel.summary = recipe.summary
                        viewModel.servings = recipe.servings
                        viewModel.prepHrTime = recipe.prepHrTime
                        viewModel.prepMinTime = recipe.prepMinTime
                        viewModel.cookHrTime = recipe.cookHrTime
                        viewModel.cookMinTime = recipe.cookMinTime
                        viewModel.ingredients = recipe.ingredients
                        viewModel.instructions = recipe.instructions
                        viewModel.appliances = recipe.appliances
                    }
                }
                // .navigationTitle(editorTitle)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text(editorTitle)
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
            }
            .scrollDismissesKeyboard(.immediately)
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
            recipe.prepHrTime = viewModel.prepHrTime
            recipe.prepMinTime = viewModel.prepMinTime
            recipe.cookHrTime = viewModel.cookHrTime
            recipe.cookMinTime = viewModel.cookMinTime
            recipe.ingredients = viewModel.ingredients
            recipe.instructions = viewModel.instructions
            recipe.appliances = viewModel.appliances
            
            viewModel.saveImage(recipe)
        } else {
            let newRecipe = Recipe(
                title: viewModel.title,
                summary: viewModel.summary,
                servings: viewModel.servings,
                prepHrTime: viewModel.prepHrTime,
                prepMinTime: viewModel.prepMinTime,
                cookHrTime: viewModel.cookHrTime,
                cookMinTime: viewModel.cookMinTime,
                ingredients: viewModel.ingredients,
                steps: viewModel.instructions,
                appliances: viewModel.appliances
            )
            
            viewModel.saveImage(newRecipe)
            // viewModel.storeImageInRecipe(newRecipe)
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
