//
//  CategoriesView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 11/27/24.
//

import SwiftUI

// CLEAN UP CODE - view may not be necessary
struct CategoriesView: View {
    @StateObject var viewModel: ExploreViewModel
    
    var body: some View {
        NavigationStack {
            RecipesGridView(recipes: viewModel.recipes, shouldShowSpinner: viewModel.shouldShowSpinner)
                .navigationTitle(viewModel.unwrappedNavTitle)
                .navigationBarTitleDisplayMode(.inline)
                .alert(isPresented: $viewModel.showAlert) {
                    Alert(title: Text("Network"), message: Text(viewModel.alertMessage))
                }
        }
    }
}

//
//#Preview {
//    RecipesView(viewModel: CategoryViewModel(searchTerm: .searchParam(param: "cuisine", value: "American")))
//        .modelContainer(for: APIRecipe.self, inMemory: true)
//}

