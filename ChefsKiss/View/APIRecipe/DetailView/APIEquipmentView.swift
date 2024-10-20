//
//  APIEquipmentView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 9/16/24.
//

import SwiftUI

struct APIEquipmentView: View {
    @ObservedObject var viewModel: APIRecipeDetailViewModel
    
    let recipe: APIRecipe
    
    var body: some View {
        ZStack {
            RoundedRectangleView()
            
            VStack(alignment: .leading) {
                Text("Equipment")
                    .subtitleFont()
                    .padding(.leading)
                    .padding(.top)
                
                let allEquipment = recipe.analyzedInstructions?.flatMap { $0.steps.flatMap { $0.equipment } }
                
                // Remove duplicates from all ingredients
                let equipment = viewModel.removeDuplicateEquipment(from: allEquipment ?? [])
                
                if !equipment.isEmpty {
                    LazyVGrid(columns: viewModel.columns, alignment: .leading, spacing: 10) {
                        ForEach(equipment, id: \.name) { equipment in
                            HStack(alignment: .top, spacing: 5) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundStyle(Color.accent)
                                
                                Text(equipment.name)
                                    .contentFont()
                                    .frame(maxHeight: .infinity)
                                    .padding(.bottom, 5)
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.leading)
                } else {
                    HStack {
                        Text("No equipment available")
                            .contentFont()
                            .foregroundColor(.gray)
                            .padding(.leading)
                        
                        Spacer()
                    }
                }
            }
            .padding(.bottom)
        }
        .padding()
        .padding(.horizontal, 20)
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
