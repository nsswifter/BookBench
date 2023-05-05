//
//  SignUpView.swift
//  BookBench
//
//  Created by Mehdi Karami on 4/30/23.
//

import SwiftUI

struct SignUpView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    @ObservedObject var authViewModel: AuthViewModel
    
    @FocusState private var lastnameFocused: Bool
    @FocusState private var emailFocused: Bool
    @FocusState private var passwordFocused: Bool
    @FocusState private var repeatedPasswordFocused: Bool
    
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
                    .frame(width: verticalSizeClass == .regular ? 300 : 605)
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
            
            otherOptionView()
        }
        .padding()
        .background(colorScheme == .dark ?
            .black.opacity(0.5) : .white.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
        .padding([.leading, .trailing], verticalSizeClass == .regular ? 50 : 100)
        .frame(maxWidth: verticalSizeClass == .regular ? 420 : 800)
    }
}
    
extension SignUpView {
    func inputView() -> some View {
        Group {
            VStack {
                HStack(spacing: 10) {
                    GradientIcon(systemName: "person.fill")
                    
                    TextField("Firstname", text: $authViewModel.firstname)
                        .font(.subheadline)
                        .padding(17)
                        .textContentType(.givenName)
                        .disableAutocorrection(true)
                        .submitLabel(.next)
                        .onSubmit {
                            lastnameFocused = true
                        }
                    
                    Divider()
                    
                    TextField("Lastname", text: $authViewModel.lastname)
                        .font(.subheadline)
                        .padding(17)
                        .textContentType(.familyName)
                        .disableAutocorrection(true)
                        .submitLabel(.next)
                        .focused($lastnameFocused)
                        .onSubmit {
                            emailFocused = true
                        }
                }
                .padding([.leading, .trailing],8)
                .background(.indigo.opacity(0.2))
                .cornerRadius(25)
                .frame(width: 300, height: 50)
                
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
                        .focused($emailFocused)
                        .onSubmit {
                            passwordFocused = true
                        }
                }
                .padding([.leading, .trailing],8)
                .background(.indigo.opacity(0.2))
                .cornerRadius(25)
                .frame(width: 300, height: 50)
            }
            
            VStack(spacing: 0) {
                HStack {
                    GradientIcon(systemName: "key.fill")
                    
                    RevealableSecureField("Password",text: $authViewModel.password)
                        .font(.subheadline)
                        .padding(17)
                        .textContentType(.password)
                        .keyboardType(.asciiCapable)
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
                    .padding(17)
                    .textContentType(.password)
                    .keyboardType(.asciiCapable)
                    .submitLabel(.go)
                    .focused($repeatedPasswordFocused)
                    .onSubmit {
                        authViewModel.logIn()
                    }
                    .frame(height: 55)
            }
            .padding([.leading, .trailing],8)
            .background(.indigo.opacity(0.2))
            .cornerRadius(25)
            .frame(width: 300, height: 110)
        }
    }
}
 
extension SignUpView {
    func otherOptionView() -> some View {
        HStack {
            HStack {
                Text("Sign up with:")
                
                Button {
                    
                } label: {
                    GradientIcon(systemName: "")
                }
            }
            
            if verticalSizeClass != .regular {
                Spacer()
            }
            
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
            .padding(.bottom, 1)
        }
        .font(.caption2)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView(authViewModel: AuthViewModel())
    }
}
