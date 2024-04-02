//
//  CategoryView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 3/14/24.
//

import SwiftUI

// ask vala about cuisine recipes showing up in incorrect category
// cuisine parameter shows empty array cuisines: []

struct CategoryView: View {
    @StateObject var viewModel: CategoryViewModel
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationStack {
            CategoryGridView(recipes: viewModel.recipes, shouldShowSpinner: viewModel.shouldShowSpinner)
                .navigationTitle(viewModel.unwrappedNavTitle)
                .alert(isPresented: $viewModel.showAlert) {
                    Alert(title: Text("Network"), message: Text(viewModel.alertMessage))
                }
        }
    }
}

#Preview {
    CategoryView(viewModel: CategoryViewModel(searchTerm: .searchParam(param: "type", value: "appetizer")))
}

