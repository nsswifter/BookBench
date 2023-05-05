//
//  LogInView.swift
//  BookBench
//
//  Created by Mehdi Karami on 4/30/23.
//

import SwiftUI

struct LogInView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    @ObservedObject var authFlowState: AuthFlowState
    @FocusState private var passwordFocused: Bool
    
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        VStack(spacing: 16) {
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Log in" )
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("Reserve a seat and study in a great environment, work on your projects and use the library's rich collection of books.")
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
                Text("Log in")
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
            
            if verticalSizeClass == .regular {
                otherOptionView.verticalStack(alignment: .leading)
            } else {
                otherOptionView.horizontalStack()
            }
        }
        .padding()
        .background(colorScheme == .dark ?
            .black.opacity(0.5) : .white.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
        .padding([.leading, .trailing], verticalSizeClass == .regular ? 50 : 100)
    }
    
    func inputView() -> some View {
        Group {
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
                    .onSubmit {
                        passwordFocused = true
                    }
            }
            .padding([.leading, .trailing],8)
            .background(.indigo.opacity(0.2))
            .cornerRadius(25)
            .frame(width: 300)
            
            HStack {
                GradientIcon(systemName: "key.fill")
                
                RevealableSecureField("Password",text: $password)
                    .font(.subheadline)
                    .padding(17)
                    .textContentType(.password)
                    .keyboardType(.asciiCapable)
                    .submitLabel(.go)
                    .focused($passwordFocused)
                    .onSubmit {
                        logIn()
                    }
            }
            .padding([.leading, .trailing],8)
            .background(.indigo.opacity(0.2))
            .cornerRadius(25)
            .frame(width: 300)
        }
    }
    
    var otherOptionView: some View {
        Group {
            HStack {
                Text("Don't have an account?")
                
                Button {
                    authFlowState.currentPage = .signUp
                } label: {
                    Text("Sign up")
                        .foregroundColor(.indigo)
                        .bold()
                }
            }
            .padding(.bottom, 1)
            
            if verticalSizeClass != .regular {
                Spacer()
            }
            
            HStack {
                Text("Forgot password?")
                
                Button {
                    authFlowState.currentPage = .forgotPassword
                } label: {
                    Text("Reset Password")
                        .foregroundColor(.indigo)
                        .bold()
                }
            }
        }
        .font(.caption2)
    }
    
    // TODO: Log In functionality
    func logIn() {
        
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            AuthenticationView()
        }
    }
}
