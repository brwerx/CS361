//
//  MicroserivceB.swift
//  Meally
//
//  Created by Brwerx on 8/16/24.
//

import Foundation

struct RegisterRequest: Codable {
    let username: String
    let password: String
}

struct RegisterResponse: Codable {
    let success: Bool
    let message: String?
}

class AccountService {
    private let baseURL = "https://meally-3oztxoalm-mikaellas-projects-19988d2b.vercel.app"
    
    func registerAccount(username: String, password: String, completion: @escaping (Result<RegisterResponse, Error>) -> Void) {
        let url = URL(string: "\(baseURL)/register")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = RegisterRequest(username: username, password: password)
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
                let registerResponse = try JSONDecoder().decode(RegisterResponse.self, from: data)
                completion(.success(registerResponse))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
