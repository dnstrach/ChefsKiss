//
//  MyRecipeDetailView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 3/20/24.
//

import SwiftData
import SwiftUI

struct MyRecipeDetailView: View {
    @Query var recipes: [Recipe]
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        List {
//            ForEach(recipes) { recipe in
//                NavigationLink(value: recipe) {
//                    Text(recipe.title)
//                }
            }
            // why does it not need parameter?
           // .onDelete(perform: deleteRecipe)
     //   }
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        
        return MyRecipeDetailView()
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
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
 
 // how do we know ForEach has special method?
 /*Because our ForEach was created entirely from a single array, we can actually just
  pass that index set straight to our recipe array – it has a special
  remove(atOffsets:) method that accepts an index set.*/
 func deleteRecipe(at offsets: IndexSet) {
     for offset in offsets {
         let recipe = recipes[offset]
         modelContext.delete(recipe)
     }
 }
 */



