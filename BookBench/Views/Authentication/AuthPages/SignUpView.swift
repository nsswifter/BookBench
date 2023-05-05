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
    
    @ObservedObject var authFlowState: AuthFlowState
    @FocusState private var lastnameFocused: Bool
    @FocusState private var emailFocused: Bool
    @FocusState private var passwordFocused: Bool
    @FocusState private var repeatedPasswordFocused: Bool
    
    @State var firstname = ""
    @State var lastname = ""
    @State var email = ""
    @State var password = ""
    @State var repeatedPassword = ""

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
                logIn()
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
    }
    
    func inputView() -> some View {
        Group {
            VStack {
                HStack(spacing: 10) {
                    GradientIcon(systemName: "person.fill")
                    
                    TextField("Firstname", text: $firstname)
                        .font(.subheadline)
                        .padding(17)
                        .textContentType(.givenName)
                        .disableAutocorrection(true)
                        .submitLabel(.next)
                        .onSubmit {
                            lastnameFocused = true
                        }
                    
                    Divider()
                    
                    TextField("Lastname", text: $lastname)
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
                    
                    TextField("Email", text: $email)
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
            }
            
            VStack(spacing: 0) {
                HStack {
                    GradientIcon(systemName: "key.fill")
                    
                    RevealableSecureField("Password",text: $password)
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
                
                RevealableSecureField("Repeat Password", text: $repeatedPassword)
                    .font(.subheadline)
                    .padding(17)
                    .textContentType(.password)
                    .keyboardType(.asciiCapable)
                    .submitLabel(.go)
                    .focused($repeatedPasswordFocused)
                    .onSubmit {
                        logIn()
                    }
                    .frame(height: 55)
            }
            .padding([.leading, .trailing],8)
            .background(.indigo.opacity(0.2))
            .cornerRadius(25)
            .frame(width: 300, height: 110)
        }
    }
    
    func otherOptionView() -> some View {
        HStack {
            HStack {
                Text("Sign up with:")
                
                Button {
                    authFlowState.currentPage = .forgotPassword
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
                    authFlowState.currentPage = .logIn
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
    
    // TODO: Log In functionality
    func logIn() {
        
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}
