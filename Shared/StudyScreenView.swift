//
//  StudyScreenView.swift
//  FlashPad
//
//  Created by Emre Yasa on 8/29/21.
//

import SwiftUI

struct StudyScreenView: View {
    

    
   // @State var card: Card
        // MARK: - Drawing Constant
    @StateObject var deckCore:DeckCore
    @State var card:Card
    @State var indexCard = UserDefaults.standard.integer(forKey: "indexCard")
    @State var correctAnswer:Int
    @State var falseAnswer:Int

    var body: some View {
        ZStack(alignment: .top){
            ForEach(deckCore.cardsArray.reversed()) { cardCore in
                CardView(cardCore: cardCore, card: card, deckCore: deckCore, indexCard: $indexCard, correctAnswer: $correctAnswer, falseAnswer: $falseAnswer)
            }
        }
        .onAppear(perform: {
            
            indexCard = deckCore.cardsArray.count-1
            print("\(indexCard)")
        })
        .zIndex(1.0)
    }
}
    

//struct StudyScreenView_Previews: PreviewProvider {
//    static var previews: some View {
//        StudyScreenView(card: Card(), deckCore: DeckCore())
//    }
//}
