//
//  MealDetailViewModel.swift
//  TreatBox
//
//  Created by Bruke Wondessen on 9/26/24.
//

import Foundation

class MealDetailViewModel: ObservableObject {
    @Published var meal: MealDetail?
    
    // Fetch details
    func fetchDetails(for mealID: String) async throws {
        // Endpoint
        let endpoint: String = "https://themealdb.com/api/json/v1/1/lookup.php?i=\(mealID)"
        
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
            if let data = try? JSONDecoder().decode(MealDetails.self, from: data) {
                // Update UI on main thread
                DispatchQueue.main.async {
                    self.meal = data.meals.first
                }
            }
        } catch {
            throw NetworkingError.invalidData
        }
    }
}
