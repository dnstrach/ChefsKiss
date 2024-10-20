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
    
    var body: some View {
        VStack {
            TextField("Equipment", text: $viewModel.equipmentName)
                .padding(.horizontal)
                .padding(.vertical, 10)
                .background(.textfield)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal)
            
            Button {
                viewModel.addEquipment()
                dismiss()
            } label: {
                AddButtonLabelView(text: "Add Equipment")
            }
            .disabled(viewModel.disableEquip)
        }
        .padding(.vertical)
    }
}

#Preview {
    AddEquipmentView(viewModel: AddEditRecipeViewModel())
}
