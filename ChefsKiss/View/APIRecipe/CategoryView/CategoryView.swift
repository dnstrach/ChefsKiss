//
//  CategoriesView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 3/14/24.
//

import SwiftUI

struct CategoryView: View {
    @StateObject var viewModel: CategoryViewModel
    
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                SearchBarView(searchText: $searchText)
                
                if !searchText.isEmpty {
                    SearchGridView(recipes: viewModel.recipes)
                        .alert(isPresented: $viewModel.showAlert) {
                            Alert(title: Text("Network"), message: Text(viewModel.alertMessage))
                        }
                } else {
                    ForEach(viewModel.categories, id: \.0) { category, searchParam in
                        CategoryGridView(category: category, searchParam: searchParam)
                    }
                }
            }
            .onTapGesture {
                UIApplication.shared.endEditing()
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
    CategoryView(viewModel: CategoryViewModel(searchTerm: .query("")))
        .modelContainer(for: APIRecipe.self, inMemory: true)
}

