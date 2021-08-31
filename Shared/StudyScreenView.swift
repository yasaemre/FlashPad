//
//  StudyScreenView.swift
//  FlashPad
//
//  Created by Emre Yasa on 8/29/21.
//

import SwiftUI

struct StudyScreenView: View {
    
    @StateObject var card: Card
        // MARK: - Drawing Constant
    let cardGradient = Gradient(colors: [Color.black.opacity(0.0), Color.black.opacity(0.5)])
    @StateObject var deckCore:DeckCore
    @State var indexCard = UserDefaults.standard.integer(forKey: "indexCard")

    var body: some View {
        ZStack{
            ForEach(0..<deckCore.cardsArray.count, id:\.self) { index in
                ZStack(alignment: .topLeading) {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(LinearGradient(gradient: Gradient(colors: [Color.init(hex: "6C63FF"), Color.init(hex: "c8d4f5")]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(width: 250, height: 350)
                        .shadow(color: Color(UIColor(.black)), radius: 10, x: 5, y: 5)
                        .overlay(
                            ZStack {
                            Text(deckCore.cardsArray[index].unwrappedWord)
                                .font(.custom("HelveticaNeue", size: 40))
                                .foregroundColor(.white)
        
        
                            HStack() {
                                Image("correct")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width:75,height: 75)
                                    .opacity(Double(card.x/10 - 1))
                                Spacer()
                                Image("false")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width:75,height: 75)
                                    .opacity(Double(card.x/10 * -1 - 1))
                            }
                            .offset(x: 0, y: -140)
                        }
                        )

                }
                .cornerRadius(8)
                .offset(x: card.x, y: card.y)
                .rotationEffect(.init(degrees: card.degree))
                .gesture (
                    DragGesture()
                        .onChanged { value in
                    withAnimation(.default) {
                        card.x = value.translation.width
                        // MARK: - BUG 5
                        card.y = value.translation.height
                        card.degree = 7 * (value.translation.width > 0 ? 1 : -1)
                    }
                }
                        .onEnded { (value) in
                    withAnimation(.interpolatingSpring(mass: 1.0, stiffness: 50, damping: 8, initialVelocity: 0)) {
                        switch value.translation.width {
                        case 0...100:
                            card.x = 0; card.degree = 0; card.y = 0
                        case let x where x > 100:
                            card.x = 500; card.degree = 12
                        case (-100)...(-1):
                            card.x = 0; card.degree = 0; card.y = 0
                        case let x where x < -100:
                            card.x  = -500; card.degree = -12
                        default:
                            card.x = 0; card.y = 0
                        }
                    }
                }
                )
            }
        }
        .padding(8)
        .zIndex(1.0)
    }
}

struct StudyScreenView_Previews: PreviewProvider {
    static var previews: some View {
        StudyScreenView(card: Card(), deckCore: DeckCore())
    }
}
