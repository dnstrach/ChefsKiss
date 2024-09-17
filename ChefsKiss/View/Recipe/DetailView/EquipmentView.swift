//
//  EquipmentView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 9/17/24.
//

import SwiftUI

struct EquipmentView: View {
    let recipe: Recipe
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Equipment")
                .font(.title2)
               // .padding(.leading)
            
            ForEach(recipe.sortedEquipment, id:\.id) { equipment in
                Text(equipment.name)
            }
        }
        .padding(.bottom)
    }
}

#Preview {
    do {
        let preview = try RecipePreview()
        
        return EquipmentView(recipe: preview.recipe)
            .modelContainer(preview.container)
    } catch {
        fatalError("Failed to create preview container.")
    }
}
