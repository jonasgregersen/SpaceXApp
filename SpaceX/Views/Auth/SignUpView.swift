//
//  SignUpView.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 01/12/2025.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var showAlert = false
    var body: some View {
            ZStack {
                NavigationStack {
                VStack {
                    // Titel
                    Text("Sign up")
                    Form {
                        Section { // Input felter
                            TextField("Email", text: $email)
                            SecureField("Password", text: $password)
                        }
                        Section { // Sign up knap.
                            Button {
                                Task {
                                    await authVM.signUp(email: email, password: password)
                                    if authVM.errorMessage != nil {
                                        showAlert = true
                                    } // Fejl besked popup ved ugyldig signup eller fejl.
                                }
                            } label: {
                                Text("Sign up")
                            }
                            
                        }
                    }
                }
                    
            }
                if authVM.isLoading { // Da det også tager et sekund at sign up, skal progress view vises undervejs.
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                    
                    ProgressView("Logger ind…")
                        .padding(20)
                        .background(.ultraThinMaterial)
                        .cornerRadius(12)
                }
        }
            .alert("Sign up failed", isPresented: $showAlert, actions: {
                Button("OK", role: .cancel) {
                    authVM.errorMessage = nil
                }
            }, message: {
                Text(authVM.errorMessage ?? "Unknown error")
            })
    }
}

#Preview {
    SignUpView()
}
