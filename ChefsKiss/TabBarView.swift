//
//  TabBarView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 4/1/24.
//

import SwiftUI
import SwiftData

struct TabBarView: View {
    @Binding var showLaunchAnimation: Bool
    
    var body: some View {
        TabView {
           // Group {
                CategoryView(viewModel: ExploreViewModel(searchTerm: .query("")))
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
        .onAppear {
            // Set show launch animation to false after 1.5 seconds (increase or decrease to your liking)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                showLaunchAnimation = false
            }
        }
    }
}

#Preview {
    TabBarView(showLaunchAnimation: .constant(false))
}

