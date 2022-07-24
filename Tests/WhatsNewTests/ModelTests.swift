//
//  File.swift
//  
//
//  Created by David Rothera on 01/06/2022.
//

import XCTest
@testable import WhatsNew

class ModelTests: XCTestCase {
    func testDecodingJson() throws {
        guard let url = Bundle.module.url(forResource: "TestData.json", withExtension: nil) else {
            XCTFail()
            return
        }
        let data = try Data(contentsOf: url)
        let serializer = JSONDecoder()
        let items = try serializer.decode([WhatsNewItem].self, from: data)
        XCTAssertEqual(1, items.count)
        guard let item = items.first else { XCTFail(); return }

        XCTAssertEqual("Foo", item.title)
        XCTAssertEqual("Bar", item.body)
        XCTAssertEqual("Baz", item.iconName)
    }

    func testDecodingPlist() throws {
        guard let url = Bundle.module.url(forResource: "TestData.plist", withExtension: nil) else {
            XCTFail()
            return
        }
        let data = try Data(contentsOf: url)
        let serializer = PropertyListDecoder()
        let items = try serializer.decode([WhatsNewItem].self, from: data)
        XCTAssertEqual(1, items.count)
        guard let item = items.first else { XCTFail(); return }

        XCTAssertEqual("Foo", item.title)
        XCTAssertEqual("Bar", item.body)
        XCTAssertEqual("Baz", item.iconName)
    }

    func testFilterItems() throws {
        class TestStateStore: WhatsNewStateStore {
            func hasBeenSeen(item: WhatsNewItem) -> Bool {
                return item.id == "1"
            }
            func markAsSeen(items: [WhatsNewItem]) {}
        }

        let items: [WhatsNewItem] = [
            WhatsNewItem(id: "1", title: "", body: "", colorName: "", iconName: ""),
            WhatsNewItem(id: "2", title: "", body: "", colorName: "", iconName: ""),
            WhatsNewItem(id: "3", title: "", body: "", colorName: "", iconName: ""),
        ]
        let whatsNew = WhatsNew(items: items, stateStore: TestStateStore())
        XCTAssertEqual(2, whatsNew.items.count)
    }
}
