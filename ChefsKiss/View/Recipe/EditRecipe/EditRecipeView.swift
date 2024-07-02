//
//  EditRecipeView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 4/3/24.
//

import PhotosUI
import SwiftUI

struct EquipmentSheetEditView2: View {
    @Environment(\.dismiss) var dismiss
    
    @State var equipment: Recipe.Equipment
    
    @Binding var equipmentName: String
    
    var body: some View {
        Form {
            VStack {
                TextField("Equipment", text: $equipment.name)
                    .textFieldStyle(.roundedBorder)

                Button("Add Equipment", systemImage: "plus.circle") {
                    editEquipment(equipment)
                    dismiss()
                }
               // .disabled(viewModel.disableEquip)
            }
        }
    }
    
    func editEquipment(_ equipment: Recipe.Equipment) {
        equipmentName = equipment.name
        equipmentName = ""
    }

}

struct EditRecipeView: View {
    @State var selectedEquipment: Recipe.Equipment?
    
    // added items array
        // append items in add functions
        // if cancel then compare with recipe.model and remove items from model array
    // deleted items array
        // append deleted item to array
        // if cancel then compare with recipe.model and append items model array
//    @State private var initialIngredients: [Recipe.Ingredient] = []
//    @State private var initialEquipment: [Recipe.Equipment] = []
//    @State private var initialInstructions: [Recipe.Instruction] = []
    
    // editing item
        // textfield
        // ontap
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @Bindable var recipe: Recipe
    
    @StateObject var viewModel = EditRecipeViewModel()
    
    @State private var ingredientName: String = ""
    @State private var measureAmount: Double? = nil
    @State private var amountDouble: Double?
    @State private var measurement: String = ""

    private var disableIngredient: Bool {
        ingredientName.isReallyEmpty
    }
    
    @State private var equipmentName: String = ""
    
    private var disableEquipment: Bool {
        equipmentName.isReallyEmpty
    }
    
    @State private var stepNumber: Int = 0
    @State private var step: String = ""
    
    private var disableStep: Bool {
        step.isReallyEmpty
    }
    
    private var sortedIngredients: [Recipe.Ingredient] {
        recipe.ingredients.sorted(by: {$0.name < $1.name} )
    }
    
    private var sortedEquipment: [Recipe.Equipment] {
        recipe.appliances.sorted(by: {$0.name < $1.name} )
    }
    
    private var sortedInstructions: [Recipe.Instruction] {
        recipe.instructions.sorted(by: {$0.index < $1.index} )
    }
    
    private var disableForm: Bool {
        recipe.title.isReallyEmpty
    }
    
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
                                clearPhoto()
                            } label: {
                                Image(systemName: "x.circle")
                            }
                        case .success:
                            Button {
                                clearPhoto()
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
                            ForEach(viewModel.prepHrRange, id: \.self) { hour in
                                Text("\(hour)")
                            }
                        }
                        
                        Picker("Minutes", selection: $recipe.prepMinTime) {
                            ForEach(viewModel.prepMinRange, id: \.self) { minute in
                                Text("\(minute)")
                            }
                        }
                    }
                }
                
                Section("Cook Time") {
                    HStack {
                        Picker("Hours", selection: $recipe.cookHrTime) {
                            ForEach(viewModel.cookHrRange, id: \.self) { hour in
                                Text("\(hour)")
                            }
                        }
                        
                        Picker("Minutes", selection: $recipe.cookMinTime) {
                            ForEach(viewModel.cookMinRange, id: \.self) { minute in
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
                                    ForEach(viewModel.measureTypes, id: \.self) { measure in
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
                        .disabled(disableIngredient)
                    }
                }
                
                Section("Equipment") {
                    List {
                        ForEach(sortedEquipment, id: \.id) { equipment in
                            HStack {
                                Text(equipment.name)
                            }
                            .onTapGesture {
                                selectedEquipment = equipment
                            }
                            .swipeActions {
                                Button(role: .destructive) {
                                    deleteEquipment(equipment)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                    }
                    
                    VStack {
                        TextField("Equipment", text: $equipmentName)
                            .textFieldStyle(.roundedBorder)
                        
                        Button("Add Equipment", systemImage: "plus.circle") {
                            addEquipment()
                        }
                        .disabled(disableEquipment)
                    }
                }
                
                Section("Instructions") {
                    List {
                        if !recipe.instructions.isEmpty {
                            EditButton()
                        }
                        
                        ForEach(sortedInstructions, id: \.id) { step in
                            Text("\(step.index + 1). \(step.step)")
                                .swipeActions {
                                    Button(role: .destructive) {
                                        deleteStep(step)
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                        }
                        .onMove(perform: moveStep)
                    }
                    
                    
                    VStack {
                        TextField("Step", text: $step, axis: .vertical)
                            .textFieldStyle(.roundedBorder)
                        
                        Button("Add Step", systemImage: "plus.circle") {
                            print(recipe.instructions.count)
                            addStep()
                        }
                        .disabled(disableStep)
                    }
                }
                
            }
            .navigationTitle(recipe.title)
            .navigationBarTitleDisplayMode(.inline)
            .sheet(item: $selectedEquipment) { equipment in
                EquipmentSheetEditView2(equipment: equipment, equipmentName: $equipmentName)
            }
          //  .onAppear(perform: storeInitialValues)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        do {
                            recipe.ingredients = sortedIngredients
                            recipe.appliances = sortedEquipment
                            recipe.instructions = sortedInstructions
                            
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
                     // restoreInitialValues()
                        
                        dismiss()
                    }
                }
            }
        }
    }
    
    func clearPhoto() {
        viewModel.imageState = .empty
        viewModel.selectedImage = nil
        recipe.image = nil
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
        modelContext.delete(ingredient)
        recipe.ingredients = sorted
    }
    
    func addEquipment() {
        let newEquipment = Recipe.Equipment(name: equipmentName)
        recipe.appliances.append(newEquipment)
        equipmentName = ""
    }
    
    func deleteEquipment(_ equipment: Recipe.Equipment) {
        var sorted = sortedEquipment
        sorted.removeAll(where: { $0.id == equipment.id })
        modelContext.delete(equipment)
        recipe.appliances = sorted
    }
    
    func addStep() {
        var sortedSteps = sortedInstructions
        
        stepNumber = sortedSteps.count
        let newStep = Recipe.Instruction(index: stepNumber, step: step)
        sortedSteps.append(newStep)
        step = ""
        recipe.instructions = sortedSteps
    }
    
    func deleteStep(_ step: Recipe.Instruction) {
        // get the current sorted steps
        var sortedSteps = sortedInstructions
        
        sortedSteps.removeAll(where: { $0.id == step.id })
        
        modelContext.delete(step)
        
        // reindex the remaining steps
        for (index, step) in sortedSteps.enumerated() {
            step.index = index
        }
        
        print("Sorted Steps")
        for step in sortedSteps {
            print(step.step)
        }
        print("Sorted Steps")
        
        // binding to instructions in AddRecipeViewModel?
        // recipe.instructions not getting updated???
        recipe.instructions = sortedSteps
        
        print("Recipe Steps")
        for step in recipe.instructions {
            print(step.step)
        }
       // print("Recipe Steps")
        
    }
    
    func moveStep(index: IndexSet, destination: Int) {
        var sortedSteps = sortedInstructions
        
        sortedSteps.move(fromOffsets: index, toOffset: destination)
        
        for index in index {
            
            if index - destination < 0 {
                for i in index..<destination {
                  //  print("index \(i) being changed -")
                    sortedSteps[i].index -= 1
                    }
                
                sortedSteps[destination - 1].index = destination - 1
                
            } else if index - destination > 0 {
                for i in destination..<index + 1 {
                  //  print("index \(i) being changed +")
                    sortedSteps[i].index += 1
                    }

                sortedSteps[destination].index = destination
                
            }
        }
        
        recipe.instructions = sortedSteps
    }
    
//    func storeInitialValues() {
//        initialIngredients = recipe.ingredients
//        initialEquipment = recipe.appliances
//        initialInstructions = recipe.instructions
//    }
//    
//    func restoreInitialValues() {
//        recipe.ingredients = initialIngredients
//        recipe.appliances = initialEquipment
//        recipe.instructions = initialInstructions
//    }

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



/*
 // .onDelete method
 // separate view with delete callback
 struct EditRecipeView: View {
     @Environment(\.modelContext) var modelContext
     @Environment(\.dismiss) var dismiss
     
     @Bindable var recipe: Recipe
     
     @StateObject private var viewModel = EditRecipeViewModel()
     
     var disableForm: Bool {
         recipe.title.isReallyEmpty
     }
     
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
                     
                     // Note: x button will not work if without HStack
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
                             ForEach(viewModel.prepHrRange, id: \.self) { hour in
                                 Text("\(hour)")
                             }
                         }
                         
                         Picker("Minutes", selection: $recipe.prepMinTime) {
                             ForEach(viewModel.prepMinRange, id: \.self) { minute in
                                 Text("\(minute)")
                             }
                         }
                     }
                 }
                 
                 Section("Cook Time") {
                     HStack {
                         Picker("Hours", selection: $recipe.cookHrTime) {
                             ForEach(viewModel.cookHrRange, id: \.self) { hour in
                                 Text("\(hour)")
                             }
                         }
                         
                         Picker("Minutes", selection: $recipe.cookMinTime) {
                             ForEach(viewModel.cookMinRange, id: \.self) { minute in
                                 Text("\(minute)")
                             }
                         }
                     }
                 }
                 
                 Section("Ingredients") {
                     IngredientListView2(ingredients: $recipe.ingredients, deleteCallback: deleteIngredient)
                     
                     VStack {
                         HStack {
                             TextField("Qty", value: $viewModel.measureAmount, format: .number)
                                 .keyboardType(.decimalPad)
                                 .textFieldStyle(.roundedBorder)
                                 .frame(width: 50)
                             
                             TextField("Ingredient", text: $viewModel.ingredientName)
                                 .textFieldStyle(.roundedBorder)
                         }
                         
                         ScrollView(.horizontal) {
                             HStack {
                                 Picker("Metric", selection: $viewModel.measurement) {
                                     ForEach(viewModel.measureTypes, id: \.self) { measure in
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
                         .disabled(viewModel.disableIngredient)
                     }
                 }
                 
                 Section("Equipment") {
                     EquipmentListView2(equipment: $recipe.appliances, deleteCallback: deleteEquipment)
                     
                     VStack {
                         TextField("Equipment", text: $viewModel.equipmentName)
                             .textFieldStyle(.roundedBorder)
                         
                         Button("Add Equipment", systemImage: "plus.circle") {
                             addEquipment()
                         }
                         .disabled(viewModel.disableEquipment)
                     }
                 }
                 
                 Section("Instructions") {
                     InstructionsListView2(instructions: $recipe.instructions, deleteCallback: deleteStep)
                     
                     VStack {
                         TextField("Step", text: $viewModel.step, axis: .vertical)
                             .textFieldStyle(.roundedBorder)
                         
                         Button("Add Step", systemImage: "plus.circle") {
                             addStep()
                         }
                         .disabled(viewModel.disableStep)
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
         let newIngredient = Recipe.Ingredient(name: viewModel.ingredientName, measurement: viewModel.measureAmount ?? 0, measurementType: viewModel.measurement)
         recipe.ingredients.append(newIngredient)
         viewModel.ingredientName = ""
         viewModel.measureAmount = nil
         viewModel.measurement = ""
     }
     
     func deleteIngredient(at offsets: IndexSet) {
         recipe.ingredients.remove(atOffsets: offsets)
     }
     
     func addEquipment() {
         let newEquipment = Recipe.Equipment(name: viewModel.equipmentName)
         recipe.appliances.append(newEquipment)
         viewModel.equipmentName = ""
     }
     
     func deleteEquipment(at offsets: IndexSet) {
         recipe.appliances.remove(atOffsets: offsets)
     }
     
     func addStep() {
         let newStep = Recipe.Instruction(step: viewModel.step)
         recipe.instructions.append(newStep)
         viewModel.step = ""
     }
     
     func deleteStep(at offsets: IndexSet) {
         recipe.instructions.remove(atOffsets: offsets)
     }
 }

 struct IngredientListView2: View {
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


 struct EquipmentListView2: View {
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

 struct InstructionsListView2: View {
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
     do {
         let previewer = try RecipePreview()
         
         return EditRecipeView(recipe: previewer.recipe)
             .modelContainer(previewer.container)
     } catch {
         fatalError("Failed to create preview container.")
     }
 }
 */
