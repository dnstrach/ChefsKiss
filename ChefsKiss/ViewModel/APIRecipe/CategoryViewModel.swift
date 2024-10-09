//
//  CategoryViewModel.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 3/14/24.
//

import Foundation

@MainActor class CategoryViewModel: ObservableObject {
    @Published var recipes: [APIRecipe] = []
    @Published var cachedRecipes: [APIRecipe] = []
    @Published var shouldShowSpinner: Bool = true
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var showSearchView = false
    @Published var searchText: String = ""
    
    private let searchTerm: SearchTerm
    private let manager = CacheManager.instance
    let categories: [(String, CategoryParam)] = [
        ("Cuisines", .cuisine),
        ("Dish Types", .dishType),
        ("Diets", .diet),
        ("Intolerances", .intolerance)
    ]
    
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
    
    func searchRecipes(query: String) async {
        
        cachedRecipes.removeAll()
        
        do {
            let fetchedRecipes = try await APIManager.loadRecipes(searchTerm: .query(query))
            shouldShowSpinner = false
            
            manager.add(recipes: fetchedRecipes, search: query)
            
            cachedRecipes = manager.get(search: query) ?? []
            
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
