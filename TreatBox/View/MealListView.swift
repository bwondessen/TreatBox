//
//  MealListView.swift
//  TreatBox
//
//  Created by Bruke Wondessen on 9/27/24.
//

import SwiftUI

struct MealListView: View {
    @Binding var path: [String]
    let meal: Meal
    
    var body: some View {
        VStack {
            Button {
                path = [meal.idMeal]
            } label: {
                VStack {
                    MealRowView(mealID: meal.strMealThumb, mealName: meal.strMeal)
                }
            }
            .foregroundStyle(.primary)
            .listRowSeparator(.hidden)
        }
    }
}

//#Preview {
//    MealListView()
//}
