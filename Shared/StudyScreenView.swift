//
//  StudyScreenView.swift
//  FlashPad
//
//  Created by Emre Yasa on 8/29/21.
//

import SwiftUI

struct StudyScreenView: View {
    
    @State var flipped = false
    @State var flip = false
    @State var rightArrowTapped = false
    
    @State var card: Card
        // MARK: - Drawing Constant
    let cardGradient = Gradient(colors: [Color.black.opacity(0.0), Color.black.opacity(0.5)])
    @StateObject var deckCore:DeckCore
    @State var indexCard = UserDefaults.standard.integer(forKey: "indexCard")

    var body: some View {
        ZStack{
            ForEach(0..<deckCore.cardsArray.count, id:\.self) { index in
                VStack {
                    HStack(spacing: 15) {
                        
                        Button {
                            withAnimation {
                                flip = false
                                //addCard()
                                //saveContext()
                                for card in deckCore.cardsArray {
                                    print("\(card.unwrappedWord)")
                                    print("\(card.unwrappedDefinition)")
                                    print("\(card.imageName)")
                                    print("\(deckCore.cardsArray[index].imageName)")

                                }
                                print("Index no: \(index ?? 0)")


                            }
                        } label: {
                            Text("Word")
                                .font(.title)
                                .frame(width: 130, height: 40)
                                .background(!flip ? Color.init(hex: "6C63FF") : .gray)
                                .clipShape(Capsule())
                                .foregroundColor(.white)
                            

                        }
                     
                        Button {
                            withAnimation {
                                flip = true
                                //saveContext()
                        }
                        } label: {
                            Text("Meaning")
                                .font(.title)
                            .frame(width: 130, height: 40)
                            .background(flip ? Color.init(hex: "6C63FF") : .gray)
                            .clipShape(Capsule())
                            .foregroundColor(.white)
                        }
                    }
                    
                ZStack(alignment: .topLeading) {
                    
                        Image("\(deckCore.cardsArray[index].imageName ?? "cardBackg")")
                        .resizable()
                        .clipped()
                        .frame(width: 250, height: 350)
                        .cornerRadius(10)
                    
//                    RoundedRectangle(cornerRadius: 10)
//                        .fill(LinearGradient(gradient: Gradient(colors: [Color.init(hex: "6C63FF"), Color.init(hex: "c8d4f5")]), startPoint: .topLeading, endPoint: .bottomTrailing))
//                        .frame(width: 250, height: 350)
//                        .shadow(color: Color(UIColor(.black)), radius: 10, x: 5, y: 5)
//                        .overlay(
//                            ZStack {
//                            Text(deckCore.cardsArray[index].unwrappedWord)
//                                .font(.custom("HelveticaNeue", size: 40))
//                                .foregroundColor(.white)
//
//
//                            HStack() {
//                                Image("correct")
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fit)
//                                    .frame(width:75,height: 75)
//                                    .opacity(Double(card.x/10 - 1))
//                                Spacer()
//                                Image("false")
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fit)
//                                    .frame(width:75,height: 75)
//                                    .opacity(Double(card.x/10 * -1 - 1))
//                            }
//                            .offset(x: 0, y: -140)
//                        }
//                        )
                    
                        .overlay(
                            
                        VStack(alignment:.center, spacing: 5) {
                            
                        if deckCore.cardsArray.count > 0 {
                            if flip == false {
                                if rightArrowTapped == true {
                                    
                                    Text("")
                                } else {
                                    ZStack {
                                        Text(deckCore.cardsArray[indexCard].unwrappedWord)
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
                                        
                                }
                            } else {
//                                if rightArrowTapped == true {
//                                    Text("")
//                                } else {
                                ZStack {
                                
                                    Text(deckCore.cardsArray[indexCard].unwrappedDefinition)
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
                                        
                                //}
                            }
                        } else {
                            ForEach(0..<deckCore.cardsArray.count, id:\.self) { index in
                                if flip == false {
    //                                if rightArrowTapped == true {
    //                                    Text("")
    //                                } else {
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

                                    //}
                                } else {
    //                                if rightArrowTapped == true {
    //                                    Text("")
    //                                } else {
                                    ZStack {
                                        Text(deckCore.cardsArray[index].unwrappedDefinition)
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

                                    //}
                                }
                                
                                
                        
                                
                            }
                        }
                            
                        
                    }
                            
                    )
                    .modifier(FlipEffect(flipped: $flipped, angle: flip ? 0 : 180))
                    .padding(.top, 5)
                    
                    
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
                    
                    Text("\(indexCard+1) of \(deckCore.cardsArray.count)")
                        .font(.title2)
                        .padding(.top, 10)
                    
                    HStack(spacing: 30){
                        Button {
                            if  indexCard >= 1 {
                                indexCard -= 1
                            }
                        } label: {
                            Image(systemName: "arrowshape.turn.up.backward")
                                .font(.largeTitle)
                                .foregroundColor(Color.init(hex: "6C63FF"))
                        }
                        Spacer()
                        Button {
                            //
                            if indexCard
                                != deckCore.cardsArray.count-1, !deckCore.cardsArray.isEmpty {
                                indexCard += 1
                            }
                        } label: {
                            Image(systemName: "arrowshape.turn.up.right")
                                .font(.largeTitle)
                                .foregroundColor(Color.init(hex: "6C63FF"))
                        }
                    }
                }
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
