//
//  AddEquipmentView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 10/20/24.
//

import SwiftUI

struct AddEquipmentView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel: AddEditRecipeViewModel
    
    let showAddImage: Bool = true
    
    var body: some View {
        VStack {
            TextField("", text: $viewModel.equipmentName, prompt: Text("Equipment").foregroundStyle(.accent))
                .textfieldStyle()
                .padding(.horizontal)
            
            Button {
                viewModel.addEquipment()
                dismiss()
            } label: {
                SheetButtonLabelView(isAddItem: showAddImage, text: "Add Equipment")
            }
            .disabled(viewModel.disableEquip)
        }
        .onDisappear {
            viewModel.clearEquipment()
        }
        .padding(.vertical)
    }
}

#Preview {
    AddEquipmentView(viewModel: AddEditRecipeViewModel())
}
