//
//  CategoryView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 11/27/24.
//

import SwiftUI

import SwiftUI

// CLEAN UP CODE - view may not be necessary
// purpose of this file is to show the recipes from a category with the navtitle and alert if out of network calls
// being passed to CategoryGridView

struct RecipesView: View {
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
