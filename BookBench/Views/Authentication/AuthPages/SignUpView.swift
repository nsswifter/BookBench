//
//  SignUpView.swift
//  BookBench
//
//  Created by Mehdi Karami on 4/30/23.
//

import SwiftUI

// MARK: - SignUp View

struct SignUpView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    @ObservedObject var authViewModel: AuthViewModel
    
    @FocusState private var lastnameFocused: Bool
    @FocusState private var emailFocused: Bool
    @FocusState private var passwordFocused: Bool
    @FocusState private var repeatedPasswordFocused: Bool
    
    @State var errorText = ""

    var body: some View {
        VStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Sign up" )
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("Join our family with an account, focus on your plans with us and make your dreams.")
                    .font(.caption2)
                    .opacity(0.7)
            }
            
            if verticalSizeClass == .regular {
                inputView()
                    .verticalStack()
            } else {
                inputView()
                    .horizontalStack()
            }
            
            Button {
                authViewModel.signUp()
            } label: {
                Text("Sign up")
                    .bold()
                    .frame(maxWidth: .infinity)
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
            
            if let signUpError = authViewModel.signUpError {
                Text(signUpError)
                    .foregroundColor(.red)
                    .bold()
                    .font(.caption2)
                    .shadow(color: colorScheme == .dark ? .black : .white, radius: 0.5)
            }
            
            Divider()
            
            HStack {
                Text("Have an account?")
                
                Button {
                    authViewModel.currentPage = .logIn
                } label: {
                    Text("Log in")
                        .foregroundColor(.indigo)
                        .bold()
                }
            }
            .font(.caption2)
        }
        .padding()
        .background(colorScheme == .dark ? .black.opacity(0.5) : .white.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
        .padding([.leading, .trailing], verticalSizeClass == .regular ? 24 : 40)
        .animation(.linear(duration: 25), value: 25)
    }
}

// MARK: - Input Items Part

extension SignUpView {
    func inputView() -> some View {
        VStack {
            HStack(spacing: 10) {
                GradientIcon(systemName: "person.fill")
                
                TextField("Firstname", text: $authViewModel.firstname)
                    .font(.subheadline)
                    .textContentType(.givenName)
                    .disableAutocorrection(true)
                    .submitLabel(.next)
                    .onSubmit {
                        lastnameFocused = true
                    }
                
                Divider()
                
                TextField("Lastname", text: $authViewModel.lastname)
                    .font(.subheadline)
                    .textContentType(.familyName)
                    .disableAutocorrection(true)
                    .submitLabel(.next)
                    .focused($lastnameFocused)
                    .onSubmit {
                        emailFocused = true
                    }
            }
            .fixedSize(horizontal: false, vertical: true)
            .padding(8)
            .background(.indigo.opacity(0.2))
            .cornerRadius(25)
            
            HStack {
                GradientIcon(systemName: "envelope.fill")
                
                TextField("Email", text: $authViewModel.email)
                    .font(.subheadline)
                    .textContentType(.emailAddress)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .submitLabel(.next)
                    .focused($emailFocused)
                    .onSubmit {
                        passwordFocused = true
                    }
            }
            .padding(8)
            .background(.indigo.opacity(0.2))
            .cornerRadius(25)
            
            VStack(spacing: 0) {
                HStack {
                    GradientIcon(systemName: "key.fill")
                    
                    RevealableSecureField("Password",text: $authViewModel.password)
                        .font(.subheadline)
                        .textContentType(.password)
                        .keyboardType(.asciiCapable)
                        .autocapitalization(.none)
                        .submitLabel(.next)
                        .focused($passwordFocused)
                        .onSubmit {
                            repeatedPasswordFocused = true
                        }
                }
                .frame(height: 55)
                
                Divider()
                
                RevealableSecureField("Repeat Password", text: $authViewModel.repeatedPassword)
                    .font(.subheadline)
                    .textContentType(.password)
                    .keyboardType(.asciiCapable)
                    .autocapitalization(.none)
                    .submitLabel(.go)
                    .focused($repeatedPasswordFocused)
                    .frame(height: 55)
                    .onSubmit {
                        authViewModel.signUp()
                    }
            }
            .padding(8)
            .background(.indigo.opacity(0.2))
            .cornerRadius(25)
        }
    }
}

// MARK: - SignUp View Preview

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView(authViewModel: AuthViewModel())
    }
}
