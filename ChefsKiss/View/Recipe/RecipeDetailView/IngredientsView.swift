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
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.background)
                .opacity(0.2)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.secondary))
            
            VStack(alignment: .leading) {
                Text("Ingredients")
                    .font(.title2)
                    .padding(.leading)
                    .padding(.top)
                
                if !recipe.sortedIngredients.isEmpty {
                    LazyVGrid(columns: viewModel.columns, alignment: .leading, spacing: 10) {
                        ForEach(recipe.sortedIngredients, id:\.id) { ingredient in
                            HStack(spacing: 5) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundStyle(Color.accent)
                                
                                Text("\(ingredient.measurement == 0 ? "" : ingredient.measurement.formatted()) \(ingredient.measurementType) \(ingredient.name)")
                                    .frame(maxHeight: .infinity)
                                    .padding(.bottom, 5)
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.leading)
                } else {
                    HStack {
                        Text("No ingredients listed")
                            .foregroundColor(.gray)
                            .padding(.leading)
                        
                        Spacer()
                    }
                }
            }
            .padding(.bottom)
        }
        .padding()
        .padding(.horizontal, 20)
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
