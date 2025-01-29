//
//  ChefsKissApp.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 4/1/24.
//

import SwiftData
import SwiftUI

@main
struct ChefsKissApp: App {
    @StateObject var viewModel = SavedRecipesViewModel()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                TabBarView()
                // SwiftData containers
                .modelContainer(for: [
                    Recipe.self,
                    APIRecipe.self
                ])
                // all views will have access to SavedRecipesViewModel when declared with @EnvironmentObject macro
                .environmentObject(viewModel)
            }
        }
    }
}
