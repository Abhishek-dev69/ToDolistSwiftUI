//
//  RegisterView.swift
//  ToDolistSwiftUI
//
//  Created by Abhishek on 01/11/25.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel = RegisterViewViewModel()

    var body: some View {
        VStack {
            HeaderView(
                title: "Register",
                subtitle: "Start organizing todos",
                angle: -15,
                background: .orange
            )

            if !viewModel.errorMessage.isEmpty {
                Text(viewModel.errorMessage)
                    .foregroundColor(.red)
                    .padding(.horizontal)
            }

            Form {
                TextField("Full Name", text: $viewModel.name)
                    .autocorrectionDisabled()

                TextField("Email Address", text: $viewModel.email)
                    .autocapitalization(.none)
                    .autocorrectionDisabled()

                SecureField("Password", text: $viewModel.password)

                TLButton(title: "Create Account", background: .green) {
                    viewModel.register()
                }
                .padding()
            }
            .offset(y: -50)

            Spacer()
        }
    }
}


#Preview {
    RegisterView()
}
