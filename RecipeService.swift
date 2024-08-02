//
//  RecipeService.swift
//  Meally
//
//  Created by Brwerx on 8/1/24.
//

// RecipeService.swift

import Foundation

class RecipeService {
    func parseRecipeData(from data: Data) -> RecipeResponse? {
        let decoder = JSONDecoder()
        do {
            let response = try decoder.decode(RecipeResponse.self, from: data)
            return response
        } catch {
            print("Error decoding data: \(error)")
            return nil
        }
    }
}

