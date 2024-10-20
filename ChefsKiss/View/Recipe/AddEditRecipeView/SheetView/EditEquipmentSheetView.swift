//
//  EditEquipmentSheetView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 9/18/24.
//

import SwiftUI

struct EditEquipmentSheetView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel: AddEditRecipeViewModel
    
    @State var equipment: Recipe.Equipment
    
    @State var equipmentName: String = ""
    
    var body: some View {
        VStack {
            TextField("Equipment", text: $equipmentName)
                .padding(.horizontal)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            Button("Edit Equipment", systemImage: "plus.circle") {
                editEquipment(equipment)
                dismiss()
            }
        }
        .padding(.vertical)
        .onAppear {
            storeInitialEquipment(equipment)
        }
    }
    
    func storeInitialEquipment(_ equipment: Recipe.Equipment) {
        equipmentName = equipment.name
    }
    
    func editEquipment(_ equipment: Recipe.Equipment) {
        equipment.name = equipmentName
    }
}

//#Preview {
//    EditEquipmentSheetView(viewModel: AddEditRecipeViewModel(), recipe: <#Recipe.Equipment#>)
//}
