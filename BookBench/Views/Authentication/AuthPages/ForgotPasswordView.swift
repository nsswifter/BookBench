//
//  ForgotPasswordView.swift
//  BookBench
//
//  Created by Mehdi Karami on 4/30/23.
//

import SwiftUI

// MARK: - Forgot Password View

struct ForgotPasswordView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    @Environment (\.dismiss) var dismiss
    
    @ObservedObject var authViewModel: AuthViewModel
    
    var body: some View {
        ZStack {
            
            HStack {
                Button {
                    authViewModel.currentPage = .logIn
                } label: {
                    GradientIcon(systemName: "arrowshape.turn.up.backward.fill")
                }
                .padding(.top, 30)
                .padding(.leading, 50)

                Spacer()
            }
            .frame(maxHeight: .infinity, alignment: .top)
            
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
                    authViewModel.resetPassword()
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
                
                Divider()
                
                HStack {
                    Text("Don't have an account?")
                    
                    Button {
                        authViewModel.currentPage = .signUp
                    } label: {
                        Text("Sign up")
                            .foregroundColor(.indigo)
                            .bold()
                    }
                }
                .font(.caption2)
            }
            .padding()
            .background(colorScheme == .dark ?
                .black.opacity(0.5) : .white.opacity(0.5))
            .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
            .padding([.leading, .trailing], verticalSizeClass == .regular ? 50 : 100)
            .frame(maxWidth: verticalSizeClass == .regular ? 420 : 650)
            
            .alert(isPresented: $authViewModel.showResetAlert) {
                Alert(title: Text(authViewModel.resetEmailSent ?
                                  "Password Reset" : "Password Reset Error"),
                      message: Text(authViewModel.resetEmailAlertMessage),
                      dismissButton: .default(Text("OK")) {
                    if authViewModel.resetEmailSent {
                        authViewModel.currentPage = .logIn
                    }
                })
            }
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
