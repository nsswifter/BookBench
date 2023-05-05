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
    @StateObject var authViewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(authViewModel: authViewModel)
        }
    }
}
