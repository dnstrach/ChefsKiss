//
//  MyRecipeListView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 3/14/24.
//

import SwiftData
import SwiftUI

struct MyRecipeListView: View {
    @Query var recipes: [Recipe]
//    @Query(
//        sort: \Recipe.title,
//        order: .forward
//    ) var recipes: [Recipe]
    @Environment(\.modelContext) var modelContext
    
    @State private var recipeToEdit: Recipe?
    @State private var showSheet = false
    @State private var newTitle = ""
    @State private var newInstructions = ""
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            Group {
                if recipes.isEmpty {
                    Button {
                        showSheet = true
                    } label: {
                        ContentUnavailableView("No Recipes", systemImage: "note.text.badge.plus", description: Text("Tap to add your first recipe."))
                    }
                    
                } else {
                    List {
                        ForEach(recipes, id: \.id) { recipe in
                            // NavigationLink(value: recipe) {
                            HStack {
                                Text(recipe.title)
                            }
                            .onTapGesture {
                                recipeToEdit = recipe
                            }
                            //  }
                        }
                        .onDelete(perform: deleteRecipe)
                    }
                    .searchable(text: $searchText)
                }
            }
            .navigationTitle("My Recipes")
            //            .navigationDestination(for: Recipe.self) { recipe in
            //                EditRecipeView(recipe: recipe)
            //            }
            .toolbar {
                if !recipes.isEmpty {
                    Button("Add") {
                        showSheet.toggle()
                    }
                }
            }
            .sheet(isPresented: $showSheet) {
                NavigationStack {
                    Form {
                        TextField("Title", text: $newTitle)
                        TextField("Instructions", text: $newInstructions, axis: .vertical)
                    }
                    .navigationTitle("New Recipe")
                    .toolbar {
                        ToolbarItemGroup(placement: .topBarLeading) {
                            Button("Cancel") {
                                showSheet.toggle()
                            }
                        }
                        
                        ToolbarItemGroup(placement: .topBarTrailing) {
                            Button("Save") {
                                let recipe = Recipe(title: newTitle, instructions: newInstructions)
                                modelContext.insert(recipe)
                                showSheet.toggle()
                            }
                        }
                    }
                }
            }
            .sheet(item: $recipeToEdit) { recipe in
                EditRecipeView(recipe: recipe)
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
      //  .modelContainer(for: [Recipe.self], inMemory: true)
    
//        do {
//            let previewer = try Previewer()
//    
//            return MyRecipeListView()
//                .modelContainer(previewer.container)
//        } catch {
//            return Text("Failed to create preview: \(error.localizedDescription)")
//        }
}





//// fetch, delete, update
//
//// figure out navigation stack, destination, path
//struct MyRecipeListView: View {
//    @StateObject var viewModel: RecipeViewModel
//    @Environment(\.modelContext) var modelContext
//
//    @Query var recipes: [Recipe]
//
//    // @State private var path = [Recipe]()
//
//    var body: some View {
//        NavigationStack {
//            List(recipes) { recipe in
//
//
//
//
//
//
//
//
////                ForEach(viewModel.recipes) { recipe in
////                    NavigationLink(value: recipe) {
////                        Text(recipe.title)
////                    }
////                }
////                .onDelete(perform: viewModel.deleteRecipe)
//            }
//            .navigationTitle("My Recipes")
//            .navigationDestination(for: Recipe.self, destination: { recipe in
//                EditRecipeView(recipe: recipe)
//            })
//
//            .toolbar {
//                Menu("Sort", systemImage: "arrow.up.arrow.down") {
//                    Picker("Sort", selection: $viewModel.sortOrder) {
//                        Text("Name (A-Z)")
//                            .tag([SortDescriptor(\Recipe.title)])
//
//                        Text("Name (Z-A)")
//                            .tag([SortDescriptor(\Recipe.title, order: .reverse)])
//                    }
//                }
//
//
//                // edit recipe view
//
//                Button("Add Recipe", systemImage: "plus") {
//                    viewModel.addRecipe()
//                   // EditRecipeView(recipe: <#T##Recipe#>)
//                }
//
//                //Button("Add Recipe", systemImage: "plus", action: vm.addRecipe(modelContext: modelContext))
//            }
//        }
//        .searchable(text: $viewModel.searchText)
//    }
//}
//
//#Preview {
//    do {
//        let previewer = try Previewer()
//
//        return MyRecipeListView(viewModel: RecipeViewModel(modelContext: ModelContext(previewer.container)))
//            .modelContainer(previewer.container)
//    } catch {
//        return Text("Failed to create preview: \(error.localizedDescription)")
//    }
//}
//
//
