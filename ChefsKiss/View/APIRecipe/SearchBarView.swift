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
                // .foregroundStyle(.yellow)
            
            TextField("Search recipes", text: $searchText)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                       // .foregroundStyle(.yellow)
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
                .fill(.theme)
                .shadow(
                    color: .gray.opacity(0.5),
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
            .preferredColorScheme(.dark)
        
//        SearchBarView(searchText: .constant(""))
//            .previewLayout(.sizeThatFits)
//            .preferredColorScheme(.dark)
    }
}
