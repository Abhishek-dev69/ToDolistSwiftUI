import FirebaseAuth
import Foundation
internal import Combine

class LoginViewViewModel: ObservableObject {

    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    @Published var isLoggedIn = false   // ✅ USED NOW

    func login() {
        guard validate() else { return }

        Auth.auth().signIn(withEmail: email, password: password) { [weak self] _, error in
            if let error = error {
                DispatchQueue.main.async {
                    self?.errorMessage = error.localizedDescription
                }
                return
            }

            // ✅ LOGIN SUCCESS
            DispatchQueue.main.async {
                self?.isLoggedIn = true
            }
        }
    }

    private func validate() -> Bool {
        errorMessage = ""

        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please fill all the fields"
            return false
        }

        guard email.contains("@"), email.contains(".") else {
            errorMessage = "Please enter a valid email"
            return false
        }

        return true
    }
}

