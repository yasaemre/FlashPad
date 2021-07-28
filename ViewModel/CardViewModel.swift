//
//  PageViewModel.swift
//  FlashPad (iOS)
//
//  Created by Emre Yasa on 7/26/21.
//

import SwiftUI

class CardViewModel: ObservableObject {
    @Published var cards = [
        Card(cardName: "GRE"),
        Card(cardName: "Eng-Tur"),
        Card(cardName: "GMAT"),
        Card(cardName: "Math Formulas"),
        Card(cardName: "Tur-Spa")
    ]
    
    //Currently Dragging Page...
    @Published var currentCard: Card?
}
