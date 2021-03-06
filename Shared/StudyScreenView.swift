//
//  StudyScreenView.swift
//  FlashPad
//
//  Created by Emre Yasa on 8/29/21.
//

import SwiftUI
import Foundation

struct StudyScreenView: View {
    

    
   // @State var card: Card
        // MARK: - Drawing Constant
    @StateObject var deckCore:DeckCore
    @State var card:Card
     @State var indexCard = UserDefaults.standard.integer(forKey: "indexCard")
    @State var correctAnswer = 0
    
    @State var resetBg = false
    @State var falseAnswer = 0
 
    @State var correctA = 0.0
    @State var prevCorrectA  = 0.0
    @State var flipped = false
    @State var flip = false

    var body: some View {
        
        ZStack(alignment: .top){
            ForEach(deckCore.cardsArray.reversed()) { cardCore in

                CardView(cardCore: cardCore, card: card, flipped: $flipped, flip: $flip, deckCore: deckCore, indexCard: $indexCard, correctAnswer: $correctAnswer, falseAnswer: $falseAnswer, resetBg: $resetBg, correctA: $correctA)
                    
            }
            .onAppear {
                indexCard = deckCore.cardsArray.count-1
            }
            .onDisappear{
                if prevCorrectA != correctA {
                deckCore.correctRate = (correctA / Double(deckCore.cardsArray.count)) * 100.0
                print("correctA \(correctA)")
                print("deckCore.cardsArray.count \(deckCore.cardsArray.count)")
                print("deckCore.correctRate \(deckCore.correctRate)")
                }
                prevCorrectA = correctA
            }
        }
        
       
        .zIndex(1.0)
    }
}
