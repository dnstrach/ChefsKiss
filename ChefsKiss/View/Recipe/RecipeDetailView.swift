//
//  RecipeDetailView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 4/3/24.
//

import SwiftData
import SwiftUI

struct RecipeDetailView: View {
    @Bindable var recipe: Recipe
    
    @State private var isEditViewPresented = false
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                ScrollView {
                    HStack {
                        Text(recipe.title)
                            .font(.system(size: 34, weight: .bold))
                            .padding(.leading)
                        
                        Spacer()
                    }
                    
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
                        
                        if (recipe.prepHrTime != 0 || recipe.prepMinTime != 0 || recipe.cookHrTime != 0 || recipe.cookMinTime != 0) {
                            HStack {
                                HStack {
                                    if recipe.prepHrTime != 0 || recipe.prepMinTime != 0 {
                                        Text("Prep:")
                                    }
                                    
                                    if recipe.prepHrTime != 0 {
                                        Text("\(recipe.prepHrTime)")
                                        Text(recipe.prepHrTime == 1 ? "hr" : "hrs")
                                    }
                                    
                                    if recipe.prepMinTime != 0 {
                                        Text("\(recipe.prepMinTime)")
                                        Text(recipe.prepMinTime == 1 ? "min" : "mins")
                                    }
                                }
                                
                                if (recipe.prepHrTime != 0 || recipe.prepMinTime != 0) && (recipe.cookHrTime != 0 || recipe.cookMinTime != 0) {
                                    Spacer()
                                }
                                
                                HStack {
                                    if recipe.cookHrTime != 0 || recipe.cookMinTime != 0 {
                                        Text("Cook:")
                                    }
                                    
                                    if recipe.cookHrTime != 0 {
                                        Text("\(recipe.cookHrTime)")
                                        Text(recipe.cookHrTime == 1 ? "hr" : "hrs")
                                    }
                                    
                                    if recipe.cookMinTime != 0 {
                                        Text("\(recipe.cookMinTime)")
                                        Text(recipe.cookMinTime == 1 ? "min" : "mins")
                                    }
                                }
                            }
                            .padding(.bottom)
                            .padding(.horizontal)
                            .padding(.horizontal)
                        }
                    }
                    
                    VStack {
                            Text(recipe.summary)
                            .padding()
                        
                        Text("Serves \(recipe.servings.formatted())")
                        .padding(.bottom)
                        
                        VStack(alignment: .leading) {
                            Text("Ingredients")
                                .font(.title2)
                                .padding(.leading)
                            
                            ForEach(recipe.sortedIngredients, id:\.id) { ingredient in
                                Text("\(ingredient.measurement == 0 ? "" : ingredient.measurement.formatted()) \(ingredient.measurementType) \(ingredient.name)")
                            }
                        }
                        .padding(.bottom)
                        
                        VStack(alignment: .leading) {
                            Text("Equipment")
                                .font(.title2)
                                .padding(.leading)
                            
                            ForEach(recipe.sortedEquipment, id:\.id) { equipment in
                                Text(equipment.name)
                            }
                        }
                        .padding(.bottom)
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Instructions")
                                    .font(.title2)
                                    .padding(.leading)
                                    .padding(.bottom)
                                
                                ForEach(recipe.sortedInstructions, id: \.id) { step in
                                    Text("\(step.index + 1). \(step.step)")
                                }
                            }
                            .padding()
                            
                            Spacer()
                        }
                    }
                }
            }
            .sheet(isPresented: $isEditViewPresented) {
               EditRecipeView(recipe: recipe)
                // AddEditRecipeView(recipe: recipe)
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
        let preview = try RecipePreview()
        
        return RecipeDetailView(recipe: preview.recipe)
            .modelContainer(preview.container)
    } catch {
        fatalError("Failed to create preview container.")
    }
}
