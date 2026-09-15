import SwiftUI

struct ChatThreadView: View {
    @EnvironmentObject private var themeVM: ThemeViewModel
    @EnvironmentObject private var notesVM: NotesViewModel

    @Bindable var thread: NoteThread
    @State private var draft: String = ""

    private var theme: AppTheme { themeVM.currentTheme }

    var body: some View {
        ZStack {
            theme.backgroundColor.ignoresSafeArea()

            VStack(spacing: 0) {
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: 10) {
                            ForEach(thread.notes.sorted(by: { $0.timestamp < $1.timestamp })) { note in
                                bubble(for: note)
                                    .id(note.id)
                            }
                        }
                        .padding(14)
                    }
                    .onChange(of: thread.notes.count) {
                        if let last = thread.notes.last {
                            withAnimation { proxy.scrollTo(last.id, anchor: .bottom) }
                        }
                    }
                }

                inputBar
            }
        }
        .scanlines()
        .navigationTitle(thread.codename)
        .toolbarBackground(theme.backgroundColor, for: .navigationBar)
        .tint(theme.primaryColor)
    }

    private func bubble(for note: Note) -> some View {
        let isUser = note.sender == .user
        return HStack {
            if isUser { Spacer(minLength: 40) }

            VStack(alignment: isUser ? .trailing : .leading, spacing: 4) {
                Text(note.content)
                    .monoFont(13)
                    .foregroundStyle(isUser ? theme.backgroundColor : theme.textColor)
                    .padding(10)
                    .background(
                        BeveledRectangle(cut: 8)
                            .fill(isUser ? theme.primaryColor : theme.surfaceColor)
                    )
                    .overlay(
                        BeveledRectangle(cut: 8)
                            .stroke(isUser ? theme.primaryColor : theme.secondaryColor.opacity(0.5), lineWidth: 1)
                    )

                HStack(spacing: 6) {
                    Text(note.formattedTimestamp)
                    Text("·")
                    Text(note.status.rawValue)
                }
                .monoFont(9)
                .foregroundStyle(theme.textColor.opacity(0.4))
            }

            if !isUser { Spacer(minLength: 40) }
        }
    }

    private var inputBar: some View {
        HStack(spacing: 10) {
            TextField("TRANSMIT MESSAGE...", text: $draft)
                .monoFont(13)
                .foregroundStyle(theme.textColor)
                .padding(10)
                .background(
                    BeveledRectangle(cut: 6)
                        .fill(theme.surfaceColor)
                )
                .overlay(
                    BeveledRectangle(cut: 6)
                        .stroke(theme.secondaryColor.opacity(0.5), lineWidth: 1)
                )

            Button {
                notesVM.addNote(to: thread, content: draft)
                draft = ""
            } label: {
                Image(systemName: "paperplane.fill")
                    .foregroundStyle(theme.primaryColor)
                    .neonGlow(theme.primaryColor, radius: 4)
                    .padding(10)
            }
        }
        .padding(12)
        .background(theme.backgroundColor.opacity(0.95))
    }
}
