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
        sort: \MyRecipe.title,
        order: .forward
    ) var recipes: [MyRecipe]
    
    @Environment(\.modelContext) var modelContext
    
    @State private var searchText = ""
    @State private var isAddViewPresented = false
    
    private var filteredRecipes: [MyRecipe] {
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return recipes
        }

        return recipes.filter {
            $0.title.localizedCaseInsensitiveContains(searchText)
        }
    }
    
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
                        ForEach(filteredRecipes, id: \.id) { recipe in
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
            .searchable(
                text: $searchText,
                placement: .navigationBarDrawer(displayMode: .automatic),
                prompt: "Search recipes"
            )
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
                            .foregroundStyle(.accent1)
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
            let recipe = filteredRecipes[offset]
            modelContext.delete(recipe)
        }
    }
}

#Preview {
    MyRecipeListView()
        .modelContainer(for: MyRecipe.self, inMemory: true)
}

//#Preview {
//    MyRecipeListView(sortOrder: [SortDescriptor(\Recipe.title)])
//        .modelContainer(for: Recipe.self, inMemory: true)
//}
