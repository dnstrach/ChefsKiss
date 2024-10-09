//
//  SummaryView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 9/17/24.
//

import SwiftUI

struct SummaryView: View {
    let recipe: Recipe
    
    @State var isFullSummary: Bool = false
    
    var body: some View {
        if !recipe.summary.isEmpty {
            Text(recipe.summary)
                .lineLimit(isFullSummary ? nil : 2)
                .overlay(alignment: .bottomTrailing) {
                    Button {
                        isFullSummary.toggle()
                    } label: {
                        Image(systemName: isFullSummary ? "arrow.up" : "arrow.down")
                            .foregroundStyle(.accent)
                    }
                    .scaleEffect(1.5)
                    .offset(x: isFullSummary ? 0 : 10, y: isFullSummary ? 0 : 10 )
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
