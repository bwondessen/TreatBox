//
//  Meal.swift
//  TreatBox
//
//  Created by Bruke Wondessen on 9/25/24.
//

import Foundation

struct Meals: Codable {
    let meals: [Meal]
}

struct Meal: Identifiable, Codable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
    
    var id: String { idMeal }
}
