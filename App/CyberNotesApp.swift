import SwiftUI
import SwiftData

@main
struct CyberNotesApp: App {
    @StateObject private var themeVM = ThemeViewModel()
    @StateObject private var notesVM = NotesViewModel()

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([NoteThread.self, Note.self])
        let configuration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [configuration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(themeVM)
                .environmentObject(notesVM)
                .preferredColorScheme(.dark)
        }
        .modelContainer(sharedModelContainer)
    }
}
