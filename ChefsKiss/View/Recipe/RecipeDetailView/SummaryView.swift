//
//  SummaryView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 9/17/24.
//

import SwiftUI

struct SummaryView: View {
    let recipe: Recipe
    
    @State private var isFullSummary: Bool = false
    
    var body: some View {
        if !recipe.summary.isEmpty {
            Text(recipe.summary)
                .lineLimit(isFullSummary ? nil : 2)
                .overlay(alignment: .bottomTrailing) {
                    ExpandButtonView(isFullSummary: $isFullSummary)
                }
                .padding(.horizontal)
                .padding(.horizontal)
                .padding(.horizontal)
                .padding(.bottom)
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
