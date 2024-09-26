//
//  MealsView.swift
//  TreatBox
//
//  Created by Bruke Wondessen on 9/24/24.
//

import SwiftUI

struct MealsView: View {
    @StateObject var mealViewModel: MealViewModel = MealViewModel()
    
    @State private var errorMessage: String = "Data failed to fetch..."
    
    var body: some View {
        NavigationStack {
            List(mealViewModel.meals) { meal in
                MealRowView(mealID: meal.strMealThumb, mealName: meal.strMeal)
            }
            .navigationTitle("TreatBox")
            .scrollContentBackground(.hidden)
        }
        .task {
            do {
                try await mealViewModel.fetchMeals()
            } catch {
                print(errorMessage)
            }
        }
    }
}

#Preview {
    MealsView()
}

// MARK: - Meal Row View
struct MealRowView: View {
    let mealID: String
    let mealName: String
    
    var body: some View {
        Section {
            HStack {
                AsyncImage(url: URL(string: mealID)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(height: 80)
                        .clipShape(.rect(cornerRadius: 10))
                } placeholder: {
                    ProgressView()
                        .frame(width: 90)
                }
                
                Text(mealName)
            }
        }
    }
}

