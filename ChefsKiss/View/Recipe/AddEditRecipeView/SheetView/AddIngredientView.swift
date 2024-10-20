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
    
    var body: some View {
        VStack {
            HStack {
                TextField("Qty", value: $viewModel.measurement, format: .number)
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(.textfield)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .keyboardType(.decimalPad)
                    .frame(width: 60)
                
                TextField("Ingredient", text: $viewModel.ingredientName)
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(.textfield)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
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
                AddButtonLabelView(text: "Add Ingredient")
            }
            .disabled(viewModel.disableIngredient)
        }
        .padding(.vertical)
    }
}

#Preview {
    AddIngredientView(viewModel: AddEditRecipeViewModel())
}
