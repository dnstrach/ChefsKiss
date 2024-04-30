//
//  CategoriesGridView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 3/18/24.
//

import SwiftUI

struct CategoriesGridView: View {
    let category: String
    let searchParam: CategoryParam
    
    let rows = [
        GridItem(.flexible(minimum: 100))
    ]
  
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(category)
                .font(.title)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: rows, spacing: 20) {
                    // cuisine, type, diet, intolerances
                    switch searchParam {
                    case .cuisine:
                        ForEach(Cuisine.allCases, id: \.self) { cuisine in
                            NavigationLink {
                                // initialized CategoryViewModel
                                CategoryView(viewModel: CategoryViewModel(searchTerm: .searchParam(param: searchParam.rawValue, value: cuisine.rawValue)))
                            } label: {
                                CategoryLabel(category: cuisine.rawValue.capitalized)
                            }
                        }
                        
                    case .dishType:
                        ForEach(DishType.allCases, id: \.self) { dish in
                            NavigationLink {
                                CategoryView(viewModel: CategoryViewModel(searchTerm: .searchParam(param: searchParam.rawValue, value: dish.rawValue)))
                            } label: {
                                CategoryLabel(category: dish.rawValue.capitalized)
                            }
                        }
                        
                    case .diet:
                        ForEach(Diet.allCases, id: \.self) { diet in
                            NavigationLink {
                                CategoryView(viewModel: CategoryViewModel(searchTerm: .searchParam(param: searchParam.rawValue, value: diet.rawValue)))
                            } label: {
                                CategoryLabel(category: diet.rawValue)
                            }
                        }
                        
                    case .intolerance:
                        ForEach(Intolerance.allCases, id: \.self) { intolerance in
                            NavigationLink {
                                CategoryView(viewModel: CategoryViewModel(searchTerm: .searchParam(param: searchParam.rawValue, value: intolerance.rawValue)))
                            } label: {
                                CategoryLabel(category: intolerance.rawValue.capitalized)
                            }
                        }
                    }
                }
            }
        }
        .padding(.leading)
        .padding(.bottom)
    }
}

struct CategoryLabel: View {
    var category: String

    var body: some View {
        // used fixed size instead for performance
        VStack {
           // GeometryReader { geometry in
                Image(category.lowercased())
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                   // .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.primary))
                    .shadow(radius: 5)
           // }
            .aspectRatio(contentMode: .fit)
           // .frame(width: 200, height: 200)
            Text(category)
                .font(.title3)
                .foregroundStyle(Color.primary)
        }
    }
}

#Preview {
    ScrollView {
        Group {
            CategoriesGridView(category: "Cuisines", searchParam: .cuisine)
            CategoriesGridView(category: "Dish Types", searchParam: .dishType)
            CategoriesGridView(category: "Diets", searchParam: .diet)
            CategoriesGridView(category: "Intolerances", searchParam: .intolerance)
        }
        .previewLayout(.sizeThatFits)
    }
}
