import FirebaseFirestore
import FirebaseAuth
import Foundation
internal import Combine

class ProfileViewViewModel: ObservableObject {

    @Published var totalTasks: Int = 0
    @Published var completedTasks: Int = 0
    @Published var pendingTasks: Int = 0
    @Published var streakDays: Int = 0

    private let db = Firestore.firestore()
    private let userId: String

    init() {
        self.userId = Auth.auth().currentUser?.uid ?? ""
        fetchStats()
    }

    // MARK: - Fetch Profile Stats
    private func fetchStats() {
        db.collection("users")
            .document(userId)
            .collection("todos")
            .addSnapshotListener { [weak self] snapshot, _ in
                guard let documents = snapshot?.documents else { return }

                let todos = documents.compactMap {
                    try? $0.data(as: ToDoListItem.self)
                }

                self?.calculateStats(todos)
            }
    }

    private func calculateStats(_ todos: [ToDoListItem]) {
        totalTasks = todos.count
        completedTasks = todos.filter { $0.isDone }.count
        pendingTasks = totalTasks - completedTasks
        streakDays = calculateStreak(from: todos)
    }

    // MARK: - Streak Logic
    private func calculateStreak(from todos: [ToDoListItem]) -> Int {
        let completedDates = todos
            .filter { $0.isDone }
            .map { Date(timeIntervalSince1970: $0.dueDate).stripTime() }

        let uniqueDays = Set(completedDates)
        var streak = 0
        var currentDay = Date().stripTime()

        while uniqueDays.contains(currentDay) {
            streak += 1
            currentDay = Calendar.current.date(byAdding: .day, value: -1, to: currentDay)!
        }

        return streak
    }

    // MARK: - Logout
    func logout() {
        do {
            try Auth.auth().signOut()
            NotificationCenter.default.post(name: .didLogout, object: nil)
        } catch {
            print("Logout failed:", error.localizedDescription)
        }
    }
}

extension Notification.Name {
    static let didLogout = Notification.Name("didLogout")
}

extension Date {
    func stripTime() -> Date {
        Calendar.current.startOfDay(for: self)
    }
}

