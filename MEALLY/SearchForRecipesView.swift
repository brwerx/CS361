import Foundation
import SwiftUI

struct SearchForRecipesView: View {
    @State private var ingredients: [String] = ["", "", "", "", ""]
    @State private var extraIngredients: [String] = []
    @State private var ingredientOptions: [String] = ["Tomato", "Cheese", "Chicken", "Onion", "Garlic"]
    @State private var showAlert: Bool = false
    @State private var isLoading: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                // App Name
                Text("Meally")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                // Heading
                Text("Please list a minimum of FIVE ingredients. This will help provide more accurate recipes:")
                    .font(.title2)
                    .padding()
                    .fixedSize(horizontal: false, vertical: true)
                
                // Text Fields
                ScrollView {
                    VStack {
                        ForEach(0..<ingredients.count, id: \.self) { index in
                            IngredientTextField(ingredient: $ingredients[index], options: ingredientOptions, onDelete: {
                                removeIngredient(at: index)
                            })
                        }
                        
                        ForEach(extraIngredients.indices, id: \.self) { index in
                            IngredientTextField(ingredient: $extraIngredients[index], options: ingredientOptions, onDelete: {
                                removeExtraIngredient(at: index)
                            })
                        }
                    }
                    .padding()
                }
                .toolbar(.hidden)
                
                // Confirm Button
                HStack {
                    Button(action: addIngredientField) {
                        HStack {
                            Image(systemName: "plus")
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                    
                    Spacer()
                    
                    NavigationLink(destination: RecipeListView(ingredients: ingredients + extraIngredients)) {
                        Image(systemName: "checkmark")
                            .font(.headline)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .disabled(!isFormValid())
                }
                .padding(.top)
                
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
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Missing Ingredients"),
                    message: Text("Please fill in all five required ingredients before proceeding."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
    
    func addIngredientField() {
        extraIngredients.append("")
    }
    
    func removeIngredient(at index: Int) {
        if index < ingredients.count {
            ingredients.remove(at: index)
        }
    }
    
    func removeExtraIngredient(at index: Int) {
        if index < extraIngredients.count {
            extraIngredients.remove(at: index)
        }
    }
    
    func isFormValid() -> Bool {
        // Check if the first five ingredients are not empty
        return ingredients.allSatisfy { !$0.isEmpty }
    }
}

struct IngredientTextField: View {
    @Binding var ingredient: String
    var options: [String]
    var onDelete: () -> Void
    
    var body: some View {
        HStack {
            TextField("Enter ingredient", text: $ingredient)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Menu {
                ForEach(options, id: \.self) { option in
                    Button(action: {
                        ingredient = option
                    }) {
                        Text(option)
                    }
                }
            } label: {
                Image(systemName: "chevron.down")
                    .padding()
            }
            
            Button(action: onDelete) {
                Image(systemName: "trash")
                    .foregroundColor(.red)
                    .padding()
            }
        }
    }
}

struct RecipeRecommendationsView: View {
    var ingredients: [String]
    
    var body: some View {
        Text("Recipe Recommendations View")
    }
}

struct SearchForRecipesView_Previews: PreviewProvider {
    static var previews: some View {
        SearchForRecipesView()
    }
}
