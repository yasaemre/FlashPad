//
//  PageViewModel.swift
//  FlashPad (iOS)
//
//  Created by Emre Yasa on 7/26/21.
//

import SwiftUI

class DeckViewModel: ObservableObject {
    @Published var cards = [
        Deck(deckName: "GRE",numberOfCardsInDeck: 12, deckCreatedAt: nil),
        Deck(deckName: "Eng-Tur",numberOfCardsInDeck: 132, deckCreatedAt: nil),
        Deck(deckName: "GMAT",numberOfCardsInDeck: 122, deckCreatedAt: nil),
        Deck(deckName: "Math Formulas",numberOfCardsInDeck: 162, deckCreatedAt: nil),
        Deck(deckName: "Tur-Spa",numberOfCardsInDeck: 212, deckCreatedAt: nil)
    ]
    
    //Currently Dragging Page...
    @Published var currentCard: Deck?
    
}
