//
//  PickerView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 11/7/24.
//

import SwiftUI

struct PickerView: View {
    let minutes = 1..<1441
    
    @State var showPicker = false
    
    var body: some View {
        Button {
            showPicker.toggle()
        } label: {
            Circle()
                .frame(width: 50, height: 50)
        }
        .overlay {
            if showPicker {
                ScrollView {
                    ForEach(minutes, id: \.self) { min in
                        LazyVStack {
                            Text("\(min)")
                                .contentFont()
                                .foregroundStyle(.white)
                                .padding(.vertical, 5)
                            
                            Rectangle()
                                .frame(height: 1)
                                .foregroundStyle(.white)
                            
                        }
                        .frame(width: 100)
                    }
                }
                .frame(width: 100, height: 400)
                .background(.accent1)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
    }
}

#Preview {
    PickerView()
}
