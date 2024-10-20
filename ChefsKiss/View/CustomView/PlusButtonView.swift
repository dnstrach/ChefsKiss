//
//  AddButtonView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 10/20/24.
//

import SwiftUI

struct PlusButtonView: View {
    @Binding var showSheet: Bool
    
    var body: some View {
        Button {
            showSheet.toggle()
        } label: {
            Image(systemName: "plus.circle.fill")
                .imageScale(.large)
                .foregroundStyle(.accent)
        }
    }
}

#Preview {
    PlusButtonView(showSheet: .constant(false))
}
