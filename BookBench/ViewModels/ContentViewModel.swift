//
//  ContentViewModel.swift
//  BookBench
//
//  Created by Mehdi Karami on 5/8/23.
//

import Foundation

// MARK: - Content View Model

/// A view model that manages the current page of content being displayed.
class ContentViewModel: ObservableObject {
    @Published var currentPage: ContentPage = .launchScreen
}

// MARK: - Navigating Between Content Pages

extension ContentViewModel {
    /// An enumeration of the possible Content current pages.
    enum ContentPage {
        case launchScreen
        case auth
        case main
    }
}
