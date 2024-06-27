//
//  AddRecipeView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 4/3/24.
//

import SwiftUI
import PhotosUI

struct AddRecipeView: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    
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
                    
                    // Note: x button works without HStack, but not in EditView
                    HStack {
                        Spacer()
                        
                        AddImagePickerView(
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
            .navigationTitle("New Recipe")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
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
                            steps: viewModel.instructions,
                            appliances: viewModel.appliances
                        )
                        
                        viewModel.saveImage(newRecipe)
                        context.insert(newRecipe)
                        dismiss()
                    }
                    .disabled(viewModel.disableForm)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
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

/*
 struct AddRecipeView: View {
     @Environment(\.modelContext) var modelContext
     @Environment(\.dismiss) var dismiss
     
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
                     
                     // Note: x button works without HStack, but not in EditView
                     HStack {
                         Spacer()
                         
                         AddImagePickerView(
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
                     IngredientListView(ingredients: $viewModel.ingredients, deleteCallback: viewModel.deleteIngredient)
                     
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
                     EquipmentListView(equipment: $viewModel.appliances, deleteCallback: viewModel.deleteEquipment)
                     
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
                     InstructionsListView(instructions: $viewModel.instructions, deleteCallback: viewModel.deleteStep)
                     
                     VStack {
                         HStack {
                             TextField("Step", text: $viewModel.step, axis: .vertical)
                                 .textFieldStyle(.roundedBorder)
                         }
                         
                         Button("Add Step", systemImage: "plus.circle") {
                             viewModel.addStep()
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
                             steps: viewModel.instructions,
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

 struct IngredientListView: View {
     @Binding var ingredients: [Recipe.Ingredient]
     let deleteCallback: (IndexSet) -> ()
     
     var body: some View {
         List {
             ForEach(ingredients, id: \.id) { ingredient in
                 HStack {
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
                 }
             }
             .onDelete(perform: deleteCallback)
         }
     }
 }


 struct EquipmentListView: View {
     @Binding var equipment: [Recipe.Equipment]
     let deleteCallback: (IndexSet) -> ()
     
     var body: some View {
         List {
             ForEach(equipment, id: \.id) { equipment in
                 Text("\(equipment.name)")
             }
             .onDelete(perform: deleteCallback)
         }
     }
 }

 struct InstructionsListView: View {
    @Binding var instructions: [Recipe.Instruction]
     let deleteCallback: (IndexSet) -> ()
     
     var body: some View {
         List {
             ForEach(instructions, id: \.id) { step in
                 Text("\(step.step)")
             }
             .onDelete(perform: deleteCallback)
         }
     }
 }

 #Preview {
     AddRecipeView()
         .modelContainer(for: Recipe.self, inMemory: true)
 }
 */

