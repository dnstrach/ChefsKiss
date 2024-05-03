//
//  RecipeDetailView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 4/3/24.
//

import SwiftUI

struct RecipeDetailView: View {
    @Bindable var recipe: Recipe
    
    @State private var isEditViewPresented = false
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                ScrollView {
                    VStack {
                        if let imageData = recipe.image,
                           let uiImage = UIImage(data: imageData) {
                            
                            Image(uiImage: uiImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geo.size.width, height: 300)
                                .clipped()
                        }
                        
                    }
                    
                    
                    VStack {
                            Text(recipe.summary)
                            .padding()
                        
                            Text("Serves \(recipe.servings.formatted())")

                        
                        HStack {
                            Text("Prep: \(recipe.prepHrTime) hr \(recipe.prepMinTime) min")
                            
                            Text("Cook: \(recipe.prepHrTime) hr \(recipe.prepMinTime) min")
                        }
                        .padding()
                        
                        VStack(alignment: .leading) {
                            ForEach(recipe.sortedIngredients, id:\.id) { ingredient in
                                Text("\(ingredient.measurement.formatted()) \(ingredient.measurementType) \(ingredient.name)")
                            }
                        }
                        .padding()
                        
                        HStack {
                            VStack(alignment: .leading) {
                                ForEach(recipe.sortedSteps, id: \.id) { step in
                                    Text("\(step.index + 1). \(step.stepDetail)")
                                }
                            }
                            .padding()

                            Spacer()
                        }
                    }
                }
            }
                
            .navigationTitle(recipe.title)
            .sheet(isPresented: $isEditViewPresented) {
                EditRecipeView(recipe: recipe)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Edit") {
                        isEditViewPresented.toggle()
                    }
                }
            }
        }
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        
        return RecipeDetailView(recipe: previewer.recipe)
            .modelContainer(previewer.container)
    } catch {
        fatalError("Failed to create preview container.")
    }
}
