//
//  EditRecipeView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 4/3/24.
//

import PhotosUI
import SwiftUI

struct EditRecipeView: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    
    // how to move recipe into view model???
    @Bindable var recipe: Recipe
    
    @StateObject private var viewModel = EditRecipeViewModel()
    
    var sortedIngredients: [Recipe.Ingredient] {
        recipe.ingredients.sorted(by: {$0.name < $1.name} )
    }
    
    var sortedEquipment: [Recipe.Equipment] {
        recipe.appliances.sorted(by: {$0.name < $1.name} )
    }
    
    var sortedInstructions: [Recipe.Instruction] {
        recipe.instructions.sorted(by: {$0.index < $1.index} )
    }
    
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
                        TextField("Equipment", text: $viewModel.equipmentName)
                            .textFieldStyle(.roundedBorder)
                        
                        Button("Add Equipment", systemImage: "plus.circle") {
                            addEquipment()
                        }
                        .disabled(viewModel.disableEquipment)
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
                       // .onDelete(perform: deleteStep2)
                    }
                    
                    
                    VStack {
                        TextField("Step", text: $viewModel.step, axis: .vertical)
                            .textFieldStyle(.roundedBorder)
                        
                        Button("Add Step", systemImage: "plus.circle") {
                            print(recipe.instructions.count)
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
                            
//                            recipe.title = viewModel.title
//                            recipe.summary = viewModel.summary
//                            recipe.servings = viewModel.servings
//                            recipe.prepHrTime = viewModel.prepHrTime
//                            recipe.prepMinTime = viewModel.prepMinTime
//                            recipe.cookHrTime = viewModel.cookHrTime
//                            recipe.cookMinTime = viewModel.cookMinTime
//                            recipe.ingredients = viewModel.ingredients
//                            recipe.instructions = viewModel.instructions
//                            recipe.appliances = viewModel.appliances
//                            viewModel.saveImage(recipe)

                            try context.save()
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
        let newEquipment = Recipe.Equipment(name: viewModel.equipmentName)
        recipe.appliances.append(newEquipment)
        viewModel.equipmentName = ""
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
        var sortedSteps = sortedInstructions
        
        viewModel.stepNumber = sortedSteps.count
        let newStep = Recipe.Instruction(index: viewModel.stepNumber, step: viewModel.step)
        sortedSteps.append(newStep)
        viewModel.step = ""
        recipe.instructions = sortedSteps
    }
    
    func deleteStep(_ step: Recipe.Instruction) {
        // get the current sorted steps
        var sortedSteps = sortedInstructions
        
      //   reindex the remaining steps
//        for (index, step) in sortedSteps.enumerated() {
//            step.index = index
//        }
        
        for (index, sortedStep) in sortedSteps.enumerated() {
            if index > step.index {
                sortedStep.index -= 1
            }
        }
        
        sortedSteps.removeAll(where: { $0.id == step.id })
        
        
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
