//
//  RecipeDetailView.swift
//  Meally
//
//  Created by Brwerx on 7/25/24.
//

import Foundation
import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(recipe.label)
                    .font(.largeTitle)
                    .padding(.bottom, 10)
                
                AsyncImage(url: URL(string: recipe.image)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                } placeholder: {
                    ProgressView()
                }
                
                Text("Source: \(recipe.source)")
                    .font(.headline)
                    .padding(.bottom, 5)

                Text("Ingredients:")
                    .font(.headline)
                    .padding(.bottom, 5)

                if let ingredientLines = recipe.ingredientLines {
                    ForEach(ingredientLines, id: \.self) { ingredient in
                        Text(ingredient)
                    }
                } else {
                    Text("No ingredients available")
                }
                
                Text("Instructions:")
                    .font(.headline)
                    .padding(.top, 10)
                
                if let instructions = recipe.instructions {
                    ForEach(instructions, id: \.self) { instruction in
                        Text("• \(instruction)")
                    }
                } else {
                    Text("No instructions available")
                }

            }
            .padding()
        }
        .navigationTitle(recipe.label)
    }
}
