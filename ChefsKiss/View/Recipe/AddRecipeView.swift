//
//  AddRecipeView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 4/3/24.
//

import SwiftUI
import PhotosUI

struct AddRecipeView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @Environment(\.editMode) var editMode
    
    @StateObject private var viewModel = AddRecipeViewModel()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Title", text: $viewModel.title)
                    TextField("Summary", text: $viewModel.summary, axis: .vertical)
                }
                
                Section {
                    HStack {
                        Button {
                            
                        } label: {
                            Image(systemName: "camera.fill")
                        }

                        Spacer()
                        
                        switch viewModel.imageState {
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
                    
                    HStack {
                        Spacer()
                        ImagePickerView(
                            imageState: viewModel.imageState
                        )
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
                      //  .onDelete(perform: viewModel.deleteIngredient)
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
                        .disabled(viewModel.disableIngred)
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
                        // .onDelete(perform: viewModel.deleteEquipment)
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
                        if !viewModel.steps.isEmpty {
                            EditButton()
                                
                        }
                        
                        ForEach(Array(viewModel.sortedSteps.enumerated()), id: \.offset) { index, step in
                            Text("\(index + 1). \(step.stepDetail)")
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
                            viewModel.addStep(at: viewModel.steps.count)
                        }
                        .disabled(viewModel.disableStep)
                    }
                }
            }
            .navigationTitle("New Recipe")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        let newRecipe = Recipe(
                            title: viewModel.title,
                            summary: viewModel.summary,
                            servings: viewModel.servings,
                            prepHrTime: viewModel.prepHrTime,
                            prepMinTime: viewModel.prepMinTime,
                            cookHrTime: viewModel.cookHrTime,
                            cookMinTime: viewModel.cookMinTime,
                            ingredients: viewModel.ingredients,
                            steps: viewModel.steps,
                            appliances: viewModel.appliances
                        )
                        
                        viewModel.saveImage(newRecipe)
                       // viewModel.storeImageInRecipe(newRecipe)
                        modelContext.insert(newRecipe)
                        dismiss()
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
}

#Preview {
    AddRecipeView()
        .modelContainer(for: Recipe.self, inMemory: true)
}
