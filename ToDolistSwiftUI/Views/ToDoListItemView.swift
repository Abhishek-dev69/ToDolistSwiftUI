import SwiftUI

struct ToDoListItemView: View {

    let item: ToDoListItem
    let userId: String

    @StateObject private var viewModel = ToDoListItemViewViewModel()
    @State private var isChecked = false

    var body: some View {
        VStack(spacing: 10) {

            // Task Row
            HStack(spacing: 14) {

                Image(systemName: isChecked ? "checkmark.circle.fill" : "circle")
                    .font(.title3)
                    .foregroundColor(isChecked ? .green : .gray)
                    .onTapGesture {
                        withAnimation {
                            isChecked.toggle()
                        }
                    }

                VStack(alignment: .leading, spacing: 6) {
                    Text(item.title)
                        .font(.headline)

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

            // ✅ SINGLE completion button per checked item
            if isChecked {
                Button {
                    withAnimation {
                        viewModel.completeTask(item: item, userId: userId)
                    }
                } label: {
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                        Text("Task Completed")
                            .fontWeight(.medium)
                    }
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(14)
                }
                .transition(.opacity)
            }
        }
    }
}

