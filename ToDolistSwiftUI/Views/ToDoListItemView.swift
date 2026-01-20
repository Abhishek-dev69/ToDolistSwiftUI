import SwiftUI

struct ToDoListItemView: View {

    let item: ToDoListItem
    let userId: String
    @StateObject private var viewModel = ToDoListItemViewViewModel()

    var body: some View {
        HStack {
            Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                .foregroundColor(item.isDone ? .green : .gray)
                .onTapGesture {
                    viewModel.toggleIsDone(item: item, userId: userId)
                }

            Text(item.title)
                .strikethrough(item.isDone)
        }
    }
}

