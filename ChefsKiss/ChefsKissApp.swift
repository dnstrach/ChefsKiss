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
            TabBarView()
                .modelContainer(for: [Recipe.self])
                // .modelContainer(for: [Recipe.self, Response.self])
                .environmentObject(Favorites())
        }
    }
}
