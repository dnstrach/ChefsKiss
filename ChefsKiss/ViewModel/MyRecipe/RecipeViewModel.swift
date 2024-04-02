//
//  RecipeViewModel.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 3/14/24.
//

import Foundation
import SwiftData
import SwiftUI

class RecipeViewModel: ObservableObject {
    
    @Published var recipes: [Recipe] = []
    
    @State var path = [Recipe]()
    
    @State var sortOrder = [SortDescriptor(\Recipe.title)]
    @State var searchText = ""
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchRecipes()
    }
    
//    func searchRecipes(searchTerm: String) {
//        _recipes = Query(filter: #Predicate { recipe in
//            recipe.title.localizedStandardContains(searchTerm)
//        })
//    }
    
    func addRecipe() {
        let recipe = Recipe(title: "Pesto Pasta", instructions: "Instructions...")
        modelContext.insert(recipe)
        fetchRecipes()
       // path.append(recipe)
    }
    
    func deleteRecipe(at offsets: IndexSet) {
        for offset in offsets {
            let recipe = recipes[offset]
            modelContext.delete(recipe)
            fetchRecipes()
        }
    }
    
    func fetchRecipes() {
        do {
            let descriptor = FetchDescriptor<Recipe>(sortBy: [SortDescriptor(\.title)])
            recipes = try modelContext.fetch(descriptor)
        } catch {
            print("Fetch failed")
        }
        
    }
}

/*
 // created separate view for custom initializer so that query updates properly????
 init(searchString: String = "", sortOrder: [SortDescriptor<Recipe>] = []) {
     _recipes = Query(filter: #Predicate { recipe in
         if searchString.isEmpty {
             true
         } else {
             // not case sensitive
             recipe.title.localizedStandardContains(searchString)
           // || recipe.category.localizedStandardContains(searchString) // will be searched by order... title first then category
         }
         // recipe.title.contains(searchString) // case sensitive
         // true // returns all recipes
     }, sort: sortOrder)
 }
 */
