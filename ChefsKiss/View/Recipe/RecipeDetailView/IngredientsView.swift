//
//  IngredientsView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 9/17/24.
//

import SwiftUI

struct IngredientsView: View {
    @ObservedObject var viewModel: RecipeDetailViewModel
    
    let recipe: Recipe
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Ingredients")
                .font(.title2)
                .padding(.leading)
            
            LazyVGrid(columns: viewModel.columns, alignment: .leading, spacing: 10) {
                ForEach(recipe.sortedIngredients, id:\.id) { ingredient in
                    Text("\(ingredient.measurement == 0 ? "" : ingredient.measurement.formatted()) \(ingredient.measurementType) \(ingredient.name)")
                        .frame(maxHeight: .infinity)
                        .padding(.leading)
                        .padding(.bottom, 5)
                        .padding(.horizontal)
                }
            }
        }
        .padding(.bottom)
    }
}

#Preview {
    do {
        let preview = try RecipePreview()
        
        return IngredientsView(viewModel: RecipeDetailViewModel(), recipe: preview.recipe)
            .modelContainer(preview.container)
    } catch {
        fatalError("Failed to create preview container.")
    }
}
