//
//  EditScrnView.swift
//  FlashPad
//
//  Created by Emre Yasa on 9/2/21.
//

import SwiftUI

struct EditScrnView: View {
    
    @State var card =  Card()
    @StateObject var deckCore = DeckCore()
    //@State var cardCore: CardCore
    //@State var cardCore: CardCore
    @State var indexCard = UserDefaults.standard.integer(forKey: "indexCard")
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \DeckCore.deckName, ascending: true)],
        animation: .default)
    private var decksArrPersistent: FetchedResults<DeckCore>
    
    var body: some View {
        ZStack(){
            EditView(card: card, deckCore: deckCore)
                //.navigationBarHidden(true)
            //navigationBarHidden work on real device iPhone x, but not in simulator for now keep it in active.

        }
        .onAppear(perform: {
            if deckCore.cardsArray.isEmpty {
                indexCard = deckCore.cardsArray.count
            } else {
                indexCard = deckCore.cardsArray.count-1
            }
            print("Index in EditScrnView: \(indexCard)")
        })
        .zIndex(1.0)
        
        
    }
}

//struct EditScrnView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditScrnView()
//    }
//}
