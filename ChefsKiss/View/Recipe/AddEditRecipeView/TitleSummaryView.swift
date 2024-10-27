//
//  TitleSummaryView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 9/17/24.
//

import SwiftUI

struct TitleSummaryView: View {
    @ObservedObject var viewModel: AddEditRecipeViewModel
    
    var body: some View {
        TextField("",
                  text: $viewModel.title,
                  prompt: Text("Title").foregroundStyle(.accent))
        TextField("",
                  text: $viewModel.summary,
                  prompt: Text("Summary").foregroundStyle(.accent),
                  axis: .vertical)
    }
}

#Preview {
    TitleSummaryView(viewModel: AddEditRecipeViewModel())
}
