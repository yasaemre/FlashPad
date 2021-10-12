//
//  DeckTest.swift
//  Tests iOS
//
//  Created by Emre Yasa on 10/11/21.
//
import XCTest
@testable import FlashPad


class DeckTest: XCTestCase {

    //var controller: PersistenceController!
//    var context:NSManagedObjectContext {
//        controller.container.viewContext
//    }
    override func setUp() {
        //some code
        super.setUp()
        //controller = PersistenceController.empty
    }

    override class func tearDown() {
        super.tearDown()
        //controller = nil
    }

    func testAddDeck() {
        let context = PersistenceController.empty.container.viewContext
        let deck = DeckCore(context:context)

        XCTAssertNil(deck.deckName, "should have name")
        XCTAssertNil(deck.deckCreatedAt, "should have date")
    }
}
