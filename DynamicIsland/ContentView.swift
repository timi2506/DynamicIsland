import SwiftUI

struct ContentView: View {
    @State private var isExpanded = false
    @State private var isRingerOn = false

    var body: some View {
        VStack {
            if isExpanded {
                RingerSwitchView(isRingerOn: $isRingerOn, onDismiss: autoCollapse)
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 0.3))
            } else {
                VStack {
                    Text("Dynamic Island")
                        .padding()
                        .background(Color.black)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        .onTapGesture {
                            withAnimation(.spring()) {
                                isExpanded.toggle()
                                startAutoCollapse()
                            }
                        }
                }
                .frame(width: 300, height: 100)
                .background(Color.black)
                .clipShape(Capsule())
                .padding()
            }
        }
    }

    private func startAutoCollapse() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            if isExpanded {
                withAnimation(.easeInOut(duration: 0.3)) {
                    isExpanded = false
                }
            }
        }
    }

    private func autoCollapse() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            withAnimation(.easeInOut(duration: 0.3)) {
                isExpanded = false
            }
        }
    }
}

struct RingerSwitchView: View {
    @Binding var isRingerOn: Bool
    var onDismiss: () -> Void

    var body: some View {
        VStack {
            HStack {
                Image(systemName: isRingerOn ? "bell.fill" : "bell.slash.fill")
                    .font(.title)
                Text(isRingerOn ? "Ringer On" : "Ringer Off")
                    .font(.headline)
            }
            .padding()
            .onTapGesture {
                withAnimation(.spring()) {
                    isRingerOn.toggle()
                }
            }
            .onAppear {
                startAutoCollapse()
            }
        }
        .background(Color.black.opacity(0.8))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding()
    }

    private func startAutoCollapse() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            withAnimation(.easeInOut(duration: 0.3)) {
                onDismiss()
            }
        }
    }
}
