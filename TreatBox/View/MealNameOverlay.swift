//
//  MealNameOverlay.swift
//  TreatBox
//
//  Created by Bruke Wondessen on 9/27/24.
//

import SwiftUI

struct MealNameOverlay: View {
    let meal: MealDetail
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.white)
                .frame(width: UIScreen.main.bounds.width * 0.90, height: UIScreen.main.bounds.height * 0.12)
                .clipShape(.rect(cornerRadius: 15))
                .shadow(radius: 3.5)
            
            VStack {
                Text("RECIPE")
                    .foregroundStyle(.secondary)
                    .italic()
                    .font(.subheadline)
                
                Text(meal.strMeal)
                    .font(.system(.title3, design: .serif))
                    .bold()
            }
        }
        .offset(y: 60)
    }
}

#Preview {
    MealNameOverlay(meal: MealDetail.mealDetailPreview)
}
