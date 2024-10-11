//
//  ExpandLinesButton.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 10/10/24.
//

import SwiftUI

struct ExpandButtonView: View {
    @Binding var isFullSummary: Bool
    
    var body: some View {
        ZStack {
            Button {
                withAnimation(.easeOut) {
                    isFullSummary.toggle()
                }
            } label: {
                Image(systemName: isFullSummary ? "arrow.up.square.fill" : "arrow.down.app.fill")
                    .foregroundStyle(Color.accentColor)
            }
            .scaleEffect(2)
            .offset(x: isFullSummary ? 0 : 10, y: isFullSummary ? 0 : 25 )
            .shadow(color: Color.secondary, radius: 5)
            
            Image(systemName: isFullSummary ? "arrow.up" : "arrow.down")
                .foregroundStyle(.white)
                .offset(x: isFullSummary ? 0 : 10, y: isFullSummary ? 0 : 25 )
        }
    }
}

#Preview {
    ExpandButtonView(isFullSummary: .constant(false))
}
