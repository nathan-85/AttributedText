#if canImport(SwiftUI) && !os(watchOS)

    import SwiftUI

    @available(macOS 11.0, iOS 14.0, tvOS 14.0, *)
    public struct AttributedText: View {
        @StateObject private var textViewStore = TextViewStore()

        private let attributedText: NSAttributedString
        private var isSelectable: Bool

        public init(_ attributedText: NSAttributedString, isSelectable: Bool = false) {
            self.attributedText = attributedText
            self.isSelectable = isSelectable
        }

        public var body: some View {
            GeometryReader { geometry in
                TextViewWrapper(
                    isSelectable: isSelectable,
                    attributedText: attributedText,
                    maxLayoutWidth: geometry.maxWidth,
                    textViewStore: textViewStore
                )
            }
            .frame(
                idealWidth: textViewStore.intrinsicContentSize?.width,
                idealHeight: textViewStore.intrinsicContentSize?.height
            )
            .fixedSize(horizontal: false, vertical: true)
        }
    }

    @available(macOS 11.0, iOS 14.0, tvOS 14.0, *)
    private extension GeometryProxy {
        var maxWidth: CGFloat {
            size.width - safeAreaInsets.leading - safeAreaInsets.trailing
        }
    }

#endif
