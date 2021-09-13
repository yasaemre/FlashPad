//
//  LikedScreen.swift
//  FlashPad
//
//  Created by Emre Yasa on 9/6/21.
//

import SwiftUI

struct LikedView: View {
    //@State var cardCore:CardCore
    @StateObject var likedCore: LikedCore
    @State var card = Card()
    
    @State var flipped = false
    @State var flip = false
    @State var rightArrowTapped = false
    

    @State var indexCard = 0
    @State var correctAnswer = 0
    @State var falseAnswer = 0
    

    // MARK: - Drawing Constant
    @FetchRequest(
           sortDescriptors: [NSSortDescriptor(keyPath: \LikedCore.word, ascending: true)],
           animation: .default)
       private var likedArrPersistent: FetchedResults<LikedCore>
    var body: some View {
        VStack(spacing:5) {
            Spacer()

            HStack(spacing: 15) {
                
                Button {
                    withAnimation {
                        flip = false
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
            .padding(.bottom, 20)

            ZStack(alignment: .center) {


                Image(likedCore.unwrappedImage)
                    .resizable()
                    .frame(width: 250, height: 350)
                    .clipped()
                    .cornerRadius(12)
                
                    if flip == false {
                        //indexCard = deckCore.cardsArray.count
                        
                            ZStack {
                                
                                Text(likedCore.unwrappedWord)
                                    .font(.custom("HelveticaNeue", size: 40))
                                    .foregroundColor(.black)
                            }
                            
                            
                            
                        } else {
                            ZStack {
                                
                                Text(likedCore.unwrappedDefinition)
                                    .font(.custom("HelveticaNeue", size: 40))
                                    .foregroundColor(.black)
                            }
                            
                            
                        }
                HStack {
                    Image("correct")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:75,height: 75)
                        .offset(x: 60, y: -140)
                        .opacity(Double(card.x/10 - 1))
                    
                    Spacer()
                    Image("false")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:75,height: 75)
                        .offset(x: -60, y: -140)
                        .opacity(Double(card.x/10 * -1 - 1))
                }
                
            }
            .modifier(FlipEffect(flipped: $flipped, angle: flip ? 0 : 180))
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
                        //self.animationActivated = false
                        
                    case let x where x > 100:
                        card.x = 500; card.degree = 12
                        correctAnswer += 1
                        if  indexCard > 0 {
                            //indexCard -= 1
                            break
                        }
                       // self.isTapped = true
                        //self.resetBg = false
                        
                    case (-100)...(-1):
                        card.x = 0; card.degree = 0; card.y = 0
                    case let x where x < -100:
                        card.x  = -500; card.degree = -12
                        falseAnswer += 1
                        if  indexCard > 0 {
                            //indexCard -= 1
                            break
                            
                        }
                       // self.isTapped = true
                       // self.resetBg = false

                        
                    default:
                        card.x = 0; card.y = 0
                        
                    }
                    
                }
                
                
                
            }
            )
        //}
            Text("\(indexCard+1) of \(likedArrPersistent.count)")
                .font(.title2)
                .padding(.top, 10)
            
            HStack(spacing: 40){
                
                Text("Correct: \(correctAnswer)")
                    .font(.title)
                    .frame(width: 130, height: 40)
                    .background(Color.init(hex: "1EAE61"))
                    .clipShape(Capsule())
                    .foregroundColor(.white)
                
                
                
                Text("False: \(falseAnswer)")
                    .font(.title)
                    .frame(width: 130, height: 40)
                    .background(Color.init(hex: "B60D0D"))
                    .clipShape(Capsule())
                    .foregroundColor(.white)
            }
            Spacer()
        }
        .onAppear {
            print("Liked Screen View")
            //indexCard = likedArrPersistent.count-1
            for likedCard in likedArrPersistent {
                print(likedCard.unwrappedWord)
            }
        }
        //.navigationBarHidden(true)
        .padding(.top, 1)
        .ignoresSafeArea(.all, edges: .all)

        
    }
}

//struct LikedView_Previews: PreviewProvider {
//    static var previews: some View {
//        LikedView(cardCore: CardCore(), card: Card(), flipped: .constant(false), flip: .constant(false), rightArrowTapped: .constant(false), indexCard: 0, correctAnswer: 0, falseAnswer: 0)
//    }
//}
