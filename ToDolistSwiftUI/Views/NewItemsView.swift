//
//  NewItemsView.swift
//  ToDolistSwiftUI
//
//  Created by Abhishek on 01/11/25.
//

import SwiftUI

struct NewItemsView: View {
    @StateObject var viewModel = NewItemsViewViewModel()
    var body: some View {
        VStack{
            Text("New Item")
                .font(.system(size:32))
                .bold()
            Form{
                //Title
                TextField("Title",text:$viewModel.title)
                
                //due Date
                DatePicker("Due Date",selection:$viewModel.dueDate)
                    .datePickerStyle(GraphicalDatePickerStyle())
                
                //button
                TLButton(title:"save",
                         background: .pink) {
                    viewModel.save()
                }
                         .padding(10)
                }
            }
        }
    }

struct NewItemsView_Previews: PreviewProvider {
    static var previews: some View {
        NewItemsView()
    }
}
