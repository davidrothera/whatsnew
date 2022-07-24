//
//  InitTests.swift
//  
//
//  Created by David Rothera on 01/06/2022.
//

import XCTest
@testable import WhatsNew

class InitTests: XCTestCase {
    func testInitWithItems() throws {
        let items: [WhatsNewItem] = [
            .init(id: "1", title: "A", body: "B", colorName: "C", iconName: "D"),
        ]

        let whatsNew = WhatsNew(items: items, stateStore: WhatsNewMemoryStore())
        XCTAssertEqual(1, whatsNew.items.count)
    }

    func testInitWithPathJson() throws {
        guard let path = Bundle.module.path(forResource: "TestData", ofType: "json") else {
            XCTFail()
            return
        }

        let whatsNew = try WhatsNew(fromPath: path, withSourceType: .json, stateStore: WhatsNewMemoryStore())
        XCTAssertEqual(1, whatsNew.items.count)
    }

    func testInitWithPathPlist() throws {
        guard let path = Bundle.module.path(forResource: "TestData", ofType: "plist") else {
            XCTFail()
            return
        }

        let whatsNew = try WhatsNew(fromPath: path, withSourceType: .plist, stateStore: WhatsNewMemoryStore())
        XCTAssertEqual(1, whatsNew.items.count)
    }
}
