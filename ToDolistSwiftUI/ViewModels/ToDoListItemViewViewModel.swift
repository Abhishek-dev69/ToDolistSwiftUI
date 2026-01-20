import FirebaseFirestore
internal import Combine

class ToDoListItemViewViewModel: ObservableObject {

    func toggleIsDone(item: ToDoListItem, userId: String) {
        let db = Firestore.firestore()

        db.collection("users")
            .document(userId)
            .collection("todos")
            .document(item.id)
            .updateData([
                "isDone": !item.isDone
            ])
    }
}

