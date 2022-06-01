//
//  ContentView.swift
//  WhatNewSampleApp
//
//  Created by David Rothera on 01/06/2022.
//

import SwiftUI
import WhatsNew

struct ContentView: View {
    func foo() {
        let whatsNew = WhatsNew(items: [])
    }

    var body: some View {
        Text("Hello, world!")
            .padding()
            .whatsNew(whatsNew: .init(items: []))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
