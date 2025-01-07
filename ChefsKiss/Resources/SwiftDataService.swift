//
//  SwiftDataSource.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 12/23/24.
//

import Foundation
import SwiftData

class SwiftDataService {
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext
    
    @MainActor
    static let shared = SwiftDataService()
    
    @MainActor
    private init() {
        self.modelContainer = try! ModelContainer(for: APIRecipe.self)
        self.modelContext = modelContainer.mainContext
    }
    
    func fetchSavedRecipes() -> [APIRecipe] {
        do {
            return try modelContext.fetch(FetchDescriptor<APIRecipe>(sortBy: [SortDescriptor(\.title)]))
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func addRecipe(_ recipe: APIRecipe) {
        modelContext.insert(recipe)
        
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func removeRecipe(_ recipe: APIRecipe) {
        modelContext.delete(recipe)
        
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
