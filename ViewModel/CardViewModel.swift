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
        Card(word: "Soccer",definition: "sfsaf asdf jsd sdf "),
        Card(word: "Basketball",definition: "sfsaf asdf jsd sdf "),
        Card(word: "Tennis",definition: "sfsaf asdf jsd sdf "),
        Card(word: "Golf",definition: "sfsaf asdf jsd sdf "),
        Card(word: "Swimming",definition: "sfsaf asdf jsd sdf ")
    ]
    
    //Currently Dragging Page...
    @Published var currentCard: Card?
    
}

