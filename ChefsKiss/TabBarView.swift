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
            ExploreRecipesView(viewModel: ExploreViewModel())
                .tabItem {
                    Label("Explore", systemImage: "magnifyingglass.circle")
                }
            
            SavedRecipesView()
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
}

