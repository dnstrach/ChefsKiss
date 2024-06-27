//
//  MyRecipeListView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 3/14/24.
//

import SwiftData
import SwiftUI

struct MyRecipeListView: View {
    @Query(
        sort: \Recipe.title,
        order: .forward
    ) var recipes: [Recipe]
    
    @Environment(\.modelContext) var modelContext
    
    @State private var isAddViewPresented = false
    
    var body: some View {
        NavigationStack {
            Group {
                if recipes.isEmpty {
                    Button {
                        isAddViewPresented.toggle()
                    } label: {
                        ContentUnavailableView("No Recipes", systemImage: "note.text.badge.plus", description: Text("Tap to add your first recipe."))
                            .foregroundStyle(.accent)
                    }
                    
                } else {
                    List {
                        ForEach(recipes, id: \.id) { recipe in
                            NavigationLink {
                                RecipeDetailView(recipe: recipe)
                            } label: {
                                Text(recipe.title)
                            }
                            
                        }
                        .onDelete(perform: deleteRecipe)
                    }
                }
            }
            .navigationTitle("My Recipes")
            .toolbar {
                if !recipes.isEmpty {
                    Button("Add") {
                        isAddViewPresented.toggle()
                    }
                }
            }
            .sheet(isPresented: $isAddViewPresented) {
               // AddEditRecipeView(recipe: nil)
                 AddRecipeView()
            }
        }
        
    }
    
    func deleteRecipe(at offsets: IndexSet) {
        for offset in offsets {
            let recipe = recipes[offset]
            modelContext.delete(recipe)
        }
    }
}

#Preview {
    MyRecipeListView()
        .modelContainer(for: Recipe.self, inMemory: true)
}
