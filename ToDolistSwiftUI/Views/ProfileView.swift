import SwiftUI

struct ProfileView: View {

    @StateObject private var viewModel = ProfileViewViewModel()
    @State private var showLogoutAlert = false

    var body: some View {
        ScrollView {
            VStack(spacing: 28) {

                // MARK: - Header
                VStack(spacing: 10) {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 90, height: 90)
                        .foregroundColor(.blue)

                    Text("Your Productivity")
                        .font(.title2)
                        .fontWeight(.semibold)
                }

                // MARK: - Stats Cards
                HStack(spacing: 16) {
                    StatCard(title: "Total", value: viewModel.totalTasks, color: .blue)
                    StatCard(title: "Done", value: viewModel.completedTasks, color: .green)
                    StatCard(title: "Pending", value: viewModel.pendingTasks, color: .orange)
                }

                // MARK: - Progress Ring
                ProgressRing(
                    completed: viewModel.completedTasks,
                    total: max(viewModel.totalTasks, 1)
                )

                // MARK: - Streak
                VStack(spacing: 8) {
                    Text("🔥 Current Streak")
                        .font(.headline)

                    Text("\(viewModel.streakDays) Days")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }

                // MARK: - Logout
                Button {
                    showLogoutAlert = true
                } label: {
                    Text("Log Out")
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(16)
                }
                .padding(.top, 10)
            }
            .padding()
        }
        .navigationTitle("Profile")
        .alert("Log Out", isPresented: $showLogoutAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Log Out", role: .destructive) {
                viewModel.logout()
            }
        } message: {
            Text("Are you sure you want to log out?")
        }
    }
}

struct StatCard: View {
    let title: String
    let value: Int
    let color: Color

    var body: some View {
        VStack(spacing: 8) {
            Text("\(value)")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(color)

            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 6)
    }
}

struct ProgressRing: View {

    let completed: Int
    let total: Int

    private var progress: Double {
        Double(completed) / Double(total)
    }

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.2), lineWidth: 14)

            Circle()
                .trim(from: 0, to: progress)
                .stroke(Color.green, style: StrokeStyle(lineWidth: 14, lineCap: .round))
                .rotationEffect(.degrees(-90))

            VStack {
                Text("\(Int(progress * 100))%")
                    .font(.title)
                    .fontWeight(.bold)

                Text("Completed")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .frame(width: 160, height: 160)
    }
}

