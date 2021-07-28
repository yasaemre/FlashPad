//
//  PageViewModel.swift
//  FlashPad (iOS)
//
//  Created by Emre Yasa on 7/26/21.
//

import SwiftUI

class CardViewModel: ObservableObject {
    @Published var cards = [
        Card(cardName: "GRE",numberOfCards: 12, dateCreated: nil),
        Card(cardName: "Eng-Tur",numberOfCards: 132, dateCreated: nil),
        Card(cardName: "GMAT",numberOfCards: 122, dateCreated: nil),
        Card(cardName: "Math Formulas",numberOfCards: 162, dateCreated: nil),
        Card(cardName: "Tur-Spa",numberOfCards: 212, dateCreated: nil)
    ]
    
    //Currently Dragging Page...
    @Published var currentCard: Card?
    
}
