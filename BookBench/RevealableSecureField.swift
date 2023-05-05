//
//  RevealableSecureField.swift
//  BookBench
//
//  Created by Mehdi Karami on 5/5/23.
//

import SwiftUI

struct RevealableSecureField: View {
    @FocusState private var show: Bool
    @FocusState private var hide: Bool
    
    @State var showMode = false
    var title: String
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
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(.accentColor)
                }
            }
        }
    }
}

struct RevealableSecureField_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}
