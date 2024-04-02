//
//  RecipeDetailView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 3/14/24.
//

import SwiftUI

struct RecipeDetailView: View {
    let recipe: APIRecipe

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Text(recipe.title)
                    Text("Duration: \(recipe.readyInMinutes) minutes")
                    
                    AsyncImage(url: URL(string: recipe.image), scale: 3) { image in
                        image
                            .resizable()
                            .scaledToFit()
                        Text(recipe.title)
                    } placeholder: {
                        ProgressView()
                    }

                    
                     Text(recipe.summary)
                    
                    ForEach(recipe.analyzedInstructions[0].steps, id: \.number) { step in
                        
                        ForEach(step.ingredients, id: \.id) { ingredient in
                            Text(ingredient.name)
                        }
                    }
                    
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
    RecipeDetailView(recipe: APIRecipe.dummyRecipes[0])
}
