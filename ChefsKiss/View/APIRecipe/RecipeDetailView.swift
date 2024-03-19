//
//  RecipeDetailView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 3/14/24.
//

import SwiftUI

// API RECIPE DETAIL VIEW

struct RecipeDetailView: View {
    //@ObservedObject var vm: APIRecipeViewModel
    let recipe: APIRecipe

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Text(recipe.title)
                    Text("Duration: \(recipe.readyInMinutes) minutes")
                     Text(recipe.summary)
                    
                    ForEach(recipe.analyzedInstructions[0].steps, id: \.number) { step in
                        
                        ForEach(step.ingredients, id: \.id) { ingredient in
                            Text(ingredient.name)
                        }
                    }
                    
                    // analyzedInstructions = [Instruction[steps[step]]]
                    // pulling out first object of steps because only object in steps containing all the steps for the recipe
                    ForEach(recipe.analyzedInstructions[0].steps, id: \.number) { step in
                        Text("\(step.number). \(step.step)")
                            .padding(.bottom, 5)
                        
                    }
                }
            }
            .navigationTitle(recipe.title)
        }
    }
}


#Preview {
    RecipeDetailView(recipe: APIRecipe.dummyRecipe)
}
