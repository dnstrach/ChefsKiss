//
//  RecipeDetailView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 3/14/24.
//

import SwiftData
import SwiftUI

struct APIRecipeDetailView: View {
    let recipe: APIRecipe
    
    @Environment(\.openURL) var openURL
    
    @EnvironmentObject var favoritess: Favorites
    
    var body: some View {
        NavigationView {
            ScrollView {
                
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
                
                if !recipe.analyzedInstructions[0].steps[0].ingredients.isEmpty {
                    VStack(alignment: .leading) {
                        Text("Ingredients")
                            .font(.title2)
                        
                        ForEach(recipe.analyzedInstructions[0].steps, id: \.number) { step in
                            
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], alignment: .leading, spacing: 10) {
                                
                                ForEach(step.ingredients, id: \.id) { ingredient in
                                    Text(ingredient.name)
                                }
                            }
                        }
                    }
                    .padding()
                    .padding(.horizontal)
                    
                }

                if !recipe.analyzedInstructions[0].steps[0].equipment.isEmpty {
                    VStack(alignment: .leading) {
                        Text("Equipment")
                            .font(.title2)
                        
                        ForEach(recipe.analyzedInstructions[0].steps, id: \.number) { step in
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], alignment: .leading, spacing: 20) {
                                
                                ForEach(step.equipment, id: \.id) { equipment in
                                    Text(equipment.name)
                                }
                            }
                        }
                    }
                    .padding()
                    .padding(.horizontal)
                }
                
                VStack(alignment: .leading) {
                    Text("Steps")
                        .font(.title2)
                    
                    // analyzed instructions has more than one steps []
                    ForEach(recipe.analyzedInstructions[0].steps, id: \.number) { step in
                        Text("\(step.number). \(step.step)")
                            .padding(.bottom, 5)
                        
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
                
//                Button("Link to Recipe") {
//                    openURL(URL(string: recipe.sourceUrl)!)
//                }
//                .font(.system(.subheadline, design: .rounded))
//                .fontWeight(.bold)
//                .buttonStyle(.borderedProminent)
//                .buttonBorderShape(.capsule)
//                .controlSize(.large)
            }
            .navigationTitle(recipe.title)
            //   .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        if favoritess.contains(recipe) {
                            favoritess.remove(recipe)
                        } else {
                            favoritess.add(recipe)
                        }
                        
                    } label: {
                        Image(systemName: favoritess.contains(recipe) ? "heart.fill" : "heart")
                    }
                }
            }
        }
    }
}

#Preview {
    APIRecipeDetailView(recipe: APIRecipe.dummyRecipes[1])
        .environmentObject(Favorites())
}

