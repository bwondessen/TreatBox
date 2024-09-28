//
//  MealDetail.swift
//  TreatBox
//
//  Created by Bruke Wondessen on 9/26/24.
//

import Foundation

struct MealDetails: Decodable {
    let meals: [MealDetail]
}

struct MealDetail: Codable {
    let idMeal: String
    let strMeal: String
    let strDrinkAlternate: String?
    let strCategory:String?
    let strArea: String?
    let strInstructions: String?
    let strMealThumb: String?
    let strTags: String?
    let strYoutube: String?
    let strIngredient1: String?
    let strIngredient2: String
    let strIngredient3: String
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    let strIngredient16: String?
    let strIngredient17: String?
    let strIngredient18: String?
    let strIngredient19: String?
    let strIngredient20: String?
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
    let strMeasure9: String?
    let strMeasure10: String?
    let strMeasure11: String?
    let strMeasure12: String?
    let strMeasure13: String?
    let strMeasure14: String?
    let strMeasure15: String?
    let strMeasure16: String?
    let strMeasure17: String?
    let strMeasure18: String?
    let strMeasure19: String?
    let strMeasure20: String?
    let strSource: String?
    let strImageSource: String?
    let strCreativeCommonsConfirmed: String?
    let dateModified: String?
    
    static let mealDetailPreview: MealDetail = MealDetail(idMeal: "52858", strMeal: "New York Cheesecake", strDrinkAlternate: "", strCategory: "American", strArea: "", strInstructions: "", strMealThumb: "", strTags: "", strYoutube: "", strIngredient1: "eggs", strIngredient2: "flour", strIngredient3: "sugar", strIngredient4: "brown sugar", strIngredient5: "cream", strIngredient6: "cream cheese", strIngredient7: "butter", strIngredient8: "vanilla", strIngredient9: "graham cracker", strIngredient10: "", strIngredient11: "", strIngredient12: "", strIngredient13: "", strIngredient14: "", strIngredient15: "", strIngredient16: "", strIngredient17: "", strIngredient18: "", strIngredient19: "", strIngredient20: "", strMeasure1: "10", strMeasure2: "1", strMeasure3: "2", strMeasure4: "5", strMeasure5: "18", strMeasure6: "3", strMeasure7: "", strMeasure8: "", strMeasure9: "", strMeasure10: "", strMeasure11: "", strMeasure12: "", strMeasure13: "", strMeasure14: "", strMeasure15: "", strMeasure16: "", strMeasure17: "", strMeasure18: "", strMeasure19: "", strMeasure20: "", strSource: "", strImageSource: "", strCreativeCommonsConfirmed: "", dateModified: "")
    
    // Get and format ingredients
    var ingredients: [String] {
        let reflection = Mirror(reflecting: self)
        
        let children = reflection.children
        
        var ingredients: [String] = []
        
        for child in children {
            if child.label!.contains("strIngredient") {
                guard let value = child.value as? String, !value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { continue }
                
                ingredients.append(value)
            }
        }
        
        return ingredients
    }
    
    // Get and format measurements
    var measurements: [String] {
        let reflection = Mirror(reflecting: self)
        
        let children = reflection.children
        
        var ingredients: [String] = []
        
        for child in children {
            if child.label!.contains("strMeasure") {
                guard let value = child.value as? String, !value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { continue }
                
                ingredients.append(value)
            }
        }
        
        return ingredients
    }
    
    // Get and format instructions
    var instructions: [String] {
        var instructions: [String] = self.strInstructions?.components(separatedBy: "\r\n") ?? ["N/A"]
        instructions = instructions.filter { $0 != "" }
                
        return instructions
    }
}
