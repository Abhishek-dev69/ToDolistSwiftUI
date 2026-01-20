import SwiftUI
import FirebaseAuth

struct LoginView: View {

    @StateObject var viewModel = LoginViewViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                HeaderView(
                    title: "To Do List",
                    subtitle: "Get things done",
                    angle: 15,
                    background: .pink
                )

                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                }

                Form {
                    TextField("Email Address", text: $viewModel.email)
                        .autocapitalization(.none)

                    SecureField("Password", text: $viewModel.password)

                    TLButton(title: "Log In", background: .blue) {
                        viewModel.login()
                    }
                    .padding()
                }
                .offset(y: -50)

                VStack {
                    Text("New around here?")
                    NavigationLink("Create an account", destination: RegisterView())
                }
                .padding(.bottom, 50)

                Spacer()
            }
            // ✅ THIS WAS MISSING
            .navigationDestination(isPresented: $viewModel.isLoggedIn) {
                let uid = Auth.auth().currentUser!.uid
                ToDoListView(userId: uid)
            }
        }
    }
}

#Preview {
    LoginView()
}

