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
        TextField("Title", text: $viewModel.title)
        TextField("Summary", text: $viewModel.summary, axis: .vertical)
    }
}

#Preview {
    TitleSummaryView(viewModel: AddEditRecipeViewModel())
}
