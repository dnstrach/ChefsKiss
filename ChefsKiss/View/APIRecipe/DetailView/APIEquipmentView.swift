//
//  APIEquipmentView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 9/16/24.
//

import SwiftUI

struct APIEquipmentView: View {
    let viewModel: APIRecipeDetailViewModel
    
    let recipe: APIRecipe
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Equipment")
                .font(.title2)
                .padding(.leading)
            
            let allEquipment = recipe.analyzedInstructions?.flatMap { $0.steps.flatMap { $0.equipment } }
            
            // Remove duplicates from all ingredients
            let uniqueEquipment = viewModel.removeDuplicateEquipment(from: allEquipment ?? [])
            
            if !uniqueEquipment.isEmpty {
                LazyVGrid(columns: viewModel.columns, alignment: .leading, spacing: 10) {
                    ForEach(uniqueEquipment, id: \.id) { equipment in
                        Text(equipment.name)
                            .padding(.bottom, 5)
                            .padding(.horizontal)
                    }
                }
                .padding(.leading)
            } else {
                HStack {
                    Text("No equipment available")
                        .foregroundColor(.gray)
                        .padding(.leading)
                    
                    Spacer()
                }
            }
        }
        .padding(.bottom)
    }
}

#Preview {
    do {
        let preview = try APIRecipePreview()
        
        return APIEquipmentView(viewModel: APIRecipeDetailViewModel(), recipe: preview.recipe)
            .modelContainer(preview.container)
    } catch {
        fatalError("Failed to create preview container.")
    }
}
