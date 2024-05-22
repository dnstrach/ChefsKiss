//
//  RecipeDetailView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 3/14/24.
//

import SwiftData
import SwiftUI

struct APIRecipeDetailView: View {
    @Environment(\.openURL) var openURL
    @Environment(\.modelContext) var modelContext
    
    @EnvironmentObject var savedRecipesViewModel: SavedRecipesViewModel
    @Query var savedRecipes: [APIRecipe]
    
    @StateObject var viewModel = APIRecipeDetailViewModel()
    
    let recipe: APIRecipe
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    HStack {
                        Text(recipe.title)
                            .font(.system(size: 34, weight: .bold))
                            .padding(.leading)
                        
                        Spacer()
                    }
                }
                
                AsyncImage(url: URL(string: recipe.image), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                } placeholder: {
                    ProgressView()
                }
                
                HStack {
                    Text("Servings: \(recipe.servings)")
                    
                    Spacer()
                    
                    Text("Duration: \(recipe.readyInMinutes) minutes")
                }
                .padding(.horizontal, 50)
                .padding(.bottom)
                
                Text(recipe.summary.stringByStrippingHTMLTags())
                    .padding(.horizontal)
                    .padding(.bottom)
                
                VStack(alignment: .leading) {
                    Text("Ingredients")
                        .font(.title2)
                        .padding(.leading)
                    
                    let allIngredients = recipe.analyzedInstructions?.flatMap { $0.steps.flatMap { $0.ingredients } }
                    
                    let uniqueIngredients = viewModel.removeDuplicateIngredients(from: allIngredients ?? [])
                    
                    if !uniqueIngredients.isEmpty {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], alignment: .leading, spacing: 10) {
                            ForEach(uniqueIngredients, id: \.id) { ingredient in
                                Text(ingredient.name)
                                    .padding(.bottom, 5)
                                    .padding(.horizontal)
                            }
                        }
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

                VStack(alignment: .leading) {
                    Text("Equipment")
                        .font(.title2)
                        .padding(.leading)
                    
                    let allEquipment = recipe.analyzedInstructions?.flatMap { $0.steps.flatMap { $0.equipment } }
                    
                    // Remove duplicates from all ingredients
                    let uniqueEquipment = viewModel.removeDuplicateEquipment(from: allEquipment ?? [])
                    
                    if !uniqueEquipment.isEmpty {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], alignment: .leading, spacing: 10) {
                            ForEach(uniqueEquipment, id: \.id) { equipment in
                                Text(equipment.name)
                                    .padding(.bottom, 5)
                                    .padding(.horizontal)
                            }
                        }
                    } else {
                        HStack {
                            Text("No equipment available")
                                .foregroundColor(.gray)
                                .padding(.leading)
                            
                            Spacer()
                        }
                    }
                }
                .padding(.bottom)
                
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("Steps")
                            .font(.title2)
                            .padding(.leading)
                        
                        Spacer()
                    }
                    
                    // analyzed instructions has more than one steps []
                    if let instructions = recipe.analyzedInstructions, !instructions.isEmpty {
                        ForEach(instructions.flatMap { $0.steps }, id: \.number) { step in
                            Text("\(step.number). \(step.step)")
                                .padding(.bottom, 5)
                                .padding(.horizontal)
                        }
                    } else {
                        HStack {
                            Text("No instructions available")
                                .foregroundColor(.gray)
                                .padding(.leading)
                            
                            Spacer()
                        }
                    }
                }
                .padding(.bottom)
                
                Button("Link to Recipe") {
                    openURL(URL(string: recipe.sourceUrl)!)
                }
                .font(.system(.subheadline, design: .rounded))
                .fontWeight(.bold)
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                .controlSize(.large)
                .padding(.bottom)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        let recipes = savedRecipesViewModel.querySavedRecipes(savedRecipes)
                        
                        if recipes.contains(where: { $0.id == recipe.id }) {
                            modelContext.delete(recipe)
                        } else {
                            modelContext.insert(recipe)
                        }
                        
                    } label: {
                        let recipes = savedRecipesViewModel.querySavedRecipes(savedRecipes)
                        
                        Image(systemName: recipes.contains(where: { $0.id == recipe.id }) ? "heart.fill" : "heart")
                            .imageScale(.large)
                    }
                }
            }
        }
    }
}

#Preview {
    APIRecipeDetailView(recipe: APIRecipe.dummyRecipes[1])
}

