//
//  CategoriesView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 3/14/24.
//

import SwiftUI

struct CategoriesView: View {
    @StateObject var viewModel: CategoriesViewModel
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                SearchBarView(searchText: $searchText)
                
                if !searchText.isEmpty {
                    RecipeSearchGridView(recipes: viewModel.recipes)
                        .alert(isPresented: $viewModel.showAlert) {
                            Alert(title: Text("Network"), message: Text(viewModel.alertMessage))
                        }
                } else {
                    ForEach(viewModel.categories, id: \.0) { category, searchParam in
                        CategoriesGridView(category: category, searchParam: searchParam)
                    }
                }
            }
            .navigationTitle("Recipe Finder")
            .onChange(of: searchText) { _, newSearchText in
                Task {
                    await viewModel.searchRecipes(query: newSearchText)
                }
            }
        }
    }
}

#Preview {
    CategoriesView(viewModel: CategoriesViewModel())
        .environmentObject(Favorites())
}

