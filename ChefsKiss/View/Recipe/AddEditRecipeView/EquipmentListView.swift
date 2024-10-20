//
//  EquipmentListView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 9/17/24.
//

import SwiftUI

//enum SheetAction {
//    case cancel
//    case swipeDown
//}

struct EquipmentListView: View {
    @ObservedObject var viewModel: AddEditRecipeViewModel
    
    @State var showAddEquipmentSheet: Bool = false
    
    var body: some View {
        HStack {
            Text("EQUIPMENT")
                .foregroundStyle(.secondary)
                .font(.footnote)
            
            Spacer()
            
            PlusButtonView(showSheet: $showAddEquipmentSheet)
            
          //  Spacer()
        }
        .sheet(isPresented: $showAddEquipmentSheet) {
            ZStack {
                Color.accent.ignoresSafeArea(.all)
                
                AddEquipmentView(viewModel: viewModel)
                    .presentationDetents([.fraction(0.25)])
                    .presentationDragIndicator(.hidden)
            }
        }
        
        List {
            ForEach(viewModel.sortedEquipment, id: \.id) { equipment in
                HStack {
                    Text(equipment.name)
                }
                .onTapGesture {
                    viewModel.selectedEquipment = equipment
                }
                .swipeActions {
                    Button(role: .destructive) {
                        viewModel.deleteEquipment(equipment)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
            }
        }
    }
        
}

#Preview {
    Form {
        EquipmentListView(viewModel: AddEditRecipeViewModel())
    }
}
