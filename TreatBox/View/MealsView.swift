//
//  MealsView.swift
//  TreatBox
//
//  Created by Bruke Wondessen on 9/24/24.
//

import SwiftUI

struct MealsView: View {
    static let tab: String = "MealsView"
    
    @StateObject var mealViewModel: MealViewModel = MealViewModel()
    
    @State private var errorMessage: String = "Data failed to fetch..."
    @State private var path: [String] = [String]() // Navigation path
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationStack(path: $path ) {
            // List of meals
            List(searchResults) { meal in
                MealListView(path: $path, meal: meal)
                
            }
            .navigationTitle("TreatBox")
            .scrollContentBackground(.hidden)
            .navigationDestination(for: String.self) { selection in
                MealDetailView(mealDetailViewModel: MealDetailViewModel(), mealID: selection)
            }
            .searchable(text: $searchText)
        }
        .tint(.primary)
        .task {
            do {
                try await mealViewModel.fetchMeals()
            } catch {
                print(errorMessage)
            }
        }
    }
    
    var searchResults: [Meal] {
        if searchText.isEmpty {
            return mealViewModel.meals
        } else {
            return mealViewModel.meals.filter { $0.strMeal.lowercased().contains(searchText.lowercased()) }
        }
    }
}

#Preview {
    MealsView()
}
