//
//  TabBarView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 4/1/24.
//

import SwiftUI

struct TabBarView: View {
    
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
            
            MyRecipeListView()
                .tabItem {
                    Label("My Recipes", systemImage: "book.closed")
                }
        }
    }
}

#Preview {
    TabBarView()
     //   .modelContainer(for: Recipe.self, inMemory: true)
}

/*
 do {
     let previewer = try Previewer()
     
     return ContentView()
         .modelContainer(previewer.container)
     
 } catch {
     return Text("Failed to create preview: \(error.localizedDescription)")
 }
 */
