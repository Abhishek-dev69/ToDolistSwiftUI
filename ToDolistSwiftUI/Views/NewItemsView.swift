import SwiftUI

struct NewItemsView: View {

    @StateObject private var viewModel: NewItemsViewViewModel
    @Binding var newItemsPresented: Bool

    init(userId: String, newItemsPresented: Binding<Bool>) {
        _viewModel = StateObject(wrappedValue: NewItemsViewViewModel(userId: userId))
        _newItemsPresented = newItemsPresented
    }

    var body: some View {
        VStack(spacing: 24) {

            // MARK: Header
            VStack(spacing: 6) {
                Text("New Task")
                    .font(.system(size: 28, weight: .bold))

                Text("What needs to be done?")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(.top, 24)

            // MARK: Title
            VStack(alignment: .leading, spacing: 8) {
                Text("TITLE")
                    .font(.caption)
                    .foregroundColor(.gray)

                TextField("e.g. Buy Groceries", text: $viewModel.title)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(14)
            }

            // MARK: Due Date
            VStack(alignment: .leading, spacing: 8) {
                Text("DUE DATE")
                    .font(.caption)
                    .foregroundColor(.gray)

                DatePicker(
                    "",
                    selection: $viewModel.dueDate,
                    displayedComponents: [.date, .hourAndMinute]
                )
                .datePickerStyle(.graphical)
                .background(Color(.systemGray6))
                .cornerRadius(16)
            }

            Spacer()

            // MARK: Save Button
            Button {
                viewModel.save()
                newItemsPresented = false
            } label: {
                Text("Create Task")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        LinearGradient(
                            colors: [.pink, .red],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .foregroundColor(.white)
                    .cornerRadius(18)
            }

            // MARK: Cancel
            Button("Cancel") {
                newItemsPresented = false
            }
            .foregroundColor(.gray)
            .padding(.bottom, 12)
        }
        .padding()
        .alert(isPresented: $viewModel.showAlert) {
            Alert(
                title: Text("Invalid Input"),
                message: Text("Please enter a title and select a valid date")
            )
        }
    }
}

