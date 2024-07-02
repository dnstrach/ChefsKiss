//
//  EquipmentSheetEditView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 7/2/24.
//

import SwiftUI

struct EquipmentSheetEditView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var equipment: Recipe.Equipment
    
    var body: some View {
        Form {
//            VStack {
//                TextField("Equipment", text: $equipment.name)
//                    .textFieldStyle(.roundedBorder)
//                
//                Button("Add Equipment", systemImage: "plus.circle") {
//                    editEquipment(equipment)
//                    dismiss()
//                }
//               // .disabled(viewModel.disableEquip)
//            }
        }
    }
}

//#Preview {
//    EquipmentSheetEditView()
//}
