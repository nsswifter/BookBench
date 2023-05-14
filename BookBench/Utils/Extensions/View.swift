//
//  View.swift
//  BookBench
//
//  Created by Mehdi Karami on 4/30/23.
//

import SwiftUI

// MARK: - Horizontal and Vertical Stack

/// A set of convenience methods for creating horizontal and vertical stacks of views.
extension View {
    /// Returns an HStack with the current view added as a child view.
    /// - Parameters:
    ///     - alignment: The vertical alignment of child views within the HStack. Default is `.center`.
    ///     - spacing: The spacing between child views. Default is `nil`, which means the system default spacing is used.
    /// - Returns: An HStack with the current view added as a child view.
    func horizontalStack(alignment: VerticalAlignment = .center, spacing: CGFloat? = nil) -> some View {
        HStack(alignment: alignment, spacing: spacing) {
            self
        }
    }
    
    /// Returns a VStack with the current view added as a child view.
    /// - Parameters:
    ///     - alignment: The horizontal alignment of child views within the VStack. Default is `.center`.
    ///     - spacing: The spacing between child views. Default is `nil`, which means the system default spacing is used.
    /// - Returns: A VStack with the current view added as a child view.
    func verticalStack(alignment: HorizontalAlignment = .center,  spacing: CGFloat? = nil) -> some View {
        VStack(alignment: alignment, spacing: spacing) {
            self
        }
    }
}

// MARK: - Hide Keyboard

extension View {
    /// A convenience method for hiding the keyboard when editing ends on a view that is currently the first responder.
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
