//
//  RecipeViewModel.swift
//  Meally
//
//  Created by Brwerx on 8/1/24.
//

import Foundation

class RecipeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var error: String?
    
    private let apiClient = RecipeAPI()
    
    func fetchRecipes(ingredients: [String]) {
        apiClient.fetchRecipes(ingredients: ingredients) { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    print("Fetched Recipes: \(response.hits.map { $0.recipe })") // Log recipes
                    self.recipes = response.hits.map { $0.recipe }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.error = error.localizedDescription
                    print("Fetch Error: \(error.localizedDescription)") // Log errors
                }
            }
        }
    }
}

