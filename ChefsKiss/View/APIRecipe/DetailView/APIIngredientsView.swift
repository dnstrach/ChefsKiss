//
//  APIIngredientsView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 9/16/24.
//

import SwiftUI

struct APIIngredientsView: View {
    let viewModel: APIRecipeDetailViewModel
    
    let recipe: APIRecipe
    
    var body: some View {
        ZStack {
            RoundedRectangleView()
            
            VStack(alignment: .leading) {
                
                Text("Ingredients")
                    .font(.title2)
                    .fontDesign(.rounded)
                    .fontWeight(.bold)
                    .padding(.leading)
                    .padding(.top)
                
                let allIngredients = recipe.analyzedInstructions?.flatMap { $0.steps.flatMap { $0.ingredients } }
                
                let uniqueIngredients = viewModel.removeDuplicateIngredients(from: allIngredients ?? [])
                
                if !uniqueIngredients.isEmpty {
                    LazyVGrid(columns: viewModel.columns, alignment: .leading, spacing: 10) {
                        ForEach(uniqueIngredients, id: \.name) { ingredient in
                            HStack(spacing: 5) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundStyle(Color.accent)
                                
                                Text(ingredient.name)
                                    .frame(maxHeight: .infinity)
                                    .padding(.bottom, 5)
                                  //  .padding(.horizontal)
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.leading)
                } else {
                    HStack {
                        Text("No ingredients available")
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
        let preview = try APIRecipePreview()
        
        return APIIngredientsView(viewModel: APIRecipeDetailViewModel(), recipe: preview.recipe)
            .modelContainer(preview.container)
    } catch {
        fatalError("Failed to create preview container.")
    }
    
}
