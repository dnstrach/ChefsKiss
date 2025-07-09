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
    
    @State var equipment: MyRecipe.Equipment
    @State var equipmentName: String = ""
    
    let showAddImage: Bool = false
    
    var body: some View {
        VStack {
            TextField("", text: $equipmentName, prompt: Text("Equipment").foregroundStyle(.accent))
                .textfieldStyle()
                .padding(.horizontal)
            
            Button {
                editEquipment(equipment)
                dismiss()
            } label: {
                SheetButtonLabelView(isAddItem: showAddImage, text: "Edit Equipment")
            }
        }
        .padding(.vertical)
        .onAppear {
            storeInitialEquipment(equipment)
        }
    }
    
    func storeInitialEquipment(_ equipment: MyRecipe.Equipment) {
        equipmentName = equipment.name
    }
    
    func editEquipment(_ equipment: MyRecipe.Equipment) {
        equipment.name = equipmentName
    }
}

//#Preview {
//    EditEquipmentSheetView(viewModel: AddEditRecipeViewModel(), recipe: <#Recipe.Equipment#>)
//}
