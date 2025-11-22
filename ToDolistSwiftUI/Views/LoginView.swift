//
//  LoginView.swift
//  ToDolistSwiftUI
//
//  Created by Abhishek on 01/11/25.
//

import SwiftUI

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    var body: some View {
        NavigationView{
            VStack {
                HeaderView(title:"To Do List",
                subtitle: "Get things done",
                           angle:15,
                           background:.pink)
                //login Form
                Form{
                    TextField("Email Address", text: $email)
                        .textFieldStyle(DefaultTextFieldStyle())
                    SecureField("Password", text: $password)
                        .textFieldStyle(DefaultTextFieldStyle())
                    Button{
                        
                    } label:{
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color.blue)
                            
                            Text("Login")
                                .foregroundStyle(Color.white)
                                .bold()
                        }
                    }
                }
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

