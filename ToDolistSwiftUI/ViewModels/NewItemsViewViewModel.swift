import FirebaseFirestore
import Foundation
internal import Combine

class NewItemsViewViewModel: ObservableObject {

    @Published var title = ""
    @Published var dueDate = Date()
    @Published var showAlert = false

    private let userId: String

    init(userId: String) {
        self.userId = userId
    }

    func save() {
        guard canSave else {
            showAlert = true
            return
        }

        let newId = UUID().uuidString
        let newItem = ToDoListItem(
            id: newId,
            title: title,
            dueDate: dueDate.timeIntervalSince1970,
            createdDate: Date().timeIntervalSince1970,
            isDone: false
        )

        Firestore.firestore()
            .collection("users")
            .document(userId)
            .collection("todos")
            .document(newId)
            .setData(newItem.asDictionary()!)
    }

    var canSave: Bool {
        !title.trimmingCharacters(in: .whitespaces).isEmpty &&
        dueDate >= Date().addingTimeInterval(-86400)
    }
}

