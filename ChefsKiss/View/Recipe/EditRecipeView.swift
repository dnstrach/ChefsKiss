//
//  EditRecipeView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 4/3/24.
//

import PhotosUI
import SwiftUI

struct EditRecipeView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @Bindable var recipe: Recipe
    
    @StateObject private var viewModel = EditRecipeViewModel()
    
    @State private var uiImageDisplayed: UIImage? = nil
    @State private var showNewImage: Bool = false
    
    @State private var ingredientName: String = ""
    @State private var measureAmount: Double? = nil
    @State private var amountDouble: Double?
    @State private var measurement: String = ""
    
    @State private var stepNumber: Int = 0
    @State private var step: String = ""
    
    let prepHrRange = 0..<24
    let prepMinRange = 0..<60
    let cookHrRange = 0..<24
    let cookMinRange = 0..<60
    let measureTypes = ["tsp", "tbsp", "c", "pt", "qt", "gal", "oz", "fl oz", "lb", "mL", "L", "g", "kg"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Title", text: $recipe.title)
                    TextField("Summary", text: $recipe.summary, axis: .vertical)
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
                    
                    HStack {
                        Spacer()
                        
                        EditImagePickerView(
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
                
                Section {
                    Stepper("Serves \(recipe.servings.formatted())", value: $recipe.servings, in: 1...100, step: 0.5)
                }
                
                Section("Prep Time") {
                    HStack {
                        Picker("Hours", selection: $recipe.prepHrTime) {
                            ForEach(prepHrRange, id: \.self) { hour in
                                Text("\(hour)")
                            }
                        }
                        
                        Picker("Minutes", selection: $recipe.prepMinTime) {
                            ForEach(prepMinRange, id: \.self) { minute in
                                Text("\(minute)")
                            }
                        }
                    }
                }
                
                Section("Cook Time") {
                    HStack {
                        Picker("Hours", selection: $recipe.cookHrTime) {
                            ForEach(cookHrRange, id: \.self) { hour in
                                Text("\(hour)")
                            }
                        }
                        
                        Picker("Minutes", selection: $recipe.cookMinTime) {
                            ForEach(cookMinRange, id: \.self) { minute in
                                Text("\(minute)")
                            }
                        }
                    }
                }
                
                Section("Ingredients") {
                    
                    List {
                        ForEach(recipe.ingredients, id: \.self) { ingredient in
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
                                .keyboardType(.decimalPad)
                                .textFieldStyle(.roundedBorder)
                                .frame(width: 50)
                            
                            TextField("Ingredient", text: $ingredientName)
                                .textFieldStyle(.roundedBorder)
                        }
                        
                        ScrollView(.horizontal) {
                            HStack {
                                Picker("Metric", selection: $measurement) {
                                    ForEach(measureTypes, id: \.self) { measure in
                                        Text(measure)
                                    }
                                }
                                .pickerStyle(.segmented)
                            }
                            .padding()
                        }
                        
                        
                        Button("Add Ingredient", systemImage: "plus.circle") {
                            addIngredient()
                        }
                    }
                }
                
                Section("Instructions") {
                    List {
                        ForEach(sortedSteps(), id: \.id) { step in
                            Text("\(step.index + 1). \(step.stepDetail)")
                                .swipeActions {
                                    Button(role: .destructive) {
                                        deleteStep(step)
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                        }
                        //  .onDelete(perform: deleteStep)
                    }
                    
                    
                    VStack {
                        TextField("Step", text: $step, axis: .vertical)
                            .textFieldStyle(.roundedBorder)
                        
                        Button("Add Step", systemImage: "plus.circle") {
                            print(recipe.steps.count)
                            addStep()
                        }
                    }
                }
                
            }
            .navigationTitle(recipe.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        do {
                            viewModel.saveImage(recipe)

                            try modelContext.save()
                        } catch {
                            fatalError("Failed to edit recipe.")
                        }
                        
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
    
    func showSavedImage() {
        if recipe.image != nil {
            viewModel.imageState = .savedImage
        }
    }
    
    func addIngredient() {
        let newIngredient = Recipe.Ingredient(name: ingredientName, measurement: measureAmount ?? 0, measurementType: measurement)
        recipe.ingredients.append(newIngredient)
        ingredientName = ""
        measureAmount = nil
        measurement = ""
    }
    
    func deleteIngredient(at offsets: IndexSet) {
        recipe.ingredients.remove(atOffsets: offsets)
    }
    
    func sortedSteps() -> [Recipe.Step] {
        return recipe.steps.sorted { $0.index < $1.index }
    }
    
    func addStep() {
        stepNumber = recipe.steps.count
        let newStep = Recipe.Step(index: stepNumber, stepDetail: step)
        recipe.steps.append(newStep)
        step = ""
    }
    
    func deleteStep(_ step: Recipe.Step) {
        print("Deleting step with ID: \(step.id)")
            
            recipe.steps.removeAll(where: { $0.id == step.id })
            
         //   recipe.steps = sortedSteps()
            
            print("Recipe steps count after deletion: \(recipe.steps.count)")
            
            // Update step numbers for remaining steps
        for i in step.index..<recipe.steps.count {
                recipe.sortedSteps[i].index -= 1
            }

        recipe.steps = recipe.sortedSteps
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        
        return EditRecipeView(recipe: previewer.recipe)
            .modelContainer(previewer.container)
    } catch {
        fatalError("Failed to create preview container.")
    }
}
