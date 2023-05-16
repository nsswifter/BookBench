//
//  MainView.swift
//  BookBench
//
//  Created by Mehdi Karami on 5/8/23.
//

import SwiftUI

// MARK: - Main View

struct MainView: View {
    @ObservedObject var authViewModel: AuthViewModel

    var body: some View {
        
        // TODO: Complete this View for Booking and more
        
        Text("This is Main View")
    }
}

// MARK: - Main View Preview

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(authViewModel: AuthViewModel())
    }
}
