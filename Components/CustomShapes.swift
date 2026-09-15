import SwiftUI

/// Un rectángulo con dos esquinas opuestas cortadas a 45°, el look clásico
/// de panel angular de Cyberpunk 2077.
struct BeveledRectangle: Shape {
    var cut: CGFloat = 14

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height

        path.move(to: CGPoint(x: cut, y: 0))
        path.addLine(to: CGPoint(x: w, y: 0))
        path.addLine(to: CGPoint(x: w, y: h - cut))
        path.addLine(to: CGPoint(x: w - cut, y: h))
        path.addLine(to: CGPoint(x: 0, y: h))
        path.addLine(to: CGPoint(x: 0, y: cut))
        path.closeSubpath()
        return path
    }
}

/// Un marco angular (solo borde), dibujado con el mismo recorte que `BeveledRectangle`.
struct AngularFrame: View {
    var color: Color
    var lineWidth: CGFloat = 1.5
    var cut: CGFloat = 14

    var body: some View {
        BeveledRectangle(cut: cut)
            .stroke(color, lineWidth: lineWidth)
    }
}

/// Marcas de esquina tipo HUD/visor, para decorar tarjetas o cabeceras.
struct CornerBrackets: Shape {
    var length: CGFloat = 12

    func path(in rect: CGRect) -> Path {
        var path = Path()

        // Superior izquierda
        path.move(to: CGPoint(x: 0, y: length))
        path.addLine(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: length, y: 0))

        // Superior derecha
        path.move(to: CGPoint(x: rect.width - length, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: length))

        // Inferior izquierda
        path.move(to: CGPoint(x: 0, y: rect.height - length))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.addLine(to: CGPoint(x: length, y: rect.height))

        // Inferior derecha
        path.move(to: CGPoint(x: rect.width - length, y: rect.height))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height - length))

        return path
    }
}
