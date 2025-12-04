//
//  LoginView.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 01/12/2025.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        NavigationStack {
            Form {
                VStack {
                    TextField("Email", text: $email)
                    SecureField("Password", text: $password)
                    Button {
                        Task { await authVM.signIn(email: email, password: password) }
                    } label: {
                        Text("Login")
                    }
                    
                }
            }
        }
        .NavigationLink {
            
        }
    }
}

