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
    
    @State private var title: String = ""
    @State private var summary: String = ""
    
    @StateObject private var viewModel = AddRecipeViewModel()
    
    @State private var servings: Double = 4
    
    @State private var prepHrTime: Int = 0
    @State private var prepMinTime: Int = 0
    let prepHrRange = 0..<24
    let prepMinRange = 0..<60
    
    @State private var cookHrTime: Int = 0
    @State private var cookMinTime: Int = 0
    let cookHrRange = 0..<24
    let cookMinRange = 0..<60
    
    @State private var ingredients: [Recipe.Ingredient] = []
    @State private var ingredientName: String = ""
    @State private var measureAmount: Double? = nil
    @State private var amountDouble: Double?
    @State private var measurement: String = ""
    let measureTypes = ["tsp", "tbsp", "c", "pt", "qt", "gal", "oz", "fl oz", "lb", "mL", "L", "g", "kg"]
    
    @State private var steps: [Recipe.Step] = []
    @State private var stepNumber: Int = 0
    @State private var step: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Title", text: $title)
                    TextField("Summary", text: $summary, axis: .vertical)
                }
                
                Section {
                    HStack {
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
                    Stepper("Serves \(servings.formatted())", value: $servings, in: 1...100, step: 0.5)
                }
                
                Section("Prep Time") {
                    HStack {
                        Picker("Hours", selection: $prepHrTime) {
                            ForEach(prepHrRange, id: \.self) { hour in
                                Text("\(hour)")
                            }
                        }
                        
                        Picker("Minutes", selection: $prepMinTime) {
                            ForEach(prepMinRange, id: \.self) { minute in
                                Text("\(minute)")
                            }
                        }
                    }
                }
                
                Section("Cook Time") {
                    HStack {
                        Picker("Hours", selection: $cookHrTime) {
                            ForEach(cookHrRange, id: \.self) { hour in
                                Text("\(hour)")
                            }
                        }
                        
                        Picker("Minutes", selection: $cookMinTime) {
                            ForEach(cookMinRange, id: \.self) { minute in
                                Text("\(minute)")
                            }
                        }
                    }
                }
                
                Section("Ingredients") {
                    
                    List {
                        ForEach(ingredients, id: \.self) { ingredient in
                            HStack {
                                Text(ingredient.measurement, format: .number)
                                    .fontWeight(.light)
                                
                                Text(ingredient.measurementType)
                                    .fontWeight(.light)
                                
                                Text(ingredient.name)
                            }
                        }
                        .onDelete(perform: deleteIngredient)
                    }
                    
                    VStack {
                        HStack {
                            TextField("Qty", value: $measureAmount, format: .number)
                                .textFieldStyle(.roundedBorder)
                                .keyboardType(.decimalPad)
                                .frame(width: 50)
                            
                            TextField("Ingredient", text: $ingredientName)
                                .textFieldStyle(.roundedBorder)
                            
                        }
                        
                        ScrollView(.horizontal, showsIndicators: true) {
                            HStack {
                                Picker("Metric", selection: $measurement) {
                                    ForEach(measureTypes, id: \.self) { measure in
                                        Text(measure)
                                    }
                                }
                                .pickerStyle(.segmented)
                            }
                            
                                .padding(.top, 10)
                                .padding(.bottom, 20)
                        }
                        
                        Button("Add Ingredient", systemImage: "plus.circle") {
                            addIngredient()
                        }
                    }
                }
                
                Section("Instructions") {
                    if !steps.isEmpty {
                        EditButton()
                    }
                    
                    List {
                        ForEach(Array(steps.enumerated()), id: \.offset) { index, step in
                            Text("\(index + 1). \(step.stepDetail)")
                        }
                        .onDelete(perform: deleteStep)
                    }
                    
                    VStack {
                        HStack {
                            TextField("Step", text: $step, axis: .vertical)
                                .textFieldStyle(.roundedBorder)
                        }
                        
                        Button("Add Step", systemImage: "plus.circle") {
                            addStep(at: steps.count)
                        }
                    }
                }
            }
            .navigationTitle("New Recipe")
            .toolbar {
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        let newRecipe = Recipe(
                            title: title,
                            summary: summary,
                            servings: servings,
                            prepHrTime: prepHrTime,
                            prepMinTime: prepMinTime,
                            cookHrTime: cookHrTime,
                            cookMinTime: cookMinTime,
                            ingredients: ingredients,
                            steps: steps
                        )
                        
                        viewModel.saveImage(newRecipe)
                       // viewModel.storeImageInRecipe(newRecipe)
                        modelContext.insert(newRecipe)
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    func addIngredient() {
        let newIngredient = Recipe.Ingredient(name: ingredientName, measurement: measureAmount ?? 0, measurementType: measurement)
        ingredients.append(newIngredient)
        ingredientName = ""
        measureAmount = nil
        measurement = ""
    }
    
    func deleteIngredient(at offsets: IndexSet) {
        for offset in offsets {
            ingredients.remove(at: offset)
        }
    }
    
    func addStep(at index: Int) {
        let newStep = Recipe.Step(index: index, stepDetail: step)
        steps.append(newStep)
        step = ""
    }
    
    func deleteStep(at offsets: IndexSet) {
        steps.remove(atOffsets: offsets)
    }
}

#Preview {
    AddRecipeView()
        .modelContainer(for: Recipe.self, inMemory: true)
}
