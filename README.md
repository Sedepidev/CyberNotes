# CyberNotes

Una app de notas/hilos de mensajes con estética **Cyberpunk 2077**, construida en **SwiftUI + SwiftData**.

Las notas se presentan como transmisiones de una terminal de datos: burbujas angulares, scanlines, tipografía monoespaciada y tres "Lifepaths" visuales que puedes alternar en cualquier momento.

## Características

- **3 modos visuales dinámicos (Lifepaths):**
  - **Corpo** — Negro, blanco y Rojo Arasaka (`#ff003c`)
  - **Buscavidas** — Fondo oscuro, Amarillo Cyberpunk (`#fcee0a`) + Cian (`#00ffcc`)
  - **Nomad** — Tonos tierra + Óxido/Ámbar (`#ff7700`)
- Hilos de notas ("threads") con nombre en clave autogenerado estilo netrunner.
- Vista de chat con burbujas biseladas, timestamps simulados y estados de mensaje (`PENDING`, `SYNCED`, `FLAGGED`, `ARCHIVED`).
- Persistencia local con **SwiftData**.
- Componentes reutilizables: formas biseladas, marcos angulares, efecto de brillo neón y scanlines.

## Tecnologías

- Swift 5.9+
- SwiftUI
- SwiftData (persistencia local)
- iOS 17+
- Xcode 15+

## Estructura del proyecto

```
CyberNotes/
├── App/
│   └── CyberNotesApp.swift        # Punto de entrada, ModelContainer, tema global
├── Models/
│   ├── NoteModel.swift            # @Model Note / NoteThread + estados
│   └── ThemeModel.swift           # Paletas de color para los 3 modos
├── ViewModels/
│   ├── NotesViewModel.swift       # Lógica de negocio y persistencia
│   └── ThemeViewModel.swift       # Control de tema activo (persistido en UserDefaults)
├── Views/
│   ├── MainView.swift             # Dashboard tipo terminal
│   ├── ChatThreadView.swift       # Notas como mensajes de chat
│   └── SettingsView.swift         # Selector de Lifepath
└── Components/
    ├── CustomShapes.swift         # Formas biseladas / marcos angulares
    └── NeonModifiers.swift        # Glow, scanlines, tipografía mono
```

## Cómo compilarlo

1. Abre Xcode 15 o superior.
2. `File > New > Project… > iOS > App`, nómbralo `CyberNotes` (o crea un proyecto vacío y arrastra estas carpetas dentro).
3. Copia las carpetas `App/`, `Models/`, `ViewModels/`, `Views/` y `Components/` dentro del target de tu proyecto, asegurándote de que **"Copy items if needed"** y el target correcto estén marcados.
4. Elimina el `ContentView.swift` / `*App.swift` que Xcode genera por defecto (ya lo sustituye `CyberNotesApp.swift`).
5. Selecciona un simulador con iOS 17+ y pulsa `Cmd + R`.

## Roadmap sugerido

- [ ] Exportar hilos como `.json` cifrado
- [ ] Notificaciones locales simulando "transmisiones entrantes"
- [ ] Widget de inicio con el hilo más reciente
- [ ] Modo "Glitch" aleatorio al cambiar de tema

## Licencia

Uso libre para fines de aprendizaje y prototipado.
