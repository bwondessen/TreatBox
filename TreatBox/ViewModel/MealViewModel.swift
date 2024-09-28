//
//  MealViewModel.swift
//  TreatBox
//
//  Created by Bruke Wondessen on 9/25/24.
//

import Foundation

class MealViewModel: ObservableObject {
    @Published var meals: [Meal] = [Meal]()
    
    // Fetch meals
    func fetchMeals() async throws {
        // Endpoint
        let endpoint: String = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
        
        // Validate and create URL
        guard let url = URL(string: endpoint) else {
            throw NetworkingError.invalidURL
        }
        
        // Fetch data
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
    
    // Validate data
    private func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        // Validate HTTP URL response status code
        guard let response = output.response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode <= 300 else {
            throw NetworkingError.invalidResponse
        }
        
        return output.data
    }
}
