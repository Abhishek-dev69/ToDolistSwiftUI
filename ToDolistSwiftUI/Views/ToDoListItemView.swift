import SwiftUI

struct ToDoListItemView: View {

    let item: ToDoListItem
    let userId: String
    @StateObject private var viewModel = ToDoListItemViewViewModel()

    var body: some View {
        HStack(spacing: 14) {

            Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                .font(.title3)
                .foregroundColor(item.isDone ? .green : .gray)
                .onTapGesture {
                    viewModel.toggleIsDone(item: item, userId: userId)
                }

            VStack(alignment: .leading, spacing: 6) {
                Text(item.title)
                    .font(.headline)
                    .strikethrough(item.isDone)

                Text(Date(timeIntervalSince1970: item.dueDate).formattedTime())
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
    }
}

