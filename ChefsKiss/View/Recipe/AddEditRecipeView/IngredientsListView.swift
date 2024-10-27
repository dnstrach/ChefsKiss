//
//  IngredientsListView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 9/17/24.
//

import SwiftUI

struct IngredientsListView: View {
    @ObservedObject var viewModel: AddEditRecipeViewModel
    
    @State var showAddIngredientSheet: Bool = false
    
    var body: some View {
        HStack {
            Text("INGREDIENTS")
                .foregroundStyle(.accent)
                .font(.footnote)
                .fontWeight(.bold)
            
            Spacer()
            
            PlusButtonView(showSheet: $showAddIngredientSheet)
            
          //  Spacer()
        }
        .sheet(isPresented: $showAddIngredientSheet) {
            AddIngredientView(viewModel: viewModel)
                .sheetBackground()
        }
        
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
    }
}

#Preview {
    Form {
        IngredientsListView(viewModel: AddEditRecipeViewModel())
    }
}
