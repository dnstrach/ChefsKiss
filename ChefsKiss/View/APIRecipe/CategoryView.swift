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
            ScrollView {
                // use condition or change to switch to add a view when exceeded daily call limit
                if viewModel.shouldShowSpinner {
                    ProgressView()
                } else {
                    LazyVGrid(columns: columns) {
                        ForEach(viewModel.recipes, id: \.id) { recipe in
                            NavigationLink(destination: RecipeDetailView( recipe: recipe)) {
                                VStack {
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
                    }
                }
            }
            .navigationTitle(viewModel.navigationTitle)
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Network"), message: Text(viewModel.alertMessage))
            }
        }
    }
    
}

#Preview {
    CategoryView(viewModel: CategoryViewModel(searchTerm: SearchTerm(searchParam: "type", searchValue: "appetizer")))
}

