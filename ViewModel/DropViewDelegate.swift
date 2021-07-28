//
//  DropViewDelegate.swift
//  FlashPad (iOS)
//
//  Created by Emre Yasa on 7/26/21.
//

import SwiftUI

struct DropViewDelegate: DropDelegate {
    var card:Card
    var cardData: CardViewModel
    func performDrop(info: DropInfo) -> Bool {
        return true
    }
    
    //When User Dragged Into New Page...
    func dropEntered(info: DropInfo) {
        print("\(card.cardName)")
        
        let fromIndex = cardData.cards.firstIndex { (card) -> Bool in
            return card.id == cardData.currentCard?.id
        } ?? 0
        
        let toIndex = cardData.cards.firstIndex { (card) -> Bool in
            return card.id == self.card.id
        } ?? 0
        
        //Safe Check if both are not same...
        if fromIndex != toIndex {
            withAnimation {
                //Swapping Data...
                let fromPage = cardData.cards[fromIndex]
                cardData.cards[fromIndex] = cardData.cards[toIndex]
                cardData.cards[toIndex] = fromPage
            }
        }
        
        //Setting Action as Move...
        func dropUpdated(info:DropInfo) -> DropProposal? {
            return DropProposal(operation: .move)
        }
    }
}
