//
//  RecipeRecommendationsView.swift
//  Meally
//
//  Created by Brwerx on 7/25/24.
//

import Foundation
import SwiftUI

//struct RecipeRecommendationView: View {
//    var ingredients: [String]
//    @State private var recipes: [Recipe] = []
//
//    var body: some View {
//        List(recipes) { recipe in
//            NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
//                Text(recipe.name)
//            }
//        }
//        .onAppear {
//            fetchRecipes()
//        }
//        .navigationTitle("Recipe Recommendations")
//    }
//
//    func fetchRecipes() {
//        // Call the gRPC server to fetch recipes based on ingredients
//        // For now, we'll use mock data
//        recipes = [
//            Recipe(id: 1, name: "Recipe 1", ingredients: ["Ingredient A", "Ingredient B"]),
//            Recipe(id: 2, name: "Recipe 2", ingredients: ["Ingredient C", "Ingredient D"])
//        ]
//    }
//}
//
//struct RecipeRecommendationsView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeRecommendationView(ingredients: ["Tomato", "Cheese"])
//    }
//}

import UIKit
    
    struct RecipeListView: View {
        @StateObject private var viewModel = RecipeViewModel()
        let ingredients: [String]
        
        var body: some View {
            NavigationView {
                VStack {
                    if let error = viewModel.error {
                        Text("Error: \(error)")
                            .foregroundColor(.red)
                    }
                    
                    List(viewModel.recipes, id: \.uri) { recipe in
                        NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                            VStack(alignment: .leading) {
                                Text(recipe.label)
                                    .font(.headline)
                                Text(recipe.source)
                                    .font(.subheadline)
                                AsyncImage(url: URL(string: recipe.image)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                        }
                    }
                }
                .onAppear {
                    viewModel.fetchRecipes(ingredients: ingredients) // Fetch recipes
                }
                .navigationTitle("Recipes")
            }
        }
    }
    
    
class RecipesViewController: UIViewController {
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
