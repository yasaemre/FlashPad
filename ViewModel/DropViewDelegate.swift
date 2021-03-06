//
//  DropViewDelegate.swift
//  FlashPad (iOS)
//
//  Created by Emre Yasa on 7/26/21.
//

import SwiftUI

struct DropViewDelegate: DropDelegate {
    var card:Deck
    var cardData: DeckViewModel
    func performDrop(info: DropInfo) -> Bool {
        return true
    }
    
    //When User Dragged Into New Page...
    func dropEntered(info: DropInfo) {
        print("\(card.deckName)")
        
        let fromIndex = cardData.decks.firstIndex { (card) -> Bool in
            return card.id == cardData.currentCard?.id
        } ?? 0
        
        let toIndex = cardData.decks.firstIndex { (card) -> Bool in
            return card.id == self.card.id
        } ?? 0
        
        //Safe Check if both are not same...
        if fromIndex != toIndex {
            withAnimation {
                //Swapping Data...
                let fromPage = cardData.decks[fromIndex]
                cardData.decks[fromIndex] = cardData.decks[toIndex]
                cardData.decks[toIndex] = fromPage
            }
        }
        
        //Setting Action as Move...
        func dropUpdated(info:DropInfo) -> DropProposal? {
            return DropProposal(operation: .move)
        }
    }
}
