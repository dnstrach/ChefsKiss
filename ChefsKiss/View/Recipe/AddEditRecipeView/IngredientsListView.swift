//
//  IngredientsListView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 9/17/24.
//

import SwiftUI

struct IngredientsListView: View {
    @ObservedObject var viewModel: AddEditRecipeViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.sortedIngredients, id: \.id) { ingredient in
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
                .onTapGesture {
                    viewModel.selectedIngredient = ingredient
                }
                .swipeActions {
                    Button(role: .destructive) {
                        viewModel.deleteIngredient(ingredient)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
            }
        }
        .sheet(item: $viewModel.selectedIngredient) { ingredient in
            EditIngredientSheetView(viewModel: viewModel, ingredient: ingredient)
                .presentationDetents([.fraction(0.25)])
                .presentationDragIndicator(.hidden)
        }
        
        VStack {
            HStack {
                TextField("Qty", value: $viewModel.measurement, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.decimalPad)
                    .frame(width: 50)
                
                TextField("Ingredient", text: $viewModel.ingredientName)
                    .textFieldStyle(.roundedBorder)
                
            }
            
            ScrollView(.horizontal, showsIndicators: true) {
                HStack {
                    Picker("Metric", selection: $viewModel.measurementType) {
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
                viewModel.addIngredient()
                UIApplication.shared.endEditing()
            }
            .disabled(viewModel.disableIngredient)
        }
    }
}

#Preview {
    Form {
        IngredientsListView(viewModel: AddEditRecipeViewModel())
    }
}
