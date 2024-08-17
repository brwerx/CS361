//
//  Home.swift
//  Meally
//
//  Created by Brwerx on 7/31/24.
//

import Foundation
import SwiftUI

struct HomeView: View {
    @State private var message: String = "Okay"
    var body: some View {
        NavigationStack {
            VStack {
                // App Name
                Text("Meally")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()

                // Recipe Suggestions
                VStack(alignment: .leading) {
                    Text("Based on Your Recent Searches")
                        .font(.title2)
                        .padding(.horizontal)

                    // Placeholder for suggested recipes
                    ScrollView {
                        VStack(alignment: .leading) {
                            ForEach(0..<5) { _ in
                                RecipeCard()
                            }
                        }
                    }
                }
                .padding()
                .toolbar(.hidden)

                Spacer()

                // Tab Bar
                HStack {
                    NavigationLink(destination: SearchForRecipesView()) {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                    .padding()

                    Spacer()

                    NavigationLink(destination: HomeView()) {
                        Image(systemName: "house")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                    .padding()

                    Spacer()

                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gearshape")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                    .padding()
                }
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.2))
            }
        }
    }
}

struct RecipeCard: View {
    var body: some View {
        HStack {
            // Placeholder for recipe image
            Rectangle()
                .fill(Color.gray)
                .frame(width: 100, height: 100)
                .cornerRadius(8)
            
            VStack(alignment: .leading) {
                Text("Recipe Name")
                    .font(.headline)
                
                Text("Short description of the recipe.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(.leading)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 5)
    }
}

struct IngredientSearchView: View {
    var body: some View {
        Text("Ingredient Search View")
    }
}

struct SettingsView: View {
    var body: some View {
        Text("Settings View")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
