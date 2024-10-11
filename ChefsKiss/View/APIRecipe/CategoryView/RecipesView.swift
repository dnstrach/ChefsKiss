//
//  CategoryView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 3/14/24.
//

import SwiftUI

struct RecipesView: View {
    @StateObject var viewModel: CategoryViewModel
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
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



