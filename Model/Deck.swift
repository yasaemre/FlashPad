//
//  Page.swift
//  FlashPad (iOS)
//
//  Created by Emre Yasa on 7/26/21.
//

import Foundation


//Sample URL Pages...

class Deck: Identifiable, ObservableObject {
    @Published var id = UUID().uuidString
    @Published var deckName: String = ""
    @Published var numberOfCardsInDeck: Int = 0
    @Published var deckCreatedAt: String = ""
    
    func getTodayDate() -> String
    {
        let today = Date()
        let formatter3 = DateFormatter()
        formatter3.dateStyle = .short
        return formatter3.string(from: today)
        
    }
}

