//
//  ViewModifiers.swift
//  
//
//  Created by David Rothera on 01/06/2022.
//

import SwiftUI

struct WhatsNewViewModifier: ViewModifier {
    let whatsNew: WhatsNew
    @State private var shouldShow: Bool

    init(whatsNew: WhatsNew) {
        self.whatsNew = whatsNew
        _shouldShow = .init(wrappedValue: whatsNew.shouldShow())
    }

    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $shouldShow, onDismiss: didDismiss) {
                WhatsNewView(whatsNew: whatsNew)
            }
    }

    func didDismiss() {
        whatsNew.markAsSeen()
    }
}

struct WhatsNewViewModifierManual: ViewModifier {
    let whatsNew: WhatsNew
    @Binding var shouldShow: Bool

    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $shouldShow) {
                WhatsNewView(whatsNew: whatsNew)
            }
    }
}

public extension View {
    func whatsNew(whatsNew: WhatsNew) -> some View {
        modifier(WhatsNewViewModifier(whatsNew: whatsNew))
    }

    func whatsNew(whatsNew: WhatsNew, shouldShow: Binding<Bool>) -> some View {
        modifier(WhatsNewViewModifierManual(whatsNew: whatsNew, shouldShow: shouldShow))
    }
}
