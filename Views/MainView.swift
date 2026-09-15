import SwiftUI
import SwiftData

struct MainView: View {
    @EnvironmentObject private var themeVM: ThemeViewModel
    @EnvironmentObject private var notesVM: NotesViewModel
    @Environment(\.modelContext) private var modelContext

    @Query(sort: \NoteThread.createdAt, order: .reverse) private var threads: [NoteThread]

    @State private var showSettings = false
    @State private var showNewThreadPrompt = false
    @State private var newThreadTitle = ""

    private var theme: AppTheme { themeVM.currentTheme }

    var body: some View {
        NavigationStack {
            ZStack {
                theme.backgroundColor.ignoresSafeArea()

                VStack(spacing: 0) {
                    header

                    if threads.isEmpty {
                        emptyState
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 12) {
                                ForEach(threads) { thread in
                                    NavigationLink(value: thread) {
                                        threadRow(thread)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .padding(16)
                        }
                    }
                }
                .scanlines()
            }
            .navigationDestination(for: NoteThread.self) { thread in
                ChatThreadView(thread: thread)
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $showSettings) {
                SettingsView()
            }
            .alert("NEW DATA THREAD", isPresented: $showNewThreadPrompt) {
                TextField("Thread title", text: $newThreadTitle)
                Button("CANCEL", role: .cancel) { newThreadTitle = "" }
                Button("CREATE") {
                    notesVM.createThread(title: newThreadTitle.isEmpty ? "UNTITLED_LOG" : newThreadTitle)
                    newThreadTitle = ""
                }
            }
            .onAppear { notesVM.configure(context: modelContext) }
        }
        .tint(theme.primaryColor)
    }

    private var header: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text("CYBERNOTES")
                    .glitchTitle(theme.primaryColor)
                Text(theme.displayLabel)
                    .monoFont(11)
                    .foregroundStyle(theme.secondaryColor.opacity(0.8))
            }

            Spacer()

            Button {
                showSettings = true
            } label: {
                Image(systemName: "gearshape.fill")
                    .foregroundStyle(theme.secondaryColor)
                    .neonGlow(theme.secondaryColor, radius: 4)
            }

            Button {
                showNewThreadPrompt = true
            } label: {
                Image(systemName: "plus.square.fill")
                    .foregroundStyle(theme.primaryColor)
                    .neonGlow(theme.primaryColor, radius: 4)
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 12)
        .padding(.bottom, 8)
    }

    private var emptyState: some View {
        VStack(spacing: 10) {
            Spacer()
            Image(systemName: "antenna.radiowaves.left.and.right")
                .font(.system(size: 40))
                .foregroundStyle(theme.primaryColor)
                .neonGlow(theme.primaryColor)
            Text("NO ACTIVE THREADS")
                .monoFont(14, weight: .bold)
                .foregroundStyle(theme.textColor)
            Text("TAP + TO OPEN A NEW CHANNEL")
                .monoFont(11)
                .foregroundStyle(theme.textColor.opacity(0.5))
            Spacer()
        }
    }

    private func threadRow(_ thread: NoteThread) -> some View {
        ZStack {
            BeveledRectangle(cut: 10)
                .fill(theme.surfaceColor)
            BeveledRectangle(cut: 10)
                .stroke(theme.primaryColor.opacity(0.6), lineWidth: 1)

            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(thread.title.uppercased())
                        .monoFont(14, weight: .bold)
                        .foregroundStyle(theme.textColor)
                    Text(thread.codename)
                        .monoFont(10)
                        .foregroundStyle(theme.secondaryColor)
                }
                Spacer()
                VStack(alignment: .trailing, spacing: 4) {
                    Text("\(thread.notes.count) MSG")
                        .monoFont(10)
                        .foregroundStyle(theme.textColor.opacity(0.6))
                    Circle()
                        .fill(theme.primaryColor)
                        .frame(width: 6, height: 6)
                        .neonGlow(theme.primaryColor, radius: 3)
                }
            }
            .padding(14)
        }
        .frame(height: 66)
    }
}

#Preview {
    MainView()
        .environmentObject(ThemeViewModel())
        .environmentObject(NotesViewModel())
        .modelContainer(for: [NoteThread.self, Note.self], inMemory: true)
}
