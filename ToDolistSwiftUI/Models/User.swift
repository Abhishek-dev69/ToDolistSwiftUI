//
//  User.swift
//  ToDolistSwiftUI
//
//  Created by Abhishek on 01/11/25.
//

import Foundation

struct User: Codable {
    let id: String
    let name: String
    let email: String
    let joined: TimeInterval
}
