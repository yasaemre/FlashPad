////
////  LikedScreenView.swift
////  FlashPad
////
////  Created by Emre Yasa on 9/7/21.
////
//
//import SwiftUI
//
//struct LikedScreenView: View {
//    // MARK: - Drawing Constant
//     @State var card:Card
//    // @State var indexCard = UserDefaults.standard.integer(forKey: "indexCard")
//     @State var indexCard = 0
//     @State var correctAnswer = 0
//     @State var falseAnswer = 0
//    //@StateObject var deckCore:DeckCore
//    @StateObject var likedCore:LikedCore
////
////    @Environment(\.managedObjectContext) private var viewContext
////        @FetchRequest(
////            entity: LikedCore.entity(),
////            sortDescriptors: []
////        ) var likedArrPersistent: FetchedResults<LikedCore>
//
//
//
//     var body: some View {
//
//         ZStack(alignment: .top){
//             //likedArray
//             ForEach(likedCore.likedArray.reversed()) { cardCore in
//           //  ZStack(alignment: d.top) {
//                 LikedView(cardCore: cardCore, card: card, indexCard: $indexCard)
//
//
//           }
//           .onAppear {
//               print("Liked Screen View")
//               indexCard = likedCore.likedArray.count-1
//               for likedCard in likedCore.likedArray {
//                   print(likedCard.unwrappedWord)
//               }
//          }
//         }
//         .zIndex(1.0)
//     }
//}
////
////struct LikedScreenView_Previews: PreviewProvider {
////    static var previews: some View {
////        LikedScreenView()
////    }
////}
