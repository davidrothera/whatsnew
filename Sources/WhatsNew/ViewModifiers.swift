//
//  ViewModifiers.swift
//  
//
//  Created by David Rothera on 01/06/2022.
//

import SwiftUI

struct WhatsNewViewModifier<LinkView>: ViewModifier where LinkView: View {
    let whatsNew: WhatsNew
    @State private var shouldShow: Bool
    let linkView: LinkView

    init(whatsNew: WhatsNew, @ViewBuilder linkView: () -> LinkView) {
        self.whatsNew = whatsNew
        _shouldShow = .init(wrappedValue: whatsNew.shouldShow())
        self.linkView = linkView()
    }

    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $shouldShow, onDismiss: didDismiss) {
                WhatsNewView<LinkView>(whatsNew: whatsNew) {
                    linkView
                }
            }
    }

    func didDismiss() {
        whatsNew.markAsSeen()
    }
}

struct WhatsNewViewModifierManual<LinkView: View>: ViewModifier {
    let whatsNew: WhatsNew
    @Binding var shouldShow: Bool
    let linkView: LinkView

    init(whatsNew: WhatsNew, shouldShow: Binding<Bool>, @ViewBuilder linkView: () -> LinkView) {
        self.whatsNew = whatsNew
        self._shouldShow = shouldShow
        self.linkView = linkView()
    }

    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $shouldShow) {
                WhatsNewView(whatsNew: whatsNew) {
                    linkView
                }
            }
    }
}

public extension View {
    func whatsNew<Content: View>(whatsNew: WhatsNew, @ViewBuilder linkView: () -> Content) -> some View {
        modifier(WhatsNewViewModifier(whatsNew: whatsNew, linkView: linkView))
    }

    func whatsNew<Content: View>(whatsNew: WhatsNew, shouldShow: Binding<Bool>, @ViewBuilder linkView: () -> Content) -> some View {
        modifier(WhatsNewViewModifierManual(whatsNew: whatsNew, shouldShow: shouldShow, linkView: linkView))
    }
}
