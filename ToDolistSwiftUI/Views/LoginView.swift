//
//  LoginView.swift
//  ToDolistSwiftUI
//
//  Created by Abhishek on 01/11/25.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewViewModel()
    var body: some View {
        NavigationView{
            VStack {
                HeaderView(title:"To Do List",
                           subtitle: "Get things done",
                           angle:15,
                           background:.pink)
                
                if !viewModel.errorMessage.isEmpty{
                    Text(viewModel.errorMessage)
                        .foregroundColor(Color.red)
                }
                //login Form
                Form{
                    TextField("Email Address", text: $viewModel.email)
                        .textFieldStyle(DefaultTextFieldStyle())
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(DefaultTextFieldStyle())
                    TLButton(
                        title:"Log In",
                        background:.blue
                    ){
                        viewModel.login()
                    }
                    
                    .padding()
                }
                .offset(y:-50)
                    VStack{
                        Text("New around Here?")
                        NavigationLink("Create an account", destination:RegisterView())
                    }
                    .padding(.bottom,50)
                    Spacer()
                }
            }
        }
    }

#Preview {
    LoginView()
}

