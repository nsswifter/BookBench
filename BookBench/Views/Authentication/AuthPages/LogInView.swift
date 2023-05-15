//
//  LogInView.swift
//  BookBench
//
//  Created by Mehdi Karami on 4/30/23.
//

import SwiftUI

// MARK: - LogIn View

struct LogInView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    @ObservedObject var authViewModel: AuthViewModel
    
    @FocusState private var passwordFocused: Bool
    
    @State var loginError: String?
    
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
                authViewModel.logIn { result in
                    if let error = result {
                        loginError = error
                    }
                }
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
            
            if let loginError {
                Text(loginError)
                    .foregroundColor(.red)
                    .bold()
                    .font(.caption2)
                    .shadow(color: colorScheme == .dark ? .black : .white, radius: 0.5)
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
        .frame(maxWidth: verticalSizeClass == .regular ? 450 : 800)
        .animation(.linear(duration: 25), value: 25)
    }
}
 
// MARK: - Input Items Part

extension LogInView {
    func inputView() -> some View {
        Group {
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
                
                RevealableSecureField("Password",text: $authViewModel.password)
                    .font(.subheadline)
                    .padding(17)
                    .textContentType(.password)
                    .keyboardType(.asciiCapable)
                    .autocapitalization(.none)
                    .submitLabel(.go)
                    .focused($passwordFocused)
                    .onSubmit {
                        authViewModel.logIn { result in
                            if let error = result {
                                loginError = error
                            }
                        }
                    }
            }
            .padding([.leading, .trailing],8)
            .background(.indigo.opacity(0.2))
            .cornerRadius(25)
            .frame(width: 300)
        }
    }
}

// MARK: - Other Option Items Part

extension LogInView {
    var otherOptionView: some View {
        Group {
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
            .padding(.bottom, 1)
            
            if verticalSizeClass != .regular {
                Spacer()
            }
            
            HStack {
                Text("Forgot password?")
                
                Button {
                    authViewModel.currentPage = .forgotPassword
                } label: {
                    Text("Reset Password")
                        .foregroundColor(.indigo)
                        .bold()
                }
            }
        }
        .font(.caption2)
    }
}

// MARK: - LogIn View Preview
struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            AuthView(authViewModel: AuthViewModel())
        }
    }
}
