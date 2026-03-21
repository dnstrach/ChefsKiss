//
//  ChefsKissApp.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 4/1/24.
//

import SwiftData
import SwiftUI

// git commit test
@main
struct ChefsKissApp: App {
    var body: some Scene {
        WindowGroup {
            ZStack {
                TabBarView()
                // SwiftData containers
                .modelContainer(for: [
                    MyRecipe.self,
                    APIRecipe.self
                ])
            }
        }
    }
}
