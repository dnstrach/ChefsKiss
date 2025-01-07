//
//  RecipesView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 11/27/24.
//

import SwiftData
import SwiftUI

// purpose of this file is to show the recipes from a category with the navtitle and alert if out of network calls
// being passed to CategoryGridView

struct RecipesView: View {
    @ObservedObject var viewModel: ExploreViewModel
    
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


#Preview {
    RecipesView(viewModel: ExploreViewModel(searchTerm: .query("muffin")))
        .modelContainer(for: APIRecipe.self, inMemory: true)
}


