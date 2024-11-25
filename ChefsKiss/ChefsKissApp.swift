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
    
    @State var showLaunchAnimation = false
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if showLaunchAnimation {
                    LaunchAnimation()
                }
                
                TabBarView(showLaunchAnimation: $showLaunchAnimation)
                .modelContainer(for: [
                    Recipe.self,
                    APIRecipe.self
                ])
                .environmentObject(viewModel)
            }
        }
    }
}
