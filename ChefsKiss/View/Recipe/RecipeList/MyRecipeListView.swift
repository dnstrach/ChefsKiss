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
                                RecipeRowView(recipe: recipe)
                            }
                            
                        }
                        .onDelete(perform: deleteRecipe)
                    }
                }
            }
            .navigationTitle("My Recipes")
            .toolbar {
                
//                if !recipes.isEmpty {
//                    Menu("Filter/Sort", systemImage: "arrow.up.arrow.down") {
////                        Picker("Filter/Sort", selection: <#T##Binding<Hashable>#>) {
////                            
////                        }
//                    }
//                    
//                }
                
                if !recipes.isEmpty {
                    Button {
                        isAddViewPresented.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .scaleEffect(1.5)
                    }
                }
                
            }
            .sheet(isPresented: $isAddViewPresented) {
                AddEditRecipeView(recipe: nil)
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

//#Preview {
//    MyRecipeListView(sortOrder: [SortDescriptor(\Recipe.title)])
//        .modelContainer(for: Recipe.self, inMemory: true)
//}
