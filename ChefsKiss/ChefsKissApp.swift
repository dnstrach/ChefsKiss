//
//  ChefsKissApp.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 4/1/24.
//

import SwiftData
import SwiftUI

// testing
// testing
@main
struct ChefsKissApp: App {
    var body: some Scene {
        WindowGroup {
            ZStack {
                TabBarView()
                // SwiftData containers
                .modelContainer(for: [
                    Recipe.self,
                    APIRecipe.self
                ])
            }
        }
    }
}
