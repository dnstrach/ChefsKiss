//
//  ContentView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 3/14/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        TabView {
            CategoriesView(viewModel: CategoriesViewModel())
                .tabItem {
                    Label("Explore", systemImage: "magnifyingglass.circle")
                }
            
            SavedRecipes()
                .tabItem {
                    Label("Saved", systemImage: "heart.fill")
                }
            
            AddRecipeView()
                .tabItem {
                    Label("Add Recipe", systemImage: "plus.circle.fill")
                }
            
            MyRecipeListView(vm: RecipeViewModel(modelContext: modelContext))
                .tabItem {
                    Label("My Recipes", systemImage: "book.closed")
                }

            // add recipe view
        }
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        
        return ContentView()
            .modelContainer(previewer.container)
        
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
