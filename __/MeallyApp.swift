//
//  MeallyApp.swift
//  Meally
//
//  Created by Brwerx on 7/25/24.
//

import SwiftUI

@main
struct MeallyApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
//import CoreData
//
//@main
//struct MeallyApp: App {
//    var body: some Scene {
//        WindowGroup {
//            NavigationStack {
//                HomeView()
//            }
//        }
//    }
//}
//
//struct ContentView: View {
//    var body: some View {
//        VStack {
//            Text("Meally")
//                .font(.largeTitle)
//                .fontWeight(.bold)
//                .padding()
//            
//            // Navigation Links
//            NavigationLink(destination: SearchForRecipesView()) {
//                Text("Go to Search for Recipes")
//                    .padding()
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(8)
//            }
//            .padding()
//            
//            NavigationLink(destination: SettingsView()) {
//                Text("Go to Settings")
//                    .padding()
//                    .background(Color.gray)
//                    .foregroundColor(.white)
//                    .cornerRadius(8)
//            }
//            .padding()
//        }
//        .navigationBarHidden(true)
//    }
//}
//
