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
    
  @StateObject private var viewModel = AddRecipeViewModel()
    
    let recipe: Recipe?
    
    private var editorTitle: String {
        recipe == nil ? "Add Recipe" : "Edit Recipe"
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Title", text: $viewModel.title)
                    TextField("Summary", text: $viewModel.summary, axis: .vertical)
                }
                
                Section {
                    HStack {
                        Spacer()
                        
                        switch viewModel.imageState {
                        case .savedImage:
                            Button {
                                viewModel.clearPhoto()
                            } label: {
                                Image(systemName: "x.circle")
                            }
                        case .success:
                            Button {
                                viewModel.clearPhoto()
                            } label: {
                                Image(systemName: "x.circle")
                            }
                        default:
                            EmptyView()
                        }
                    }
                    
                    // Note: x button will not work if without HStack
                    HStack {
                        Spacer()
                        
                        ImagePickerView(
                            imageState: viewModel.imageState, recipe: recipe
                        )
                        .onAppear(perform: showSavedImage)
                        .overlay {
                            PhotosPicker(
                                "",
                                selection: $viewModel.selectedImage,
                                matching: .images,
                                photoLibrary: .shared()
                            )
                        }
                        
                        Spacer()
                    }
                }

                Section("Servings") {
                    Stepper("Serves \(viewModel.servings.formatted())", value: $viewModel.servings, in: 1...100, step: 0.5)
                }
                
                Section("Prep Time") {
                    HStack {
                        Picker("Hours", selection: $viewModel.prepHrTime) {
                            ForEach(viewModel.prepHrRange, id: \.self) { hour in
                                Text("\(hour)")
                            }
                        }
                        
                        Picker("Minutes", selection: $viewModel.prepMinTime) {
                            ForEach(viewModel.prepMinRange, id: \.self) { minute in
                                Text("\(minute)")
                            }
                        }
                    }
                }
                
                Section("Cook Time") {
                    HStack {
                        Picker("Hours", selection: $viewModel.cookHrTime) {
                            ForEach(viewModel.cookHrRange, id: \.self) { hour in
                                Text("\(hour)")
                            }
                        }
                        
                        Picker("Minutes", selection: $viewModel.cookMinTime) {
                            ForEach(viewModel.cookMinRange, id: \.self) { minute in
                                Text("\(minute)")
                            }
                        }
                    }
                }
                
                Section("Ingredients") {
                    List {
                        ForEach(viewModel.sortedIngredients, id: \.id) { ingredient in
                            HStack {
                                if ingredient.measurement == 0 {
                                    EmptyView()
                                } else {
                                    Text(ingredient.measurement, format: .number)
                                        .fontWeight(.light)
                                }
                                
                                Text(ingredient.measurementType)
                                    .fontWeight(.light)
                                
                                Text(ingredient.name)
                            }
                            .swipeActions {
                                Button(role: .destructive) {
                                    viewModel.deleteIngredient(ingredient)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                    }
                    
                    VStack {
                        HStack {
                            TextField("Qty", value: $viewModel.measureAmount, format: .number)
                                .textFieldStyle(.roundedBorder)
                                .keyboardType(.decimalPad)
                                .frame(width: 50)
                            
                            TextField("Ingredient", text: $viewModel.ingredientName)
                                .textFieldStyle(.roundedBorder)
                            
                        }
                        
                        ScrollView(.horizontal, showsIndicators: true) {
                            HStack {
                                Picker("Metric", selection: $viewModel.measurement) {
                                    ForEach(viewModel.measureTypes, id: \.self) { measure in
                                        Text(measure)
                                    }
                                }
                                .pickerStyle(.segmented)
                            }
                            .padding(.top, 10)
                            .padding(.bottom, 20)
                        }
                        
                        Button("Add Ingredient", systemImage: "plus.circle") {
                            viewModel.addIngredient()
                        }
                        .disabled(viewModel.disableIngredient)
                    }
                }
                
                Section("Equipment") {
                    List {
                        ForEach(viewModel.sortedEquipment, id: \.id) { equipment in
                            Text(equipment.name)
                                .swipeActions {
                                    Button(role: .destructive) {
                                        viewModel.deleteEquipment(equipment)
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                        }
                    }
                    
                    VStack {
                        TextField("Equipment", text: $viewModel.equipmentName)
                            .textFieldStyle(.roundedBorder)
                        
                        Button("Add Equipment", systemImage: "plus.circle") {
                            viewModel.addEquipment()
                        }
                        .disabled(viewModel.disableEquip)
                    }
                }
                
                Section("Instructions") {
                    List {
                        if !viewModel.instructions.isEmpty {
                            EditButton()
                            
                        }
                        
                        ForEach(Array(viewModel.sortedInstructions.enumerated()), id: \.offset) { index, step in
                            Text("\(index + 1). \(step.step)")
                                .swipeActions {
                                    Button(role: .destructive) {
                                        viewModel.deleteStep(step)
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                            
                        }
                        .onMove(perform: viewModel.moveStep)
                        //  .onDelete(perform: deleteStep)
                    }
                    
                    VStack {
                        HStack {
                            TextField("Step", text: $viewModel.step, axis: .vertical)
                                .textFieldStyle(.roundedBorder)
                        }
                        
                        Button("Add Step", systemImage: "plus.circle") {
                            viewModel.addStep(at: viewModel.instructions.count)
                        }
                        .disabled(viewModel.disableStep)
                    }
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
    }
    
    func showSavedImage() {
        viewModel.imageState = .savedImage
    }
    
    private func save() {
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
        
        return EditRecipeView(recipe: previewer.recipe)
            .modelContainer(previewer.container)
    } catch {
        fatalError("Failed to create preview container.")
    }
}
