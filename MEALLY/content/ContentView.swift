//
//  ContentView.swift
//  Meally
//
//  Created by Brwerx on 7/25/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        HomeView()
            .toolbar(.hidden)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .toolbar(.hidden)
    }
}
