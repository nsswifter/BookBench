//
//  ContentViewModel.swift
//  BookBench
//
//  Created by Mehdi Karami on 5/8/23.
//

import Foundation

class ContentViewModel: ObservableObject {
    @Published var currentPage: ContentPage = .launchScreen

}

extension ContentViewModel {
    enum ContentPage {
        case launchScreen
        case auth
        case main
    }
    
    func goToLaunchScreenPage() {
        currentPage = .launchScreen
    }
    
    func goToAuthPage() {
        currentPage = .auth
    }
    
    func goToMainPage() {
        currentPage = .main
    }
}
