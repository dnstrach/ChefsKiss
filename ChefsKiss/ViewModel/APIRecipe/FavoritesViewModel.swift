//
//  FavoritesViewModel.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 4/7/24.
//

import Foundation

class Favorites: ObservableObject {
    var savedRecipes: Set<APIRecipe>
    private let saveKey = "Favorites"
    
    init() {
        // load our saved data
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            if let decoded = try? JSONDecoder().decode(Set<APIRecipe>.self, from: data) {
                savedRecipes = decoded
                return
            }
        }
        
        savedRecipes = []
    }
    
    func contains( _ recipe: APIRecipe) -> Bool {
        savedRecipes.contains(recipe)
    }
    
    func add(_ recipe: APIRecipe) {
        objectWillChange.send()
        savedRecipes.insert(recipe)
        save()
    }
    
    func remove(_ recipe: APIRecipe) {
        objectWillChange.send()
        savedRecipes.remove(recipe)
        save()
    }
    
    func save() {
        if let data = try? JSONEncoder().encode(savedRecipes) {
            UserDefaults.standard.set(data, forKey: saveKey)
        }
    }
}
