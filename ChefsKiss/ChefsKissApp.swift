//
//  ChefsKissApp.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 3/14/24.
//

import SwiftData
import SwiftUI

@main
struct ChefsKissApp: App {
    let container: ModelContainer
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        // [Recipe.self] if more than one model
        .modelContainer(container)
    }
    
    init() {
        do {
            container = try ModelContainer(for: Recipe.self)
        } catch {
            fatalError("Failed to create ModelContainer for Movie.")
        }
    }
}
