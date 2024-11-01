//
//  TabBarView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 4/1/24.
//

import SwiftUI
import SwiftData

struct TabBarView: View {
    var body: some View {
        TabView {
           // Group {
                CategoryView(viewModel: CategoryViewModel(searchTerm: .query("")))
                    .tabItem {
                        Label("Explore", systemImage: "magnifyingglass.circle")
                    }
                  //  .toolbarBackground(Color.accent, for: .tabBar)
                
                SavedRecipesView()
                    .tabItem {
                        Label("Saved", systemImage: "heart.fill")
                    }
                 //   .toolbarBackground(Color.accent, for: .tabBar)
                
                MyRecipeListView()
                    .tabItem {
                        Label("My Recipes", systemImage: "book.closed")
                    }
                  //  .toolbarBackground(Color.accent, for: .tabBar)
          //  }
           // .toolbarBackground(Color.accent, for: .tabBar)
        }
    }
}

#Preview {
    TabBarView()
}

