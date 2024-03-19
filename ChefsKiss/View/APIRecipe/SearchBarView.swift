//
//  SearchBarView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 3/15/24.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            
            TextField("Search recipes", text: $searchText)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .foregroundColor(.secondary)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .padding(.trailing, 8)
                    , alignment: .trailing
                )
                .onTapGesture {
                    UIApplication.shared.endEditing()
                    searchText = ""
                }

        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(.yellow)
                .shadow(
                    color: Color.secondary.opacity(0.15),
                    radius: 10, x: 0, y: 0
                )
        )
        .padding()
    }
}

#Preview {
    Group {
        SearchBarView(searchText: .constant(""))
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.light)
        
        SearchBarView(searchText: .constant(""))
            .preferredColorScheme(.dark)
    }
}
