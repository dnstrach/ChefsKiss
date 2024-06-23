//
//  IngredientsListView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 6/22/24.
//

import SwiftUI

struct IngredientListView: View {
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

//#Preview {
//    IngredientsListView()
//}
