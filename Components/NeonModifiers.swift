import SwiftUI

/// Brillo neón en capas, simulando el resplandor de un letrero LED.
struct NeonGlow: ViewModifier {
    var color: Color
    var radius: CGFloat = 6

    func body(content: Content) -> some View {
        content
            .shadow(color: color.opacity(0.9), radius: radius / 3)
            .shadow(color: color.opacity(0.6), radius: radius)
            .shadow(color: color.opacity(0.3), radius: radius * 2)
    }
}

/// Tipografía monoespaciada, para el look de terminal de datos.
struct MonoFont: ViewModifier {
    var size: CGFloat
    var weight: Font.Weight = .regular

    func body(content: Content) -> some View {
        content.font(.system(size: size, weight: weight, design: .monospaced))
    }
}

/// Overlay sutil de líneas horizontales, simulando un CRT/pantalla holográfica.
struct Scanlines: ViewModifier {
    var opacity: Double = 0.06

    func body(content: Content) -> some View {
        content.overlay(
            GeometryReader { geo in
                Canvas { context, size in
                    let lineSpacing: CGFloat = 3
                    var y: CGFloat = 0
                    while y < size.height {
                        let rect = CGRect(x: 0, y: y, width: size.width, height: 1)
                        context.fill(Path(rect), with: .color(.black.opacity(opacity)))
                        y += lineSpacing
                    }
                }
            }
            .allowsHitTesting(false)
        )
    }
}

/// Estilo de título "glitch": mono, en mayúsculas, con tracking amplio y glow.
struct GlitchTitle: ViewModifier {
    var color: Color

    func body(content: Content) -> some View {
        content
            .modifier(MonoFont(size: 24, weight: .bold))
            .foregroundStyle(color)
            .modifier(NeonGlow(color: color, radius: 8))
            .textCase(.uppercase)
            .tracking(2)
    }
}

extension View {
    func neonGlow(_ color: Color, radius: CGFloat = 6) -> some View {
        modifier(NeonGlow(color: color, radius: radius))
    }

    func monoFont(_ size: CGFloat, weight: Font.Weight = .regular) -> some View {
        modifier(MonoFont(size: size, weight: weight))
    }

    func scanlines(opacity: Double = 0.06) -> some View {
        modifier(Scanlines(opacity: opacity))
    }

    func glitchTitle(_ color: Color) -> some View {
        modifier(GlitchTitle(color: color))
    }
}
