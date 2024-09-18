//
//  CookTimePickerView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 9/17/24.
//

import SwiftUI

struct CookTimePickerView: View {
    @ObservedObject var viewModel: AddEditRecipeViewModel
    
    var body: some View {
        HStack {
            Picker("Hours", selection: $viewModel.prepHrTime) {
                ForEach(viewModel.prepHrRange, id: \.self) { hour in
                    Text("\(hour)")
                }
            }
            
            Picker("Minutes", selection: $viewModel.prepMinTime) {
                ForEach(viewModel.prepMinRange, id: \.self) { minute in
                    Text("\(minute)")
                }
            }
        }
    }
}

#Preview {
    Form {
        Section {
            CookTimePickerView(viewModel: AddEditRecipeViewModel())
        }
    }
}

