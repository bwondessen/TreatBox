//
//  MealViewModel.swift
//  TreatBox
//
//  Created by Bruke Wondessen on 9/25/24.
//

import Foundation
import Combine

// MARK: - Meal ViewModel
class MealViewModel: ObservableObject {
    @Published var meals: [Meal] = [Meal]()
    
    var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    
    
    func fetchMeals() async throws {
        // Endpoint
        let endpoint: String = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
        
        // Validate and create URL
        guard let url = URL(string: endpoint) else {
            throw NetworkingError.invalidURL
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background)) // Download on background thread
            .receive(on: DispatchQueue.main) // Receive on main thread
            .tryMap(handleOutput)
            .decode(type: Meals.self, decoder: JSONDecoder()) // Decode data from URL
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error downloading data: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] data in
                self?.meals = data.meals
            }
            .store(in: &cancellables)
    }
    
    private func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        // Validate HTTP URL response status code
        guard let response = output.response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode <= 300 else {
            throw NetworkingError.invalidResponse
        }
        
        return output.data
    }
}

// MARK: - Networking errors (Meal ViewModel)
enum NetworkingError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
