//
//  SwiftDataPreview.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 3/14/24.
//

import Foundation
import SwiftData

@MainActor
struct Previewer {
    let container: ModelContainer
    let recipe: Recipe

    init() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        container = try ModelContainer(for: Recipe.self, configurations: config)

        recipe = Recipe(title: "Pesto Pasta", instructions: "instructions...")

        container.mainContext.insert(recipe)
    }
}
