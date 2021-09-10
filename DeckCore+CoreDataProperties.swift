//
//  DeckCore+CoreDataProperties.swift
//  FlashPad
//
//  Created by Emre Yasa on 9/9/21.
//
//

import Foundation
import CoreData


extension DeckCore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DeckCore> {
        return NSFetchRequest<DeckCore>(entityName: "DeckCore")
    }

    @NSManaged public var deckCreatedAt: String?
    @NSManaged public var deckName: String?
    @NSManaged public var id: UUID?
    @NSManaged public var numberOfCardsInDeck: Int16
    @NSManaged public var cards: NSSet?
    @NSManaged public var likedCards: NSSet?


    public var unwrappedDeckName:String {
        deckName ?? "Unknown deckName"
    }
    
    public var cardsArray: [CardCore] {
        let cardsSet = cards as? Set<CardCore> ?? []
        
        return cardsSet.sorted {
            $0.unwrappedWord < $1.unwrappedWord
        }
    }
    
    public var likedCardsArray: [CardCore] {
        let cardsSet = likedCards as? Set<CardCore> ?? []
        
        return cardsSet.sorted {
            $0.unwrappedWord < $1.unwrappedWord
        }
    }
    
}

// MARK: Generated accessors for cards
extension DeckCore {

    @objc(addCardsObject:)
    @NSManaged public func addToCards(_ value: CardCore)

    @objc(removeCardsObject:)
    @NSManaged public func removeFromCards(_ value: CardCore)

    @objc(addCards:)
    @NSManaged public func addToCards(_ values: NSSet)

    @objc(removeCards:)
    @NSManaged public func removeFromCards(_ values: NSSet)

}

// MARK: Generated accessors for likedCards
extension DeckCore {

    @objc(addLikedCardsObject:)
    @NSManaged public func addToLikedCards(_ value: CardCore)

    @objc(removeLikedCardsObject:)
    @NSManaged public func removeFromLikedCards(_ value: CardCore)

    @objc(addLikedCards:)
    @NSManaged public func addToLikedCards(_ values: NSSet)

    @objc(removeLikedCards:)
    @NSManaged public func removeFromLikedCards(_ values: NSSet)

}

extension DeckCore : Identifiable {

}
