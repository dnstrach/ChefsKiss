//
//  EquipmentListView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 9/17/24.
//

import SwiftUI

struct EquipmentListView: View {
    @ObservedObject var viewModel: AddEditRecipeViewModel
    
    @State var showAddEquipmentSheet: Bool = false
    
    var body: some View {
        HStack {
            Text("EQUIPMENT")
                .foregroundStyle(.accent)
                .font(.footnote)
                .fontWeight(.bold)
            
            Spacer()
            
            PlusButtonView(showSheet: $showAddEquipmentSheet)
            
        }
        .sheet(isPresented: $showAddEquipmentSheet) {
            AddEquipmentView(viewModel: viewModel)
                .sheetBackground()
                .presentationDetents([.fraction(0.25)])
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
