//
//  RegisterView.swift
//  ToDolistSwiftUI
//
//  Created by Abhishek on 01/11/25.
//

import SwiftUI

struct RegisterView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    var body: some View {
        VStack{
            HeaderView(title:"Register",
            subtitle: "Start organizing",
                       angle: -15,
                       background: .orange)
            Form{
                TextField("Full Name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .offset(y: -50)
            
            Spacer()
        }
    }
}

#Preview {
    RegisterView()
}
