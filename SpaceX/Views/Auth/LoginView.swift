import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var showSignUp = false
    @State private var showAlert = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 24) {
                

                Text("SpaceX Login")
                    .font(.title.bold())
                    .foregroundColor(.white)
                
                VStack(spacing: 16) {
                    TextField("", text: $email)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                        .textInputAutocapitalization(.never)
                        .overlay(alignment: .leading) {
                            if email.isEmpty {
                                Text("Email")
                                    .foregroundColor(.gray.opacity(0.7))
                                    .padding(.leading, 12)
                            }
                        }


                    SecureField("", text: $password)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                        .overlay(alignment: .leading) {
                            if password.isEmpty {
                                Text("Password")
                                    .foregroundColor(.gray.opacity(0.7))
                                    .padding(.leading, 12)
                            }
                        }

                }
                
                Button {
                    Task {
                        await authVM.signIn(email: email, password: password)
                        if authVM.errorMessage != nil {
                            showAlert = true
                        }
                    }
                } label: {
                    Text("Login")
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                }
                .padding(.top, 4)
                
                HStack {
                    Text("Don't have an account?")
                        .foregroundColor(.gray)
                    
                    Button("Sign up") {
                        showSignUp.toggle()
                    }
                    .foregroundColor(.blue)
                }
                .font(.footnote)
                .background(
                    NavigationLink(
                        destination: SignUpView().environmentObject(authVM),
                        isActive: $showSignUp,
                        label: { EmptyView() }
                    ).hidden()
                )
                
                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.top, 60)
            .background(Color.black.ignoresSafeArea())
            .alert("Login failed", isPresented: $showAlert, actions: {
                        Button("OK", role: .cancel) { authVM.errorMessage = nil }
                    }, message: {
                        Text(authVM.errorMessage ?? "Unknown error")
                    })
            if authVM.isLoading {
                            Color.black.opacity(0.4)
                                .ignoresSafeArea()

                            ProgressView("Logger ind…")
                                .padding(20)
                                .background(.ultraThinMaterial)
                                .cornerRadius(12)
                        }
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(AuthViewModel(service: AuthService()))
}
