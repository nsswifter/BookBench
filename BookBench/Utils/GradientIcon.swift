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
    init(_ name: String) {
        image = Image(name)
    }
    
    init(systemName: String) {
        image = Image(systemName: systemName)
    }
}

// MARK: - Gradient Icon View Preview

struct GradientIcon_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GradientIcon(systemName: "trash")
            GradientIcon("Google")
        }
    }
}
