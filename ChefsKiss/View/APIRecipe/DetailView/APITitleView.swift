//
//  APITitleView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 9/16/24.
//

import SwiftUI

struct APITitleView: View {
    let recipe: APIRecipe
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(recipe.title)
                    .font(.system(size: 40))
                    .fontDesign(.rounded)
                    .fontWeight(.bold)
                    .padding(.leading, 20)
                    .padding(.top, 5)

                Spacer()
            }
        }
    }
}

#Preview {
    do {
        let preview = try APIRecipePreview()

        return APITitleView(recipe: preview.recipe)
            .modelContainer(preview.container)
    } catch {
        fatalError("Failed to create preview container.")
    }
}
