//
//  NewItemsViewViewModel.swift
//  ToDolistSwiftUI
//
//  Created by Abhishek on 01/11/25.
//

import Foundation
internal import Combine
class NewItemsViewViewModel: ObservableObject {
    @Published var title=""
    @Published var dueDate = Date()
    init(){
        
        func save(){
            
        }
    }
}
