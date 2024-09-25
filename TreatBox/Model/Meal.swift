//
//  Meal.swift
//  TreatBox
//
//  Created by Bruke Wondessen on 9/25/24.
//

import Foundation

// MARK: - Meal Model

struct Meals: Codable {
    let meals: [Meal]
}

struct Meal: Codable, Identifiable {
    var id: String = UUID().uuidString
    
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
}
