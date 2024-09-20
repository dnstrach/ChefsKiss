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
    
    var body: some View {
        VStack {
            HStack {
                TextField("Qty", value: $measurement, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.decimalPad)
                    .frame(width: 50)
                
                TextField("Ingredient", text: $ingredientName)
                    .textFieldStyle(.roundedBorder)
                
            }
            
            ScrollView(.horizontal, showsIndicators: true) {
                HStack {
                    Picker("Metric", selection: $measurementType) {
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
                editIngredient(ingredient)
                dismiss()
            }
        }
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
