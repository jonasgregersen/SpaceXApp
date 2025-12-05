import SwiftUI

/// Dette View håndterer en login, samt bruger authViewModel til authentification og verificering af login oplysninger
struct LoginView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @EnvironmentObject var userFavVM: UserFavoritesViewModel
    @EnvironmentObject var favLaunchVM: FavoriteLaunchesViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var showSignUp = false
    @State private var showAlert = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 24) {
                
                // Titel
                Text("SpaceX Login")
                    .font(.title.bold())
                    .foregroundColor(.white)
                
                // Email og password felter med placeholders
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
                
                // Login knap
                Button {
                    Task {
                        await authVM.signIn(email: email, password: password)
                        await userFavVM.reload() // Hvis anden bruger logger ind, skal user favorites                                   genindlæses.
                        await favLaunchVM.reload(for: userFavVM.favoriteIds) // Genindlæs favorit siden
                        // Hvis fejl ved login vises popup, ellers fuldføres login og sheet lukker
                        if authVM.errorMessage != nil {
                            showAlert = true
                        } else {
                            authVM.showLogIn = false
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
                
                // Link til sign up siden.
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
                    /// Hidden NavigationLink, så vi kan navigere til SignUpView programmatisk uden at det blokerer i layoutet.
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
            .alert("Login failed", isPresented: $showAlert, actions: { /// Popup besked ved login fejl
                        Button("OK", role: .cancel) { authVM.errorMessage = nil }
                    }, message: {
                        Text(authVM.errorMessage ?? "Unknown error")
                    })
            /// Viser overlay med ProgressView, mens login-verificering pågår.
            /// Indikerer, at appen arbejder, så brugeren ved, at processen ikke er frosset.
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
