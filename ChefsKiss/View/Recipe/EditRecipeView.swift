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
    
    var disableForm: Bool {
        recipe.title.isReallyEmpty
    }
    
    var disableIngred: Bool {
        ingredientName.isReallyEmpty
    }
    
    var disableEquip: Bool {
        equipmentName.isReallyEmpty
    }
    
    var disableStep: Bool {
        step.isReallyEmpty
    }
    
    @State private var uiImageDisplayed: UIImage? = nil
    @State private var showNewImage: Bool = false
    
    var sortedIngredients: [Recipe.Ingredient] {
        recipe.ingredients.sorted(by: {$0.name < $1.name} )
    }
    @State private var ingredientName: String = ""
    @State private var measureAmount: Double? = nil
    @State private var amountDouble: Double?
    @State private var measurement: String = ""
    
    var sortedEquipment: [Recipe.Equipment] {
        recipe.appliances.sorted(by: {$0.name < $1.name} )
    }
    @State private var equipmentName: String = ""
    
    var sortedSteps: [Recipe.Step] {
        recipe.steps.sorted(by: {$0.index < $1.index} )
    }
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
                        ForEach(sortedIngredients, id: \.id) { ingredient in
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
                                    deleteIngredient(ingredient)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                       // .onDelete(perform: deleteIngredient)
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
                        .disabled(disableIngred)
                    }
                }
                
                Section("Equipment") {
                    List {
                        ForEach(sortedEquipment, id: \.id) { equipment in
                            Text(equipment.name)
                                .swipeActions {
                                    Button(role: .destructive) {
                                        deleteEquipment(equipment)
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                        }
                      //  .onDelete(perform: deleteEquipment)
                    }
                    
                    VStack {
                        TextField("Equipment", text: $equipmentName)
                            .textFieldStyle(.roundedBorder)
                        
                        Button("Add Equipment", systemImage: "plus.circle") {
                            addEquipment()
                        }
                        .disabled(disableEquip)
                    }
                }
                
                Section("Instructions") {
                    List {
                        if !recipe.steps.isEmpty {
                            EditButton()
                        }
                        
                        ForEach(sortedSteps, id: \.id) { step in
                            Text("\(step.index + 1). \(step.stepDetail)")
                                .swipeActions {
                                    Button(role: .destructive) {
                                        deleteStep(step)
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                        }
                        .onMove(perform: moveStep)
                       // .onDelete(perform: deleteStep2)
                    }
                    
                    
                    VStack {
                        TextField("Step", text: $step, axis: .vertical)
                            .textFieldStyle(.roundedBorder)
                        
                        Button("Add Step", systemImage: "plus.circle") {
                            print(recipe.steps.count)
                            addStep()
                        }
                        .disabled(disableStep)
                    }
                }
                
            }
            .navigationTitle(recipe.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        do {
                            viewModel.saveImage(recipe)

                            try modelContext.save()
                        } catch {
                            fatalError("Failed to edit recipe.")
                        }
                        
                        dismiss()
                    }
                    .disabled(disableForm)
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
    
    func deleteIngredient(_ ingredient: Recipe.Ingredient) {
        var sorted = sortedIngredients
        sorted.removeAll(where: { $0.id == ingredient.id })
        recipe.ingredients = sorted
    }
    
//    func deleteIngredient(at offsets: IndexSet) {
//        var sorted = sortedIngredients
//        sorted.remove(atOffsets: offsets)
//        recipe.ingredients = sorted
//    }
    
    func addEquipment() {
        let newEquipment = Recipe.Equipment(name: equipmentName)
        recipe.appliances.append(newEquipment)
        equipmentName = ""
    }
    
    func deleteEquipment(_ equipment: Recipe.Equipment) {
        var sorted = sortedEquipment
        sorted.removeAll(where: { $0.id == equipment.id })
        recipe.appliances = sorted
    }
    
//    func deleteEquipment(at offsets: IndexSet) {
//        var sorted = sortedEquipment
//        sorted.remove(atOffsets: offsets)
//        recipe.appliances = sorted
//    }
    
    func addStep() {
        var sortedSteps = sortedSteps
        
        stepNumber = sortedSteps.count
        let newStep = Recipe.Step(index: stepNumber, stepDetail: step)
        sortedSteps.append(newStep)
        step = ""
        recipe.steps = sortedSteps
    }
    
//    func deleteStep2(at offsets: IndexSet) {
//        
//        recipe.steps = sortedSteps()
//        
//       // editMode = .active
//    }
    
    func deleteStep(_ step: Recipe.Step) {
        var sortedSteps = sortedSteps
        
        for i in step.index..<sortedSteps.count {
            sortedSteps[i].index -= 1
        }
        
        sortedSteps.removeAll(where: { $0.id == step.id })
        
        recipe.steps = sortedSteps
    }
    
    // walk through code
    func moveStep(index: IndexSet, destination: Int) {
        var sortedSteps = sortedSteps
        
        print("old steps")
        
        for step in sortedSteps {
            print("index: \(step.index) step: \(step.stepDetail)")
        }
        
        sortedSteps.move(fromOffsets: index, toOffset: destination)
        
        print("steps with moved step")
        
        for step in sortedSteps {
            print("index: \(step.index) step: \(step.stepDetail)")
        }
        
        for index in index {
            print("index: \(index)")
            print("destination: \(destination)")
            
            if index - destination < 0 {
                for i in index..<destination {
                    print("index \(i) being changed -")
                    sortedSteps[i].index -= 1
                    }
                
                sortedSteps[destination - 1].index = destination - 1
                
            } else if index - destination > 0 {
                for i in destination..<index + 1 {
                    print("index \(i) being changed +")
                    sortedSteps[i].index += 1
                    }

                sortedSteps[destination].index = destination
                
            }
        }
        
        recipe.steps = sortedSteps
        
        print("new steps")
        
        for step in recipe.steps {
            print("index: \(step.index) step: \(step.stepDetail)")
        }
        
        print("end")

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
