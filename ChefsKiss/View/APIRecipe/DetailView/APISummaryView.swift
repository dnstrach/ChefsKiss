//
//  APISummaryView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 9/16/24.
//

import SwiftUI

struct APISummaryView: View {
    let recipe: APIRecipe
    
    @State private var isFullSummary = false
    
    var body: some View {
        Text(recipe.summary.stringByStrippingHTMLTags())
            .lineLimit(isFullSummary ? nil : 4)
            .overlay(alignment: .bottomTrailing) {
                Button {
                    isFullSummary.toggle()
                } label: {
                    Image(systemName: isFullSummary ? "arrow.up" : "arrow.down")
                        .foregroundStyle(Color.accentColor)
                }
               // .padding(.trailing)
                .scaleEffect(1.5)
                .offset(x: isFullSummary ? 0 : 10, y: isFullSummary ? 0 : 10 )

            }
            .padding(.horizontal)
            .padding(.horizontal)
            .padding(.horizontal)
            .padding(.bottom)
    }
}

#Preview {
    do {
        let preview = try APIRecipePreview()
        
        return APISummaryView(recipe: preview.recipe)
            .modelContainer(preview.container)
    } catch {
        fatalError("Failed to create preview container.")
    }
}
