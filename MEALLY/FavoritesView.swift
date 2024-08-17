//
//  FavoritesView.swift
//  Meally
//
//  Created by Brwerx on 8/16/24.
//

import Foundation
import SwiftUI

struct FavoritesView: View {
    @State private var searchText: String = ""
    @State private var favoriteRecipes: [Recipe] = []
    
    private let favoritesService = FavoritesService()
    private let userId = "yourUserId" // Replace with the actual user ID
    
    var filteredFavorites: [Recipe] {
        if searchText.isEmpty {
            return favoriteRecipes
        } else {
            return favoriteRecipes.filter { $0.label.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        VStack {
            // Search bar
            SearchBar(text: $searchText)
                .padding()
            
            List(filteredFavorites, id: \.uri) { recipe in
                NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                    HStack {
                        AsyncImage(url: URL(string: recipe.image)) { image in
                            image
                                .resizable()
                                .frame(width: 50, height: 50)
                                .cornerRadius(5)
                        } placeholder: {
                            ProgressView()
                        }
                        
                        Text(recipe.label)
                            .font(.headline)
                            .padding(.leading, 5)
                    }
                }
            }
        }
        .onAppear {
            fetchFavorites()
        }
        .navigationTitle("Favorites")
    }
    
    private func fetchFavorites() {
        favoritesService.fetchFavorites(userId: userId) { result in
            switch result {
            case .success(let recipes):
                DispatchQueue.main.async {
                    self.favoriteRecipes = recipes
                }
            case .failure(let error):
                print("Error fetching favorites: \(error)")
            }
        }
    }
}

struct SearchBar: UIViewRepresentable {
    @Binding var text: String

    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text)
    }

    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar()
        searchBar.delegate = context.coordinator
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
    }
}
