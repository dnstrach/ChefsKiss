//
//  EditIngredientSheetView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 9/19/24.
//

import SwiftUI

struct EditIngredientSheetView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel: AddEditRecipeViewModel
    
    @State var ingredient: Recipe.Ingredient
    
    @State var measurement: Double = 0
    @State var measurementType: String = ""
    @State var ingredientName: String = ""
    
    let showAddImage: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                TextField("", value: $measurement, format: .number, prompt: Text("Qty").foregroundStyle(.accent))
                    .textfieldStyle()
                    .keyboardType(.decimalPad)
                    .frame(width: 100)
                
                TextField("", text: $ingredientName, prompt: Text("Ingredient").foregroundStyle(.accent))
                    .textfieldStyle()
                
            }
            .padding(.horizontal)
            .padding(.top)
            
            MeasurementPickerView(viewModel: viewModel, selectedMeasurement: $measurementType)
            
            Button {
                editIngredient(ingredient)
                dismiss()
            } label: {
                SheetButtonLabelView(isAddItem: showAddImage, text: "Edit Ingredient")
            }
        }
        .padding(.vertical)
        .onAppear {
            storeInitialIngredient(ingredient)
        }

    }
    
    func storeInitialIngredient(_ ingredient: Recipe.Ingredient) {
        ingredientName = ingredient.name
        measurement = ingredient.measurement
        measurementType = ingredient.measurementType
    }
    
    func editIngredient(_ instruction: Recipe.Ingredient) {
        ingredient.name = ingredientName
        ingredient.measurement = measurement
        ingredient.measurementType = measurementType
    }
}

//#Preview {
//    EditIngredientSheetView()
//}
