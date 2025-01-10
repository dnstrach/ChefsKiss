//
//  APIServingsDurationView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 9/16/24.
//

import SwiftUI

struct APIServingsDurationView: View {
    let recipe: APIRecipe
    
    var body: some View {
        HStack {
            HStack {
                Text("Servings:")
                    .contentFont()
                    .fontWeight(.bold)
                Text("\(recipe.servings)")
                    .contentFont()
            }
            
            
            Spacer()
            
            HStack {
                Text("Duration:")
                    .contentFont()
                    .fontWeight(.bold)
                Text("\(recipe.readyInMinutes) minutes")
                    .contentFont()
            }
        }
        .padding(.horizontal, 50)
        .padding(.bottom)
    }
}

//#Preview {
//    do {
//        let preview = try APIRecipePreview()
//
//        return APIServingsDurationView(recipe: preview.recipe)
//            .modelContainer(preview.container)
//    } catch {
//        fatalError("Failed to create preview container.")
//    }
//}
