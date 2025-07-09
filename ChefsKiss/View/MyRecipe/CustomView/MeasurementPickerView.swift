//
//  MeasurementPickerView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 10/27/24.
//

import SwiftUI

struct MeasurementPickerView: View {
    @ObservedObject var viewModel: AddEditRecipeViewModel
    
    @Binding var selectedMeasurement: String
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 0.5) {
                ForEach(viewModel.measureTypes, id: \.self) { measurement in
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.white)
                            .frame(width: 70, height: 40)
                            .opacity(selectedMeasurement == measurement ? 1.0 : 0.3)
                            .onTapGesture {
                                withAnimation(.interactiveSpring()) {
                                    selectedMeasurement = measurement
                                }
                            }
                            .overlay {
                                Text(measurement)
                                    .foregroundStyle(.accent)
                                    .font(.subheadline)
                                    .bold()
                                    .frame(width: 100)
                            }
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(.accent))
                        
                        
                    }
                    .background(RoundedRectangle(cornerRadius: 10).fill(.textfield.opacity(0.5)))
                }
            }
            .frame(height: 50)
        }
        .padding(.top)
        .padding(.horizontal)
    }
}

#Preview {
    ZStack {
        Color.accentColor
        
        MeasurementPickerView(viewModel: AddEditRecipeViewModel(), selectedMeasurement: .constant("c"))
    }
}
