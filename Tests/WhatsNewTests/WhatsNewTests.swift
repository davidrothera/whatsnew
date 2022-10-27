//
//  WhatsNewTests.swift
//  
//
//  Created by David Rothera on 20/10/2022.
//

import XCTest
@testable import WhatsNew

class TestUserDefaults: WhatsNewUserDefaultsProtocol {
    var store: [String: Any?] = [:]

    func bool(forKey defaultName: String) -> Bool {
        return store.index(forKey: defaultName) != nil
    }

    func data(forKey defaultName: String) -> Data? {
        return store[defaultName] as? Data
    }

    func set(_ value: Any?, forKey defaultName: String) {
        if value != nil {
            store[defaultName] = value
        } else {
            store.removeValue(forKey: defaultName)
        }
    }
}

class WhatsNewTests: XCTestCase {
    var whatsNew: WhatsNew!
    var userDefaults: TestUserDefaults!
    var stateStore: WhatsNewStateStore!

    var items: [WhatsNewItem] = [
        .init(id: "1", title: "1t", body: "1b", colorName: "blue", iconName: "1.circle"),
    ]

    override func setUpWithError() throws {
        userDefaults = TestUserDefaults()
        stateStore = WhatsNewUserDefaultsStateStore(userDefaults: userDefaults)
        whatsNew = WhatsNew(items: items, stateStore: stateStore)
    }

    func testMarkAllAsSeen() throws {
        whatsNew.markAsSeen()
        XCTAssertTrue(userDefaults.store["whats_new_seen_items"] != nil)
        XCTAssertEqual(whatsNew.items.count, 1)
        XCTAssertEqual(whatsNew.rawItems.count, 1)
    }

    func testFiltering() throws {
        XCTAssertEqual(whatsNew.items.count, 1)
        XCTAssertEqual(whatsNew.rawItems.count, 1)
        whatsNew.markAsSeen()
        XCTAssertTrue(userDefaults.store["whats_new_seen_items"] != nil)

        let newItem = WhatsNewItem(id: "2", title: "2t", body: "2b", colorName: "red", iconName: "2.circle")
        items.append(newItem)

        whatsNew = WhatsNew(items: items, stateStore: stateStore)
        XCTAssertEqual(whatsNew.rawItems.count, 2)
        XCTAssertEqual(whatsNew.items.count, 1)
        XCTAssertEqual(whatsNew.items.first, newItem)
    }

    func testFirstAppLaunch() throws {
        XCTAssertTrue(stateStore.firstAppLaunch())
        stateStore = WhatsNewUserDefaultsStateStore(userDefaults: userDefaults)
        XCTAssertFalse(stateStore.firstAppLaunch())
    }

    func testShouldShow() throws {
        // Should be false because its the first launch
        XCTAssertFalse(whatsNew.shouldShow())

        stateStore = WhatsNewUserDefaultsStateStore(userDefaults: userDefaults)
        whatsNew = WhatsNew(items: items, stateStore: stateStore)

        // Should be false as now all items were marked as seen
        XCTAssertFalse(whatsNew.shouldShow())

        let newItem = WhatsNewItem(id: "2", title: "2t", body: "2b", colorName: "red", iconName: "2.circle")
        items.append(newItem)
        whatsNew = WhatsNew(items: items, stateStore: stateStore)

        // Should now be true as there is a new item to show
        XCTAssertTrue(whatsNew.shouldShow())
        XCTAssertEqual(whatsNew.items.count, 1)
        XCTAssertEqual(whatsNew.rawItems.count, 2)
    }
}
