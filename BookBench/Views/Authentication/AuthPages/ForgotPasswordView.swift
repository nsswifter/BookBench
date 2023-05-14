//
//  ForgotPasswordView.swift
//  BookBench
//
//  Created by Mehdi Karami on 4/30/23.
//

import SwiftUI

// MARK: - Forgot Password View

struct ForgotPasswordView: View {
    @ObservedObject var authViewModel: AuthViewModel
    
    var body: some View {
        Text("Tap")
    }
}

// MARK: - Forgot Password View Preview

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView(authViewModel: AuthViewModel())
    }
}
