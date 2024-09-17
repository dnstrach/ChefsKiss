//
//  CategoriesViewModel.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 3/15/24.
//

//import Foundation
//
//@MainActor class CategoriesViewModel: ObservableObject {
//    @Published var recipes: [APIRecipe] = []
//    @Published var showAlert: Bool = false
//    @Published var alertMessage = ""
//    
//    let categories: [(String, CategoryParam)] = [
//        ("Cuisines", .cuisine),
//        ("Dish Types", .dishType),
//        ("Diets", .diet),
//        ("Intolerances", .intolerance)
//    ]
//
//    func searchRecipes(query: String) async {
//        do {
//            recipes = try await APIManager.loadRecipes(searchTerm: .query(query))
//        } catch {
//            if let apiError = error as? APIError, case.exceededCallLimit = apiError {
//                showAlert = true
//                alertMessage = APIError.exceededCallLimit.rawValue
//                print("Status code 402: \(error)")
//            } else {
//                print("Handle Error: \(error)")
//            }
//        }
//    }
//}
