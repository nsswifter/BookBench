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
    
    @State var username = ""
    @State var password = ""
    
    var body: some View {
        VStack(spacing: 16) {
            
            VStack(alignment: .leading, spacing: 16) {
                Text("Log in" )
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Reserve a seat and study in a great environment, work on your projects and use the library's rich collection of books.")
                    .font(.subheadline)
                    .opacity(0.7)
            }
            
            if verticalSizeClass == .regular {
                inputViews.verticalStack()
            } else {
                inputViews.horizontalStack()
            }
            
            Button {
                
            } label: {
                Text("Log in")
                    .bold()
                    .font(.title2)
                    .frame(width: verticalSizeClass == .regular ? 265 : 575)
                    .padding()
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
            .black.opacity(0.5) :
                .white.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
        .padding()
    }
    
    var inputViews: some View {
        Group {
            HStack {
                GradientIcon(systemName: "person.fill")
                
                TextField("Username", text: $username)
                    .padding()
            }
            .padding(8)
            .background(.indigo.opacity(0.2))
            .cornerRadius(25)
            .frame(width: 300)
            
            HStack {
                GradientIcon(systemName: "key.fill")
                
                SecureField("Password", text: $password)
                    .textContentType(.password)
                    .padding()
            }
            .padding(8)
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
                    AuthFlowState().goToSignUpPage()
                } label: {
                    Text("Sign up")
                        .foregroundColor(.indigo)
                        .bold()
                }
            }
            .font(.subheadline)
            .padding(.bottom, 1)
            
            if verticalSizeClass != .regular {
                Spacer()
            }
            
            HStack {
                Text("Forgot password?")
                
                Button {
                    AuthFlowState().goToForgotPasswordPage()
                } label: {
                    Text("Reset Password")
                        .foregroundColor(.indigo)
                        .bold()
                }
            }
            .font(.subheadline)
        }
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.indigo.ignoresSafeArea()
            LogInView()
        }
    }
}
