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
                
                ForEach(viewModel.categories, id: \.0) { category, searchParam in
                    
                    if !searchText.isEmpty {
                        RecipeSearchGridView(recipes: viewModel.recipes)
                        // alert is used twice - better way to write for reusable code? 
                        .alert(isPresented: $viewModel.showAlert) {
                            Alert(title: Text("Network"), message: Text(viewModel.alertMessage))
                        }
                    } else {
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
}

