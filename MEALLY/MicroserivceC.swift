//
//  MicroserivceC.swift
//  Meally
//
//  Created by Brwerx on 8/16/24.
//

import Foundation

struct SaveFavoriteRequest: Codable {
    let recipeId: String
}

struct FavoriteResponse: Codable {
    let success: Bool
    let message: String?
}

class FavoritesService {
    private let baseURL = "https://meally-3oztxoalm-mikaellas-projects-19988d2b.vercel.app"
    
    func saveFavorite(recipeId: String, completion: @escaping (Result<FavoriteResponse, Error>) -> Void) {
        let url = URL(string: "\(baseURL)/favorites")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = SaveFavoriteRequest(recipeId: recipeId)
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data"])))
                return
            }
            do {
                let favoriteResponse = try JSONDecoder().decode(FavoriteResponse.self, from: data)
                completion(.success(favoriteResponse))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchFavorites(completion: @escaping (Result<[Recipe], Error>) -> Void) {
        let url = URL(string: "\(baseURL)/favorites")!
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data"])))
                return
            }
            do {
                let recipes = try JSONDecoder().decode([Recipe].self, from: data)
                completion(.success(recipes))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
