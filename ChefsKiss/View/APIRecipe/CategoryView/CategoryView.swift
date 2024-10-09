//
//  CategoriesView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 3/14/24.
//

import SwiftUI

struct CategoryView: View {
    
    @StateObject var viewModel: CategoryViewModel
    
  //  @State private var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                SearchBarView(viewModel: viewModel, searchText: $viewModel.searchText)
                    .submitLabel(.search)
                
                if viewModel.showSearchView {
                    RecipesGridView(recipes: viewModel.cachedRecipes, shouldShowSpinner: viewModel.shouldShowSpinner)
                        .alert(isPresented: $viewModel.showAlert) {
                            Alert(title: Text("Network"), message: Text(viewModel.alertMessage))
                    
//                    SearchGridView(recipes: viewModel.recipes)
//                        .alert(isPresented: $viewModel.showAlert) {
//                            Alert(title: Text("Network"), message: Text(viewModel.alertMessage))
                        }
                } else {
                    ForEach(viewModel.categories, id: \.0) { category, searchParam in
                        CategoryGridView(category: category, searchParam: searchParam)
                    }
                }
            }
            .scrollDismissesKeyboard(.immediately)
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
            .navigationTitle("Recipe Finder")
            .onSubmit {
                Task {
                    await viewModel.searchRecipes(query: viewModel.searchText)
                }
                
                viewModel.showSearchView.toggle()
            }
//            .onChange(of: searchText) { _, newSearchText in
//                Task {
//                    await viewModel.searchRecipes(query: newSearchText)
//                }
//            }
        }
    }
}

#Preview {
    CategoryView(viewModel: CategoryViewModel(searchTerm: .query("")))
        .modelContainer(for: APIRecipe.self, inMemory: true)
}

