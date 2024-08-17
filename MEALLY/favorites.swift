//
//  favorites.swift
//  Meally
//
//  Created by Brwerx on 8/16/24.
//

import Foundation
import UIKit

class RecipeDetailViewController: UIViewController {
    let favoritesService = FavoritesService()
    
    var recipeId: String? // This should be set to the recipe ID you want to save
    
    @IBAction func saveFavoriteButtonTapped(_ sender: UIButton) {
        guard let recipeId = recipeId else { return }
        
        favoritesService.saveFavorite(recipeId: recipeId) { result in
            switch result {
            case .success(let response):
                print("Save favorite successful: \(response)")
                // Update UI or show confirmation to the user
            case .failure(let error):
                print("Save favorite error: \(error)")
                // Show error to the user
            }
        }
    }
}

class FavoritesViewController: UIViewController {
    let favoritesService = FavoritesService()
    var favoriteRecipes: [Recipe] = [] // This will hold your fetched recipes
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchFavoriteRecipes()
    }
    
    func fetchFavoriteRecipes() {
        favoritesService.fetchFavorites { result in
            switch result {
            case .success(let recipes):
                self.favoriteRecipes = recipes
                DispatchQueue.main.async {
                    // Reload your UI with the fetched recipes
                }
            case .failure(let error):
                print("Fetch favorites error: \(error)")
                // Show error to the user
            }
        }
    }
}
