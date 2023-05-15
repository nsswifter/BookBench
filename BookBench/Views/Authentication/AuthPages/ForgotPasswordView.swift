//
//  ForgotPasswordView.swift
//  BookBench
//
//  Created by Mehdi Karami on 4/30/23.
//

import SwiftUI
import FirebaseAuth

// MARK: - Forgot Password View

struct ForgotPasswordView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    @ObservedObject var authViewModel: AuthViewModel
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var resetEmailSent = false
    
    var body: some View {
        VStack(spacing: 16) {
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Forgot Password" )
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("Recover your account effortlessly with our password reset feature")
                    .font(.caption2)
                    .opacity(0.7)
            }
            
            HStack {
                GradientIcon(systemName: "envelope.fill")
                
                TextField("Email", text: $authViewModel.email)
                    .font(.subheadline)
                    .padding(17)
                    .textContentType(.emailAddress)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .submitLabel(.next)
            }
            .padding([.leading, .trailing],8)
            .background(.indigo.opacity(0.2))
            .cornerRadius(25)
            .frame(width: verticalSizeClass == .regular ? 300 : 450)

            Button {
                authViewModel.resetPassword { result, error in
                    alertMessage = result
                    showAlert = true
                    
                    if !error {
                        resetEmailSent = true
                    }
                }
            } label: {
                Text("Reset Password")
                    .bold()
                    .frame(width: verticalSizeClass == .regular ? 300 : 450)
                    .padding([.top, .bottom], 12)
                    .foregroundColor(colorScheme == .dark ? .black : .white)
                    .background(Capsule(style: .continuous)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [.blue, .indigo, .purple]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                    )
            }
        }
        .padding()
        .background(colorScheme == .dark ?
            .black.opacity(0.5) : .white.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
        .padding([.leading, .trailing], verticalSizeClass == .regular ? 50 : 100)
        .frame(maxWidth: verticalSizeClass == .regular ? 450 : 800)
        
        .alert(isPresented: $showAlert) {
            Alert(title: Text(resetEmailSent ? "Password Reset" : "Password Reset Error"),
                  message: Text(alertMessage),
                  dismissButton: .default(Text("OK")) {
                if resetEmailSent {
                    authViewModel.currentPage = .logIn
                }
            })
        }
    }
}

// MARK: - Forgot Password View Preview

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ForgotPasswordView(authViewModel: AuthViewModel())
            AuthView(authViewModel: AuthViewModel())
        }
    }
}
