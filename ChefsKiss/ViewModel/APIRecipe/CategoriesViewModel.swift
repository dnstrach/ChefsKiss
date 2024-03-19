//
//  CategoriesViewModel.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 3/15/24.
//

import Foundation

@MainActor class CategoriesViewModel: ObservableObject {
    @Published var recipes: [APIRecipe] = []
    @Published var query: String = ""
    @Published var showAlert: Bool = false
    @Published var alertMessage = ""
    
    let categories: [(String, Category)] = [
        ("Cuisines", .cuisine),
        ("Dish Types", .dishType),
        ("Diets", .diet),
        ("Intolerances", .intolerance)
    ]
    
//    init(query: String) {
//        self.query = query
//        
//        Task {
//            await self.searchRecipes(query: query)
//        }
//    }
    
    
    func searchRecipes(query: String) async {
        
        do {
             // let searchTerm = SearchTerm(searchParam: "", searchValue: "")

            recipes = try await APIManager.loadSearchRecipes(query: query)
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
