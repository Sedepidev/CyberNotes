import SwiftUI

/// Controla qué Lifepath (Corpo / Buscavidas / Nomad) está activo,
/// y lo persiste entre sesiones vía UserDefaults.
@MainActor
final class ThemeViewModel: ObservableObject {
    @Published var currentTheme: AppTheme {
        didSet {
            UserDefaults.standard.set(currentTheme.rawValue, forKey: Self.storageKey)
        }
    }

    private static let storageKey = "cybernotes.selectedTheme"

    init() {
        if let saved = UserDefaults.standard.string(forKey: Self.storageKey),
           let theme = AppTheme(rawValue: saved) {
            self.currentTheme = theme
        } else {
            self.currentTheme = .buscavidas
        }
    }

    func setTheme(_ theme: AppTheme) {
        withAnimation(.easeInOut(duration: 0.35)) {
            currentTheme = theme
        }
    }
}
