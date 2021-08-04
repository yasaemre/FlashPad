//
//  Page.swift
//  FlashPad (iOS)
//
//  Created by Emre Yasa on 7/26/21.
//

import Foundation


//Sample URL Pages...

struct Deck: Identifiable {
    var id = UUID().uuidString
    var deckName: String
    var numberOfCardsInDeck: Int
    var deckCreatedAt: Date?
    
    func getTodayDate() -> String
    {
        let today = Date()
        let formatter3 = DateFormatter()
        formatter3.dateStyle = .short
        return formatter3.string(from: today)
        
    }
}
