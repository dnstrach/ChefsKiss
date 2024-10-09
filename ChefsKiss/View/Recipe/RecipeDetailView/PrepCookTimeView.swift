//
//  PrepCookTimeView.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 9/17/24.
//

import SwiftUI

struct PrepCookTimeView: View {
    let recipe: Recipe
    
    let hour: String = "hr"
    let hours: String = "hrs"
    let min: String = "min"
    let mins: String = "mins"
    
    var isPrepHrZero: Bool {
        recipe.prepHrTime == 0
    }
    
    var isPrepMinZero: Bool {
        recipe.prepMinTime == 0
    }
    
    var isCookHrZero: Bool {
        recipe.cookHrTime == 0
    }
    
    var isCookMinZero: Bool {
        recipe.cookMinTime == 0
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(Color.accent)
            
            VStack {
                if (!isPrepHrZero || !isPrepMinZero || !isCookHrZero || !isCookMinZero) {
                    HStack {
                        VStack {
                            if !isPrepHrZero || !isPrepMinZero {
                                HStack {
    //                                Image(systemName: "clock.circle")
    //                                    .foregroundStyle(.accent)
                                    Text("Prep")
                                        .font(.system(size: 20, weight: .bold))
                                }
                            }
                            
                            HStack {
                                if !isPrepHrZero {
                                    Text("\(recipe.prepHrTime)")
                                    Text(recipe.prepHrTime == 1 ? hour : hours)
                                }
                                
                                if !isPrepMinZero {
                                    Text("\(recipe.prepMinTime)")
                                    Text(recipe.prepMinTime == 1 ? min : mins)
                                }
                            }
                            
                        }
                      //  .padding(.bottom)
                        
                        Spacer()
                        
                        VStack {
                            if !isCookHrZero || !isCookMinZero {
                                HStack {
    //                                Image(systemName: "clock.circle")
    //                                    .foregroundStyle(.accent)
                                    Text("Cook")
                                        .font(.system(size: 20, weight: .bold))
                                }
                            }
                            
                            HStack {
                                if !isCookHrZero {
                                    Text("\(recipe.cookHrTime)")
                                    Text(recipe.cookHrTime == 1 ? hour : hours)
                                }
                                
                                if !isCookMinZero {
                                    Text("\(recipe.cookMinTime)")
                                    Text(recipe.cookMinTime == 1 ? min : mins)
                                }
                            }
                        }
                      //  .padding(.bottom)
                    }
                }
            }
        }
        .padding(.vertical)
        .padding(.horizontal)
        .padding(.horizontal)
    }
}

#Preview {
    do {
        let preview = try RecipePreview()
        
        return PrepCookTimeView(recipe: preview.recipe)
            .modelContainer(preview.container)
    } catch {
        fatalError("Failed to create preview container.")
    }
}


