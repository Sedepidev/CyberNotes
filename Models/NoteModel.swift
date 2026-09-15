import Foundation
import SwiftData

/// Estado de sincronización/visibilidad de una nota individual.
enum NoteStatus: String, Codable, CaseIterable {
    case pending = "PENDING"
    case synced = "SYNCED"
    case flagged = "FLAGGED"
    case archived = "ARCHIVED"
}

/// Quién originó el mensaje dentro del hilo.
enum NoteSender: String, Codable {
    case user = "USER"
    case system = "NET"
}

/// Una nota individual, representada visualmente como un mensaje de chat.
@Model
final class Note {
    var id: UUID
    var content: String
    var timestamp: Date
    var status: NoteStatus
    var sender: NoteSender

    @Relationship(inverse: \NoteThread.notes)
    var thread: NoteThread?

    init(content: String, sender: NoteSender = .user, status: NoteStatus = .pending) {
        self.id = UUID()
        self.content = content
        self.timestamp = .now
        self.sender = sender
        self.status = status
    }

    var formattedTimestamp: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter.string(from: timestamp)
    }
}

/// Un hilo de conversación/notas, con nombre en clave estilo netrunner.
@Model
final class NoteThread {
    var id: UUID
    var title: String
    var createdAt: Date
    var codename: String

    @Relationship(deleteRule: .cascade)
    var notes: [Note] = []

    init(title: String, codename: String = "") {
        self.id = UUID()
        self.title = title
        self.createdAt = .now
        self.codename = codename.isEmpty ? Self.generateCodename() : codename
    }

    static func generateCodename() -> String {
        let prefixes = ["NET", "SYS", "RUN", "GRID", "DAT"]
        let suffix = Int.random(in: 100...999)
        return "\(prefixes.randomElement() ?? "NET")-\(suffix)"
    }

    var lastActivity: Date {
        notes.map(\.timestamp).max() ?? createdAt
    }
}
