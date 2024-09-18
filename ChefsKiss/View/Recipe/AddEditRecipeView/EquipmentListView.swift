//
//  EquipmentListView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 9/17/24.
//

import SwiftUI

struct EquipmentListView: View {
    @ObservedObject var viewModel: AddEditRecipeViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.sortedEquipment, id: \.id) { equipment in
                Text(equipment.name)
                    .swipeActions {
                        Button(role: .destructive) {
                            viewModel.deleteEquipment(equipment)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
            }
        }
        
        VStack {
            TextField("Equipment", text: $viewModel.equipmentName)
                .textFieldStyle(.roundedBorder)
            
            Button("Add Equipment", systemImage: "plus.circle") {
                viewModel.addEquipment()
            }
            .disabled(viewModel.disableEquip)
        }
    }
}

#Preview {
    Form {
        EquipmentListView(viewModel: AddEditRecipeViewModel())
    }
}
