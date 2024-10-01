//
//  IngredientsAndMeasurementsView.swift
//  TreatBox
//
//  Created by Bruke Wondessen on 9/27/24.
//

import SwiftUI

struct IngredientsAndMeasurementsView: View {
    let mealDetailViewModel: MealDetailViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Ingredients")
                .padding(.bottom, 7.5)
                .font(.system(.headline, design: .serif))
            
            ForEach(0..<(mealDetailViewModel.meal?.ingredients.count ?? 0), id: \.self) { i in
                VStack {
                    HStack {
                        Text(mealDetailViewModel.meal?.ingredients[i] ?? "N/A")
                            .foregroundStyle(.secondary)
                        
                        Spacer()
                        
                        Text(mealDetailViewModel.meal?.measurements[i] ?? "N/A")
                    }
                    .padding(.bottom, 2.5)
                    
                    Divider()
                }
            }
        }
    }
}

#Preview {
    IngredientsAndMeasurementsView(mealDetailViewModel: MealDetailViewModel())
}
