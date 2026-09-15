import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var themeVM: ThemeViewModel
    @Environment(\.dismiss) private var dismiss

    private var theme: AppTheme { themeVM.currentTheme }

    var body: some View {
        NavigationStack {
            ZStack {
                theme.backgroundColor.ignoresSafeArea()

                VStack(spacing: 18) {
                    Text("LIFEPATH SELECT")
                        .glitchTitle(theme.primaryColor)
                        .padding(.top, 20)

                    ForEach(AppTheme.allCases) { candidate in
                        themeCard(candidate)
                    }

                    Spacer()
                }
                .padding(20)
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("CLOSE") { dismiss() }
                        .foregroundStyle(theme.secondaryColor)
                }
            }
        }
    }

    private func themeCard(_ candidate: AppTheme) -> some View {
        let isSelected = candidate == theme

        return Button {
            themeVM.setTheme(candidate)
        } label: {
            ZStack {
                BeveledRectangle(cut: 12)
                    .fill(candidate.surfaceColor)
                BeveledRectangle(cut: 12)
                    .stroke(candidate.primaryColor, lineWidth: isSelected ? 2.5 : 1)

                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(candidate.rawValue.uppercased())
                            .monoFont(16, weight: .bold)
                            .foregroundStyle(candidate.textColor)
                        Text(candidate.displayLabel)
                            .monoFont(10)
                            .foregroundStyle(candidate.secondaryColor)
                    }
                    Spacer()
                    HStack(spacing: 6) {
                        Circle().fill(candidate.primaryColor).frame(width: 16, height: 16)
                        Circle().fill(candidate.secondaryColor).frame(width: 16, height: 16)
                    }
                    if isSelected {
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundStyle(candidate.primaryColor)
                            .padding(.leading, 8)
                    }
                }
                .padding(16)
            }
            .frame(height: 78)
        }
        .buttonStyle(.plain)
        .neonGlow(isSelected ? candidate.primaryColor : .clear, radius: 6)
    }
}

#Preview {
    SettingsView().environmentObject(ThemeViewModel())
}
