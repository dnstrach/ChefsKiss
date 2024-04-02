//
//  CategoryViewModel.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 3/14/24.
//

import Foundation

//struct SearchTerm {
//    let searchParam: String
//    let searchValue: String
//}

@MainActor class CategoryViewModel: ObservableObject {
    @Published var recipes: [APIRecipe] = []
    @Published var shouldShowSpinner: Bool = true
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    private let searchTerm: SearchTerm
    
    var navigationTitle: String? {
        switch searchTerm {
        case let .searchParam(_, value):
            
           return (value == "Low FODMAP" ? value : value.description.capitalized)
            
        default:
            return nil
        }
    }
    
    var unwrappedNavTitle: String {
        navigationTitle ?? ""
    }
    
    init(searchTerm: SearchTerm) {
        self.searchTerm = searchTerm
        
        Task {
            await self.loadCategoryRecipes(searchTerm: searchTerm)
        }
    }
    
    private func loadCategoryRecipes(searchTerm: SearchTerm) async {
        do {
            recipes = try await APIManager.loadRecipes(searchTerm: searchTerm)
            shouldShowSpinner = false
        } catch {
            if let apiError = error as? APIError, case.exceededCallLimit = apiError {
                showAlert = true
                alertMessage = APIError.exceededCallLimit.rawValue
                print("Status code 402: \(error)")
            } else {
                print("Handle Error: \(error)")
            }
        }
    }
}
