import FirebaseFirestore
internal import Combine

class ToDoListViewViewModel: ObservableObject {

    @Published var todayItems: [ToDoListItem] = []
    @Published var tomorrowItems: [ToDoListItem] = []
    @Published var upcomingItems: [ToDoListItem] = []
    @Published var showingNewItemView = false

    private let userId: String
    private var listener: ListenerRegistration?

    init(userId: String) {
        self.userId = userId
        fetchTodos()
    }

    private func fetchTodos() {
        let db = Firestore.firestore()

        listener = db.collection("users")
            .document(userId)
            .collection("todos")
            .order(by: "dueDate")
            .addSnapshotListener { [weak self] snapshot, _ in
                guard let documents = snapshot?.documents else { return }

                let items = documents.compactMap {
                    try? $0.data(as: ToDoListItem.self)
                }

                self?.groupItems(items)
            }
    }


    private func groupItems(_ items: [ToDoListItem]) {
        let now = Date()
        let activeItems = items.filter { !$0.isDone }

        todayItems = activeItems.filter {
            Date(timeIntervalSince1970: $0.dueDate).isToday
        }

        tomorrowItems = activeItems.filter {
            Date(timeIntervalSince1970: $0.dueDate).isTomorrow
        }

        upcomingItems = activeItems.filter {
            let date = Date(timeIntervalSince1970: $0.dueDate)
            return date > now && !date.isToday && !date.isTomorrow
        }
    }

    deinit {
        listener?.remove()
    }
}

