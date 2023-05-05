//
//  ForgotPasswordView.swift
//  BookBench
//
//  Created by Mehdi Karami on 4/30/23.
//

import SwiftUI

struct ForgotPasswordView: View {
    @ObservedObject var authViewModel: AuthViewModel

    var body: some View {
        Text("ForgotPasswordView")
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView(authViewModel: AuthViewModel())
    }
}
