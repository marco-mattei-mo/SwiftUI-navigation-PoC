import SwiftUI

extension View {
    public func mSnackbar(isShowing: Binding<Bool>, message: String, messageType: SnackbarViewModifier.SnackbarMessageType, bottomPadding: CGFloat? = 8, buttonText: String? = nil, buttonAction: (() -> Void)? = nil, accessibilityCancelText: String? = nil, onDismiss: (() -> Void)? = nil) -> some View {
        self.modifier(SnackbarViewModifier(isShowing: isShowing, message: message, messageType: messageType, bottomPadding: bottomPadding!, buttonText: buttonText, buttonAction: buttonAction, accessibilityCancelText: accessibilityCancelText, onDismiss: onDismiss))
    }
}

public struct SnackbarViewModifier: ViewModifier {
    
    public enum SnackbarMessageType: Int {
        case success
        case failure
    }
    
    @Binding var isShowing: Bool
    let message: String
    let messageType: SnackbarMessageType
    let bottomPadding: CGFloat
    var buttonText: String?
    var buttonAction: (() -> Void)?
    var accessibilityCancelText: String?
    let automaticCloseTime: TimeInterval = 5.0
    var onDismiss: (() -> Void)?

    public func body(content: Content) -> some View {
        ZStack {
            content
            snackbar
        }
    }
    
    private var snackbar: some View {
        VStack {
            Spacer()
            if isShowing {
                if UIAccessibility.isVoiceOverRunning {
                    if buttonText != nil && buttonAction != nil {
                        HStack {}
                            .alert(isPresented: $isShowing) {
                                // because the markdown text has identifiers like __ for underscores or ** for bold text, we need to remove them for voice over
                                Alert(title: Text(message.replacingOccurrences(of: "__", with: "")
                                    .replacingOccurrences(of: "**", with: "")), message: nil, primaryButton: .cancel(Text(accessibilityCancelText ?? "Cancel")), secondaryButton: .default(Text(buttonText!), action: {
                                        buttonAction!()
                                    }))
                            }
                    } else {
                        HStack {}
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(250)) {
                                    UIAccessibility.post(notification: .announcement, argument: message.replacingOccurrences(of: "__", with: "")
                                        .replacingOccurrences(of: "**", with: ""))
                                    self.isShowing = false
                                }
                            }
                    }
                    
                } else {
                    HStack(alignment: .center, spacing: 16) {
                        Text(message)
                            .foregroundColor(Color.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        if let buttonText = buttonText, let buttonAction = buttonAction {
                            Button(buttonText) {
                                buttonAction()
                            }
                            .foregroundColor(.orange)
                            
                        }
                    }
                    .padding(14)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.black)
                    .cornerRadius(8)
                    .onAppear {
                        switch messageType {
                        case .success:
                            break
                        case .failure:
                            UINotificationFeedbackGenerator().notificationOccurred(.error)
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + automaticCloseTime) {
                            self.isShowing = false
                            self.onDismiss?()
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.bottom, bottomPadding)
        .animation(.linear, value: isShowing)
        .transition(.opacity)
        .shadow(color: .black.opacity(0.4), radius: 16, x: 0, y: 0)
    }
}
