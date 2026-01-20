import FirebaseFirestore
internal import Combine

class ToDoListItemViewViewModel: ObservableObject {

    private let db = Firestore.firestore()

    func completeTask(item: ToDoListItem, userId: String) {
        db.collection("users")
            .document(userId)
            .collection("todos")
            .document(item.id)
            .delete()
    }
}

