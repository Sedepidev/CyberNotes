import SwiftUI
import SwiftData

/// Gestiona la creación de hilos, notas y su persistencia mediante SwiftData.
@MainActor
final class NotesViewModel: ObservableObject {
    private var modelContext: ModelContext?

    @Published var errorMessage: String?

    /// Debe llamarse una vez desde la vista raíz (p. ej. `onAppear`) para
    /// inyectar el `ModelContext` del entorno.
    func configure(context: ModelContext) {
        self.modelContext = context
    }

    func createThread(title: String) {
        guard let modelContext else { return }
        let thread = NoteThread(title: title)
        modelContext.insert(thread)
        save()
    }

    func deleteThread(_ thread: NoteThread) {
        guard let modelContext else { return }
        modelContext.delete(thread)
        save()
    }

    func addNote(to thread: NoteThread, content: String, sender: NoteSender = .user) {
        guard !content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        let note = Note(content: content, sender: sender, status: .pending)
        note.thread = thread
        thread.notes.append(note)
        save()

        // Simula una respuesta automática del "sistema" para dar vida a la terminal.
        simulateSystemResponse(in: thread)
    }

    func updateStatus(of note: Note, to status: NoteStatus) {
        note.status = status
        save()
    }

    private func simulateSystemResponse(in thread: NoteThread) {
        let responses = [
            "TRANSMISSION RECEIVED. DECRYPTING...",
            "NODE SYNC COMPLETE.",
            "WARNING: TRACE DETECTED ON GRID.",
            "DATA PACKET ARCHIVED.",
            "ICE BREACH UNLIKELY. STANDBY."
        ]
        guard let reply = responses.randomElement() else { return }

        Task {
            try? await Task.sleep(nanoseconds: 700_000_000)
            let systemNote = Note(content: reply, sender: .system, status: .synced)
            systemNote.thread = thread
            thread.notes.append(systemNote)
            save()
        }
    }

    private func save() {
        do {
            try modelContext?.save()
        } catch {
            errorMessage = "PERSISTENCE ERROR: \(error.localizedDescription)"
        }
    }
}
