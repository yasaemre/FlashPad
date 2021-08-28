//
//  CardCore+CoreDataProperties.swift
//  FlashPad
//
//  Created by Emre Yasa on 8/26/21.
//
//

import Foundation
import CoreData


extension CardCore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CardCore> {
        return NSFetchRequest<CardCore>(entityName: "CardCore")
    }

    @NSManaged public var definition: String?
    @NSManaged public var word: String?
    @NSManaged public var deck: DeckCore?

    public var unwrappedWord:String {
        word ?? "Unknown deckName"
    }
    
    public var unwrappedDefinition:String {
        definition ?? "Unknown deckName"
    }
}

extension CardCore : Identifiable {

}
