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
    var image: Image
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .indigo, .purple]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .cornerRadius(15)
            
            image
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .font(.title2)
                .foregroundColor(colorScheme == .dark ? .black : .white)
        }
        .frame(width: 40, height: 40)
    }
}

extension GradientIcon {
    /// Creates a gradient icon with a custom image.
    /// - Parameter name: The name of the custom image.
    init(_ name: String) {
        image = Image(name)
    }
    
    /// Creates a gradient icon with a system icon.
    /// - Parameter systemName: The name of the system icon.
    init(systemName: String) {
        image = Image(systemName: systemName)
    }
}

// MARK: - Gradient Icon View Preview

struct GradientIcon_Previews: PreviewProvider {
    static var previews: some View {
        GradientIcon(systemName: "trash")
    }
}
