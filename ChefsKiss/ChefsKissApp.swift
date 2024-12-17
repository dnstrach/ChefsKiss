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
    var body: some Scene {
        WindowGroup {
            ZStack {
                TabBarView()
                .modelContainer(for: [
                    Recipe.self,
                    APIRecipe.self
                ])
            }
        }
    }
}
