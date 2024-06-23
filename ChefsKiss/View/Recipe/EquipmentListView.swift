//
//  EquipmentListView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 6/22/24.
//

import SwiftUI

struct EquipmentListView: View {
    @Binding var equipment: [Recipe.Equipment]
    let deleteCallback: (IndexSet) -> ()
    
    var body: some View {
        List {
            ForEach(equipment, id: \.id) { equipment in
                Text("\(equipment.name)")
            }
            .onDelete(perform: deleteCallback)
        }
    }
}

//#Preview {
//    EquipmentListView()
//}
