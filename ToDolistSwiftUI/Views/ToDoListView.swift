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
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {

                    if !viewModel.todayItems.isEmpty {
                        SectionView(
                            title: "Today",
                            items: viewModel.todayItems,
                            userId: userId
                        )
                    }

                    if !viewModel.tomorrowItems.isEmpty {
                        SectionView(
                            title: "Tomorrow",
                            items: viewModel.tomorrowItems,
                            userId: userId
                        )
                    }

                    if !viewModel.upcomingItems.isEmpty {
                        SectionView(
                            title: "Upcoming",
                            items: viewModel.upcomingItems,
                            userId: userId
                        )
                    }
                }
                .padding()
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

struct SectionView: View {

    let title: String
    let items: [ToDoListItem]
    let userId: String

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.title3)
                .fontWeight(.bold)

            ForEach(items) { item in
                ToDoListItemView(item: item, userId: userId)
            }
        }
    }
}

#Preview {
    SectionView(
        title: "Today",
        items: [],
        userId: "preview-user"
    )
}

