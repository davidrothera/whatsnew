//
//  WhatsNewItemView.swift
//  
//
//  Created by David Rothera on 01/06/2022.
//

import SwiftUI

struct WhatsNewItemView: View {
    var item: WhatsNewItem
    var index: Int

    @State private var offset: CGFloat = 1000

    var body: some View {
        HStack {
            item.icon
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundColor(item.color)
                .padding()
            VStack(alignment: .leading, spacing: 8) {
                Text(item.title)
                    .foregroundColor(.primary)
                    .font(.system(.headline, design: .rounded))
                Text(item.body)
                    .foregroundColor(.secondary)
                    .font(.system(.subheadline, design: .rounded))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .animation(.spring().delay(0.5 + 0.4 * Double(index)), value: offset)
        .offset(x: offset)
        .onAppear {
            offset = 0
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        WhatsNewItemView(item: .init(id: "sample", title: "Example", body: "An example item", colorName: "mint", iconName: "circle.fill"), index: 0)
    }
}
