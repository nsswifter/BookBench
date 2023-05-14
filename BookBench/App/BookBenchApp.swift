//
//  BookBenchApp.swift
//  BookBench
//
//  Created by Mehdi Karami on 4/30/23.
//

import SwiftUI
import Firebase

// MARK: - Entry Point of Book Bench App

@main
struct BookBenchApp: App {
    
    // The state object that manages the content view model for the app.
    @StateObject var contentViewModel = ContentViewModel()

    /// Initializes the `BookBenchApp` and configures a default Firebase app.
    init() {
        // Configures a default Firebase app.
        FirebaseApp.configure()
    }
    
    // The body of the app that defines the app's content and behavior.
    var body: some Scene {
        WindowGroup {
            ContentView(contentViewModel: contentViewModel)
        }
    }
}
