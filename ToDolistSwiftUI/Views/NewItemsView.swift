import SwiftUI

struct NewItemsView: View {

    @StateObject private var viewModel: NewItemsViewViewModel
    @Binding var newItemsPresented: Bool

    init(userId: String, newItemsPresented: Binding<Bool>) {
        _viewModel = StateObject(wrappedValue: NewItemsViewViewModel(userId: userId))
        _newItemsPresented = newItemsPresented
    }

    var body: some View {
        VStack {
            Text("New Item")
                .font(.system(size: 32))
                .bold()
                .padding(.top, 40)

            Form {
                TextField("Title", text: $viewModel.title)

                DatePicker(
                    "Due Date",
                    selection: $viewModel.dueDate,
                    displayedComponents: [.date, .hourAndMinute]
                )

                TLButton(title: "Save", background: .pink) {
                    viewModel.save()
                    newItemsPresented = false
                }
                .padding()
            }
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(
                title: Text("Invalid Input"),
                message: Text("Please enter a title and valid date")
            )
        }
    }
}

