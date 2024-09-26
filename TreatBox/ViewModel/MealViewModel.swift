//
//  MealViewModel.swift
//  TreatBox
//
//  Created by Bruke Wondessen on 9/25/24.
//

import Foundation

// MARK: - Meal ViewModel
class MealViewModel: ObservableObject {
    @Published var meals: [Meal] = [Meal]()
    
    func fetchMeals() async throws {
        // Endpoint
        let endpoint = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
        
        // Validate and create URL
        guard let url = URL(string: endpoint) else {
            throw NetworkingError.invalidURL
        }
        
        do {
            // Fetch data from URL
            let (data, response) = try await URLSession.shared.data(from: url)
            
            // Validate HTTP response status code
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw NetworkingError.invalidResponse
            }
            
            // Decode data from URL
            if let data = try? JSONDecoder().decode(Meals.self, from: data) {
                // Update UI on main thread
                DispatchQueue.main.async {
                    self.meals = data.meals
                }
            }
        } catch {
            throw NetworkingError.invalidData
        }
    }
}

// MARK: - Networking errors (Meal ViewModel)
enum NetworkingError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
