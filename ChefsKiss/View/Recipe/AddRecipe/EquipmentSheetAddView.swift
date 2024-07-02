//
//  EquipmentSheetAddView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 7/2/24.
//

import SwiftUI

struct EquipmentSheetAddView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel: AddRecipeViewModel
    
    @State var equipment: Recipe.Equipment
    
    var body: some View {
        Form {
            VStack {
                TextField("Equipment", text: $equipment.name)
                    .textFieldStyle(.roundedBorder)
                
                Button("Add Equipment", systemImage: "plus.circle") {
                    viewModel.editEquipment(equipment)
                    dismiss()
                }
               // .disabled(viewModel.disableEquip)
            }
        }
    }
}

//#Preview {
//    EquipmentSheetAddView(viewModel: AddRecipeViewModel())
//}
