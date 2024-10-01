//
//  MealDetailView.swift
//  TreatBox
//
//  Created by Bruke Wondessen on 9/26/24.
//

import SwiftUI

struct MealDetailView: View {
    @ObservedObject var mealDetailViewModel: MealDetailViewModel
    
    @State private var errorMessage: String = "Data failed to fetch..."
    
    var mealID: String
        
    var body: some View {
        ScrollView {
            if let meal = mealDetailViewModel.meal {
                VStack {
                    MealImageView(url: meal.strMealThumb ?? "", key: meal.idMeal)
                        .overlay(
                            // Meal name overlay
                            MealNameOverlay(meal: meal), alignment: .bottom)
                        .padding(.bottom, 80)
                    
                    // Ingredients/measurements and instructions
                    VStack(spacing: 20) {
                        // Ingredients and measurements
                        IngredientsAndMeasurementsView(mealDetailViewModel: mealDetailViewModel)
                        
                        // Instructions
                        InstructionsView(mealDetailViewModel: mealDetailViewModel)
                        
                        // YouTube link
                        YouTubeLinkView(mealDetailViewModel: mealDetailViewModel)
                            .padding(.bottom, 80)
                    }
                    .padding()
                    .padding(.bottom)
                }
            }
        }
        .ignoresSafeArea()
        .scrollIndicators(.hidden)
        .task {
            do {
                try await mealDetailViewModel.fetchDetails(for: mealID)
            } catch {
                print(errorMessage)
            }
        }
    }
}

//#Preview {
//    MealDetailView(mealDetailViewModel: MealDetailViewModel(), mealID: "53049")
//        .environmentObject(BookmarkViewModel())
//}
