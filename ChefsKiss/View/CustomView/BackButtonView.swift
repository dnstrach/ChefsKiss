//
//  BackButton.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 10/8/24.
//

import SwiftUI

struct BackButtonView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Button {
                dismiss()
            } label: {
                ZStack {
                    Circle()
                        .fill(.accent)
                        .frame(width: 50, height: 30)
                    
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.white)
                }
                .frame(width: 80, height: 80)
                .offset(x: 10, y: 10)
            }
        }
    }
}

#Preview {
    BackButtonView()
}
