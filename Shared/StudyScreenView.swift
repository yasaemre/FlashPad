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
   // @State var indexCard = UserDefaults.standard.integer(forKey: "indexCard")
    @State var indexCard = 0
    @State var correctAnswer = 0
//    @State var falseAnswer:Int
    //@State var isTapped = false
    
    @State var resetBg = false
    //@Binding var resetBg:Bool
    @State var correctRate = 0.0
    //@State var correctAnswer = 0
    @State var falseAnswer = 0
    //@EnvironmentObject var settings: GameSettings
    //@State var correctAnswer = UserDefaults.standard.integer(forKey: "correctAnswer")
    @AppStorage("correctA") var correctA = 0.0
    
    var body: some View {
        
        ZStack(alignment: .top){
            ForEach(deckCore.cardsArray.reversed()) { cardCore in
                CardView(cardCore: cardCore, card: card, deckCore: deckCore, indexCard: $indexCard, correctAnswer: $correctAnswer,  falseAnswer: $falseAnswer, resetBg: $resetBg)
                    
            }
            .onAppear {
                indexCard = deckCore.cardsArray.count-1
    
            }
            
            
        }
        .onDisappear{
            deckCore.correctRate = (correctA / Double(deckCore.cardsArray.count)) * 100
            print("correctA \(correctA)")
            print("deckCore.cardsArray.count \(deckCore.cardsArray.count)")
            print("deckCore.correctRate \(deckCore.correctRate)")
            correctA = 0
        }
       
        .zIndex(1.0)
    }
}
    



//struct StudyScreenView_Previews: PreviewProvider {
//    static var previews: some View {
//        StudyScreenView(card: Card(), deckCore: DeckCore())
//    }
//}
