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
            
            ScrollView(.horizontal, showsIndicators: true) {
                HStack {
                    Picker("Metric", selection: $viewModel.measurementType) {
                        ForEach(viewModel.measureTypes, id: \.self) { measure in
                            Text(measure)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                .padding(.horizontal)
                .padding(.top, 10)
            }
            
            Button {
                viewModel.addIngredient()
                dismiss()
            } label: {
                SheetButtonLabelView(isAddItem: showAddImage, text: "Add Ingredient")
            }
            .disabled(viewModel.disableIngredient)
        }
        .padding(.vertical)
    }
}

#Preview {
    AddIngredientView(viewModel: AddEditRecipeViewModel())
}
