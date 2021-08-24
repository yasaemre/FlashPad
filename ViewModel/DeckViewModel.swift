//
//  PageViewModel.swift
//  FlashPad (iOS)
//
//  Created by Emre Yasa on 7/26/21.
//

import SwiftUI

class DeckViewModel: ObservableObject {
    @Published var decks = [Deck]()
    
    //Currently Dragging Page...
    @Published var currentCard: Deck?
    
}
