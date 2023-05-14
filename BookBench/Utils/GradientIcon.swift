//
//  GradientIcon.swift
//  BookBench
//
//  Created by Mehdi Karami on 4/30/23.
//

import SwiftUI

// MARK: - Gradient Icon View

/// A view that displays an icon with a gradient background.
struct GradientIcon: View {
    
    // The color scheme of the parent environment.
    @Environment(\.colorScheme) private var colorScheme
    
    // The system name of the icon to display.
    var systemName: String
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .indigo, .purple]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .cornerRadius(15)
            
            Image(systemName: systemName)
                .font(.title2)
                .foregroundColor(colorScheme == .dark ? .black : .white)
        }
        .frame(width: 40, height: 40)
    }
}

// MARK: - Gradient Icon View Preview

struct GradientIcon_Previews: PreviewProvider {
    static var previews: some View {
        GradientIcon(systemName: "tree")
    }
}
