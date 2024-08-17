//
//  Recipe.swift
//  Meally
//
//  Created by Brwerx on 7/25/24.
//

import Foundation

//struct Recipe: Identifiable, Codable {
//    var id: Int
//    var name: String
//    var ingredients: [String]
//}

struct RecipeResponse: Codable {
    let from: Int
    let to: Int
    let count: Int
    let hits: [RecipeHit]
}

struct RecipeHit: Codable {
    let recipe: Recipe
}

struct Recipe: Codable {
    let uri: String
    let label: String
    let image: String
    let source: String
    let url: String
    let yield: Int
    let dietLabels: [String]?
    let healthLabels: [String]?
    let ingredientLines: [String]?
    let ingredients: [Ingredient]?
    let calories: Double?
    let totalWeight: Double?
    let cuisineType: [String]?
    let mealType: [String]?
    let dishType: [String]?
    let instructions: [String]?
    let tags: [String]?
}

struct Ingredient: Codable {
    let text: String
    let quantity: Double?
    let measure: String?
    let food: String
    let weight: Double?
    let foodId: String?
}

