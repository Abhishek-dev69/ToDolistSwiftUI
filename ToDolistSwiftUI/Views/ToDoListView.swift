//
//  ToDOListView.swift
//  ToDolistSwiftUI
//
//  Created by Abhishek on 01/11/25.
//

import SwiftUI

struct ToDoListView: View {
    @StateObject var viewModel = ToDoListViewViewModel()
    private let userId:String
    init(userId:String){
        self.userId = userId
        
    }
    var body: some View {
        NavigationView{
            VStack{
                
            }
            .navigationTitle(Text("To Do List"))
            .toolbar{
                Button{
                    //action
                }
                label:{
                    Image(systemName: "plus")
                }
            }
        }
    }
}

#Preview {
    ToDoListView(userId: "")
}
