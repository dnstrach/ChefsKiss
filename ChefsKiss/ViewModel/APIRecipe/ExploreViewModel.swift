//
//  CategoryViewModel.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 3/14/24.
//

import Foundation
import SwiftData

enum ExploreViewResults {
    case category
    case search
    case emptySearch
}

// being passed to ExploreRecipesView, RecipesView
// initialized in CategoryGridView inside navlink for RecipesGridView

// ExploreRecipesView -> CategoryGridView -> RecipesGridView

@MainActor class ExploreViewModel: ObservableObject {
    @Published var recipes: [APIRecipe] = []
   // @Published var cachedRecipes: [APIRecipe] = []
    @Published var showLoadingAnimation: Bool = true
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var showSearchView = false
    @Published var searchText: String = ""
    @Published var exploreView = ExploreViewResults.category
    
    private let searchTerm: SearchTerm?
   // private let manager = CacheManager.instance
    
    let categories: [(CategoryTitle, CategoryKey)] = [
        (.cuisine, .cuisine),
        (.dishType, .dishType),
        (.diet, .diet),
        (.intolerance, .intolerance)
    ]
    
    var navigationTitle: String? {
        switch searchTerm {
        case let .categoryParam(_, value):
            
           return (value == "Low FODMAP" ? value : value.description.capitalized)
            
        default:
            return nil
        }
    }
    
    var unwrappedNavTitle: String {
        navigationTitle ?? ""
    }
    
    init(searchTerm: SearchTerm? = nil) {
        self.searchTerm = searchTerm
        
        Task {
            if let searchTerm = searchTerm {
                await self.loadCategoryRecipes(searchTerm: searchTerm)
            }
        }
    }
    
    private func loadCategoryRecipes(searchTerm: SearchTerm) async {
        do {
            recipes = try await APIManager.loadRecipes(searchTerm: searchTerm)
            showLoadingAnimation = false
            exploreView = .category
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
    
    func searchRecipes(query: String) async {
        
        // cachedRecipes.removeAll()
        
        do {
            let fetchedRecipes = try await APIManager.loadRecipes(searchTerm: .query(query))
            showLoadingAnimation = false
            recipes = fetchedRecipes
            // manager.add(recipes: fetchedRecipes, search: query)
            // cachedRecipes = manager.get(search: query) ?? []
            
            if fetchedRecipes.isEmpty {
                exploreView = .emptySearch
            } else if !fetchedRecipes.isEmpty {
                exploreView = .search
            }
            
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
    
    // repetitive code
//    func handleLoadRecipesError(error: APIError) {
//        if let apiError = error as? APIError, case.exceededCallLimit = apiError {
//            showAlert = true
//            alertMessage = APIError.exceededCallLimit.rawValue
//            print("Status code 402: \(error)")
//        } else {
//            print("Handle Error: \(error)")
//        }
//    }
}
