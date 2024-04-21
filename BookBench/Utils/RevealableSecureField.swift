//
//  RevealableSecureField.swift
//  BookBench
//
//  Created by Mehdi Karami on 5/5/23.
//

import SwiftUI

// MARK: - Revealable Secure Field View

/// A SwiftUI view that combines a `SecureField` with a reveal/hide password toggle button.
struct RevealableSecureField: View {
    // A Boolean value that determines whether the password is visible or not.
    @State private var showMode = false
    
    // The title of the secure field.
    private var title: String
    
    // A binding to the text displayed in the secure field.
    @Binding private var text: String
    
    init(_ title: String, text: Binding<String>) {
        self.title = title
        self._text = text
    }
    
    var body: some View {
        HStack {
            Group {
                if showMode {
                    TextField(title, text: $text)
                } else {
                    SecureField(title, text: $text)
                }
            }
            .textContentType(.password)
            
            Button {
                showMode.toggle()
            } label: {
                Image(systemName: showMode ? "eye.slash.fill" : "eye.fill")
                    .foregroundColor(.accentColor)
                    .bold()
                    .contentTransition(.symbolEffect(.replace))
            }
        }
    }
}

// MARK: - Revealable Secure Field View Preview

#Preview {
    AuthView(authViewModel: AuthViewModel())
}
