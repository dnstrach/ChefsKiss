//
//  SummaryView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 9/17/24.
//

import SwiftUI

struct SummaryView: View {
    let recipe: Recipe
    
    var body: some View {
        VStack {
            Text(recipe.summary)
            .padding()
        }
    }
}

#Preview {
    do {
        let preview = try RecipePreview()
        
        return SummaryView(recipe: preview.recipe)
            .modelContainer(preview.container)
    } catch {
        fatalError("Failed to create preview container.")
    }
}
