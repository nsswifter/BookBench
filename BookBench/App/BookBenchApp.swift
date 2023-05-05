//
//  BookBenchApp.swift
//  BookBench
//
//  Created by Mehdi Karami on 4/30/23.
//

import SwiftUI
import Firebase

@main
struct BookBenchApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
