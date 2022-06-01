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

public extension View {
    func whatsNew(whatsNew: WhatsNew) -> some View {
        modifier(WhatsNewViewModifier(whatsNew: whatsNew))
    }
}
