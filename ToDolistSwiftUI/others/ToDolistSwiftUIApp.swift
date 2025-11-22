//
//  ToDolistSwiftUIApp.swift
//  ToDolistSwiftUI
//
//  Created by Abhishek on 01/11/25.
//
import FirebaseCore
import SwiftUI

@main
struct ToDolistSwiftUIApp: App {
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
