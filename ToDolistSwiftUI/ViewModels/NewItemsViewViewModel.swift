import FirebaseFirestore
import Foundation
internal import Combine

class NewItemsViewViewModel: ObservableObject {

    // MARK: - UI State
    @Published var title: String = ""
    @Published var dueDate: Date = Date()
    @Published var showAlert: Bool = false
    @Published var errorMessage: String = ""
    @Published var isSaving: Bool = false

    // MARK: - Private
    private let userId: String
    private let db = Firestore.firestore()

    // MARK: - Init
    init(userId: String) {
        self.userId = userId
    }

    // MARK: - Save Task
    func save() {
        guard canSave else {
            showAlert = true
            return
        }

        isSaving = true

        let newId = UUID().uuidString

        let newItem = ToDoListItem(
            id: newId,
            title: title.trimmingCharacters(in: .whitespaces),
            dueDate: dueDate.timeIntervalSince1970,
            createdDate: Date().timeIntervalSince1970,
            isDone: false
        )

        guard let data = newItem.asDictionary() else {
            errorMessage = "Failed to create task data"
            showAlert = true
            isSaving = false
            return
        }

        db.collection("users")
            .document(userId)
            .collection("todos")
            .document(newId)
            .setData(data) { [weak self] error in
                DispatchQueue.main.async {
                    self?.isSaving = false

                    if let error = error {
                        self?.errorMessage = error.localizedDescription
                        self?.showAlert = true
                    } else {
                        // ✅ Reset fields on success
                        self?.title = ""
                        self?.dueDate = Date()
                    }
                }
            }
    }

    // MARK: - Validation
    var canSave: Bool {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }

        // Allow today + future dates
        guard dueDate >= Calendar.current.startOfDay(for: Date()) else {
            return false
        }

        return true
    }
}

