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
    
    // A focus state for the reveal password mode.
    @FocusState private var show: Bool
    
    // A focus state for the hide password mode.
    @FocusState private var hide: Bool
    
    // A Boolean value that determines whether the password is visible or not.
    @State var showMode = false
    
    // The title of the secure field.
    var title: String
    
    // A binding to the text displayed in the secure field.
    @Binding var text: String
    
    init(_ title: String, text: Binding<String>) {
        self.title = title
        self._text = text
    }
    
    var body: some View {
        HStack {
            ZStack(alignment: .trailing) {
                TextField(title, text: $text)
                    .textContentType(.password)
                    .focused($show)
                    .opacity(showMode ? 1 : 0)
                
                SecureField(title, text: $text)
                    .textContentType(.password)
                    .focused($hide)
                    .opacity(showMode ? 0 : 1)
                
                Button {
                    showMode.toggle()
                    if showMode { show = true }
                    else { hide = true }
                } label: {
                    Image(systemName: showMode ? "eye.slash.fill" : "eye.fill")
                        .font(.system(size: 13, weight: .regular))
                        .foregroundColor(.accentColor)
                }
            }
        }
    }
}

// MARK: - Revealable Secure Field View Preview

struct RevealableSecureField_Previews: PreviewProvider {
    static var previews: some View {
        AuthView(authViewModel: AuthViewModel())
    }
}
