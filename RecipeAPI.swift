//
//  RecipeAPI.swift
//  Meally
//
//  Created by Brwerx on 8/1/24.
//

import Foundation

struct RecipeAPI {
    private let baseURL = "https://api.edamam.com/api/recipes/v2"
    private let appID = "02d1ec65"
    private let appKey = "cb2a4f43c4f25aa0e9d909fc1feb5219"
    
    func fetchRecipes(ingredients: [String], completion: @escaping (Result<RecipeResponse, Error>) -> Void) {
        let ingredientQuery = ingredients.joined(separator: ",")
        let urlString = "\(baseURL)?type=public&q=\(ingredientQuery)&app_id=\(appID)&app_key=\(appKey)"
        print("Request URL: \(urlString)") // Print the URL

        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: 100, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Network Error: \(error.localizedDescription)") // Log network errors
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                print("No Data Error") // Log if data is nil
                completion(.failure(NSError(domain: "", code: 100, userInfo: [NSLocalizedDescriptionKey: "No data"])))
                return
            }
            print(data)
            
            do {
                let recipeResponse = try JSONDecoder().decode(RecipeResponse.self, from: data)
                print("API Response: \(recipeResponse)") // Print the decoded response
                completion(.success(recipeResponse))
            } catch {
                let responseString = String(data: data, encoding: .utf8)
                print("Raw Response: \(responseString ?? "No response")") // Print raw response for debugging
                print("JSON Decoding Error: \(error)")
                completion(.failure(error))
            }
        }
        
        task.resume()
    }

    
}
