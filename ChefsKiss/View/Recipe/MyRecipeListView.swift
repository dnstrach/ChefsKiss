//
//  MyRecipeListView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 3/14/24.
//

import SwiftData
import SwiftUI

// fetch, delete, update

// figure out navigation stack, destination, path
struct MyRecipeListView: View {
    @StateObject var vm: RecipeViewModel
    @Environment(\.modelContext) var modelContext
    
    // @State private var path = [Recipe]()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.recipes) { recipe in
                    NavigationLink(value: recipe) {
                        Text(recipe.title)
                    }
                }
                .onDelete(perform: vm.deleteRecipe)
            }
            .navigationTitle("My Recipes")
            .navigationDestination(for: Recipe.self, destination: { recipe in
                EditRecipeView(recipe: recipe)
            })
            
            .toolbar {
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $vm.sortOrder) {
                        Text("Name (A-Z)")
                            .tag([SortDescriptor(\Recipe.title)])
                        
                        Text("Name (Z-A)")
                            .tag([SortDescriptor(\Recipe.title, order: .reverse)])
                    }
                }
                
                
                // edit recipe view
                
                Button("Add Recipe", systemImage: "plus") {
                    vm.addRecipe()
                   // EditRecipeView(recipe: <#T##Recipe#>)
                }
                
                //Button("Add Recipe", systemImage: "plus", action: vm.addRecipe(modelContext: modelContext))
            }
        }
        .searchable(text: $vm.searchText)
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        
        return MyRecipeListView(vm: RecipeViewModel(modelContext: ModelContext(previewer.container)))
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}

