//
//  EquipmentListView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 9/17/24.
//

import SwiftUI

enum SheetAction {
    case cancel
    case swipeDown
}

struct EquipmentListView: View {
    @ObservedObject var viewModel: AddEditRecipeViewModel
    
    @State var isPresented: Bool = false
    @State var sheetAction: SheetAction = SheetAction.swipeDown
    
    var body: some View {
        List {
            ForEach(viewModel.sortedEquipment, id: \.id) { equipment in
                HStack {
                    Text(equipment.name)
                }
                   // .frame(maxWidth: .infinity)
                    .onTapGesture {
                        // set it back to false after closing sheet
                     //   isPresented.toggle()
                        viewModel.selectedEquipment = equipment
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            viewModel.deleteEquipment(equipment)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                    .sheet(item: $viewModel.selectedEquipment) { equipment in
                        EditEquipmentSheetView(viewModel: viewModel, equipment: equipment)
                            .presentationDetents([.fraction(0.25)])
                            .presentationDragIndicator(.hidden)
                    }
            }
        }
        
        VStack {
            TextField("Equipment", text: $viewModel.equipmentName)
                .textFieldStyle(.roundedBorder)
            
            Button("Add Equipment", systemImage: "plus.circle") {
                viewModel.addEquipment()
                UIApplication.shared.endEditing()
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
