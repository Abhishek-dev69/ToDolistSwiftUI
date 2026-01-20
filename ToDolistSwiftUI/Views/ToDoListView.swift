import SwiftUI

struct ToDoListView: View {

    @StateObject private var viewModel: ToDoListViewViewModel
    private let userId: String

    init(userId: String) {
        self.userId = userId
        _viewModel = StateObject(wrappedValue: ToDoListViewViewModel(userId: userId))
    }

    var body: some View {
        NavigationStack {
            List(viewModel.items) { item in
                ToDoListItemView(item: item, userId: userId)
            }
            .navigationTitle("To Do List")
            .toolbar {
                Button {
                    viewModel.showingNewItemView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $viewModel.showingNewItemView) {
                NewItemsView(
                    userId: userId,
                    newItemsPresented: $viewModel.showingNewItemView
                )
            }
        }
    }
}

