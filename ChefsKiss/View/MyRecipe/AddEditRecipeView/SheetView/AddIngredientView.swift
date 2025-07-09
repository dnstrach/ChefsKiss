//
//  AddIngredientView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 10/20/24.
//

import SwiftUI

struct AddIngredientView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel: AddEditRecipeViewModel
    
    let showAddImage: Bool = true
    
    var body: some View {
        VStack {
            HStack {
                TextField("", value: $viewModel.measurement, format: .number, prompt: Text("Qty").foregroundStyle(.accent))
                    .textfieldStyle()
                    .keyboardType(.decimalPad)
                    .frame(width: 100)
                
                TextField("", text: $viewModel.ingredientName, prompt: Text("Ingredient").foregroundStyle(.accent))
                    .textfieldStyle()
                
            }
            .padding(.horizontal)
            .padding(.top)
            
            MeasurementPickerView(viewModel: viewModel, selectedMeasurement: $viewModel.measurementType)
            
            Button {
                viewModel.addIngredient()
                dismiss()
            } label: {
                SheetButtonLabelView(isAddItem: showAddImage, text: "Add Ingredient")
            }
            .disabled(viewModel.disableIngredient)
        }
        .onDisappear {
            viewModel.clearIngredient()
        }
        .padding(.vertical)
    }
}

#Preview {
    AddIngredientView(viewModel: AddEditRecipeViewModel())
}
