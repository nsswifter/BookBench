//
//  ContentView.swift
//  BookBench
//
//  Created by Mehdi Karami on 4/30/23.
//

import SwiftUI

// MARK: - Content View

struct ContentView: View {
    @ObservedObject var contentViewModel: ContentViewModel
    @StateObject var authViewModel = AuthViewModel()

    var body: some View {
        ZStack {
            Group {
                switch contentViewModel.currentPage {
                case .launchScreen:
                    LaunchScreenView()
                case .auth:
                    AuthView(authViewModel: authViewModel)
                case .main:
                    MainView(authViewModel: authViewModel)
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline:.now() + 3) {
                    withAnimation(.easeOut(duration: 0.5)) {
                        if authViewModel.isLoggedIn {
                            contentViewModel.currentPage = .main
                        } else {
                            contentViewModel.currentPage = .auth
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Content View Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(contentViewModel: ContentViewModel())
    }
}
