//
//  CategoriesView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 3/14/24.
//

import SwiftUI

// clean up code with repetitive for each and labels
struct CategoriesView: View {
    @StateObject var viewModel: CategoriesViewModel
    @State private var searchText: String = ""
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                // searchText needs to get updated - onChange?
                SearchBarView(searchText: $searchText)
                
                ForEach(viewModel.categories, id: \.0) { category, searchParam in
                    
                    if !searchText.isEmpty {
                        LazyVGrid(columns: columns) {
                            ForEach(viewModel.recipes, id: \.id) { recipe in
                                NavigationLink(destination: RecipeDetailView( recipe: recipe)) {
                                    Text(recipe.title)
                                    AsyncImage(url: URL(string: recipe.image), scale: 3) { image in
                                        image
                                            .resizable()
                                            .scaledToFit()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                }
                            }
                        }
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

