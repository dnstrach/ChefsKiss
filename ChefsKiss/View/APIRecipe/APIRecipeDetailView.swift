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
                
                IconView(recipe: recipe, viewModel: viewModel)
                
                HStack {
                    HStack {
                        Text("Servings:")
                            .fontWeight(.bold)
                        Text("\(recipe.servings)")
                    }
                        
                    
                    Spacer()
                    
                    HStack {
                        Text("Duration:")
                            .fontWeight(.bold)
                        Text("\(recipe.readyInMinutes) minutes")
                    }
                }
                .padding(.horizontal, 50)
                .padding(.bottom)
                
                ZStack(alignment: .bottomTrailing) {
                    Text(recipe.summary.stringByStrippingHTMLTags())
                        .padding(.horizontal)
                        .padding(.horizontal)
                        .padding(.bottom)
                }
                
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
                
                
                VStack {
                    HStack {
                        Text("Steps")
                            .font(.title2)
                            .padding(.leading)
                            .padding(.bottom)
                        
                        Spacer()
                    }
                    
                    VStack(alignment: .leading) {
                        // analyzed instructions has more than one steps []
                        if let instructions = recipe.analyzedInstructions, !instructions.isEmpty {
                            ForEach(Array(instructions.flatMap { $0.steps }.enumerated()), id: \.element.step) { index, step in
                                Text("\(index + 1). \(step.step)") // Dynamically generate the step number
                                    .alignmentGuide(.leading) { dimension in
                                        dimension[.leading]
                                    }
                                    .padding(.leading)
                                    .padding(.trailing)
                                    .padding(.bottom)
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


//#Preview {
//    let iconName: IconNames
//    
//    APIRecipeDetailView(recipe: APIRecipe.dummyRecipes[1], iconName: iconName)
//        .modelContainer(for: APIRecipe.self, inMemory: true)
//}

//#Preview {
//    do {
//        let modelConfig = ModelConfiguration(isStoredInMemoryOnly: true)
//        let container = try ModelContainer(for: APIRecipe.self, configurations: modelConfig)
//        
//        return APIRecipeDetailView(recipe: APIRecipe.dummyRecipes[1])
//            .modelContainer(container)
//    } catch {
//        return Text("Failed to create model container: \(error.localizedDescription)")
//    }
//}
