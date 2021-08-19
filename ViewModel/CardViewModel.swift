//
//  CardViewModel.swift
//  FlashPad
//
//  Created by Emre Yasa on 8/3/21.
//

import SwiftUI

import SwiftUI

class CardViewModel: ObservableObject {
    @Published var cards = [
        Card(),
        Card(),
        Card(),
        Card(),
        Card()
    ]
    
    //Currently Dragging Page...
    @Published var currentCard: Card?
    
}

