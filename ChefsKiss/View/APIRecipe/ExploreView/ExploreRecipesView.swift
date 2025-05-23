//
//  CategoriesView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 3/14/24.
//

import SwiftUI

struct ExploreRecipesView: View {
    @ObservedObject var viewModel: ExploreViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                SearchBarView(viewModel: viewModel, searchText: $viewModel.searchText)
                    .submitLabel(.search)
                
                switch viewModel.exploreView {
                case .categoryResults:
                    ForEach(viewModel.categories, id: \.0) { category, searchParam in
                        CategoryGridView(category: category, searchParam: searchParam)
                        
                    }
                case .searchResults:
                    RecipesGridView(recipes: viewModel.recipes, shouldShowSpinner: viewModel.shouldShowSpinner)
                        .alert(isPresented: $viewModel.showAlert) {
                            Alert(title: Text("Network"), message: Text(viewModel.alertMessage))
                            
                        }
                case .emptySearch:
                    ContentUnavailableView("No Search Results", systemImage: "magnifyingglass.circle.fill", description: Text("Unable to find \(viewModel.searchText) recipes."))
                        .foregroundStyle(.accent)
                    
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
        }
    }
}

#Preview {
    ExploreRecipesView(viewModel: ExploreViewModel())
        .modelContainer(for: APIRecipe.self, inMemory: true)
}



