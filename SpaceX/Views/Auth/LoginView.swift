import SwiftUI

// Dette View håndterer en login, samt bruger authViewModel til authentification og verificering af login oplysninger
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
                
                // Email indtast felt
                VStack(spacing: 16) {
                    TextField("", text: $email)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                        .textInputAutocapitalization(.never)
                        .overlay(alignment: .leading) {
                            if email.isEmpty { // Placeholder
                                Text("Email")
                                    .foregroundColor(.gray.opacity(0.7))
                                    .padding(.leading, 12)
                            }
                        }


                    // Password indtast felt
                    SecureField("", text: $password)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                        .overlay(alignment: .leading) {
                            if password.isEmpty { // Placeholder
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
                        if authVM.errorMessage != nil {
                            showAlert = true
                        } // Hvis fejl ved login vises popup.
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
                .background( // Skal køres i baggrunden, ellers fylder navigation linket hele view'et af en eller anden grund
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
            .alert("Login failed", isPresented: $showAlert, actions: { // Popup besked ved login fejl
                        Button("OK", role: .cancel) { authVM.errorMessage = nil }
                    }, message: {
                        Text(authVM.errorMessage ?? "Unknown error")
                    })
            if authVM.isLoading { // Ved klik på log in knap vises en progress view, som viser at programmet tænker, og ikke er gået i stå, da det kan tage et sekund at logge ind.
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
