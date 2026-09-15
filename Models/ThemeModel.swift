import SwiftUI

/// Los tres "Lifepaths" visuales de la app, inspirados en Cyberpunk 2077.
enum AppTheme: String, CaseIterable, Identifiable, Codable {
    case corpo = "Corpo"
    case buscavidas = "Buscavidas"
    case nomad = "Nomad"

    var id: String { rawValue }

    /// Color de acento principal (marcos, títulos, botones primarios).
    var primaryColor: Color {
        switch self {
        case .corpo: return Color(hex: "#ff003c")
        case .buscavidas: return Color(hex: "#fcee0a")
        case .nomad: return Color(hex: "#ff7700")
        }
    }

    /// Color de acento secundario (detalles, texto del sistema).
    var secondaryColor: Color {
        switch self {
        case .corpo: return .white
        case .buscavidas: return Color(hex: "#00ffcc")
        case .nomad: return Color(hex: "#8a6d3b")
        }
    }

    var backgroundColor: Color {
        switch self {
        case .corpo: return .black
        case .buscavidas: return Color(hex: "#0d0d0d")
        case .nomad: return Color(hex: "#1a1410")
        }
    }

    var surfaceColor: Color {
        switch self {
        case .corpo: return Color(hex: "#111111")
        case .buscavidas: return Color(hex: "#161616")
        case .nomad: return Color(hex: "#241d16")
        }
    }

    var textColor: Color {
        switch self {
        case .corpo: return .white
        case .buscavidas: return Color(hex: "#fcee0a")
        case .nomad: return Color(hex: "#ffcf9e")
        }
    }

    var displayLabel: String {
        switch self {
        case .corpo: return "CORPO // ARASAKA-CLASS"
        case .buscavidas: return "BUSCAVIDAS // STREET-KID"
        case .nomad: return "NOMAD // BADLANDS"
        }
    }
}

extension Color {
    /// Inicializa un Color a partir de un hex string tipo "#ff003c".
    init(hex: String) {
        let hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let r = Double((rgb & 0xFF0000) >> 16) / 255.0
        let g = Double((rgb & 0x00FF00) >> 8) / 255.0
        let b = Double(rgb & 0x0000FF) / 255.0

        self.init(red: r, green: g, blue: b)
    }
}
