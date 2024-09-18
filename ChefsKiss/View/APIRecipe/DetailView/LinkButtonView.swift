//
//  LinkButtonView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 9/16/24.
//

import SwiftUI

struct LinkButtonView: View {
    @Environment(\.openURL) var openURL
    
    let recipe: APIRecipe
    
    var body: some View {
        Button("Link to Recipe") {
            openURL(URL(string: recipe.sourceUrl)!)
        }
        .font(.system(.subheadline, design: .rounded))
        .fontWeight(.bold)
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.capsule)
        .controlSize(.large)
        .padding(.bottom)
    }
}

#Preview {
    do {
        let preview = try APIRecipePreview()
        
        return LinkButtonView(recipe: preview.recipe)
            .modelContainer(preview.container)
    } catch {
        fatalError("Failed to create preview container.")
    }
}
