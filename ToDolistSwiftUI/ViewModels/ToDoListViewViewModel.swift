import FirebaseFirestore
internal import Combine

class ToDoListViewViewModel: ObservableObject {

    @Published var items: [ToDoListItem] = []
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

                self?.items = documents.compactMap {
                    try? $0.data(as: ToDoListItem.self)
                }
            }
    }

    deinit {
        listener?.remove()
    }
}

