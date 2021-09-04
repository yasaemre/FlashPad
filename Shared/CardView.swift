//
//  CardView.swift
//  
//
//  Created by Emre Yasa on 8/31/21.
//

import SwiftUI

struct CardView: View {
    @State var cardCore: CardCore
    @State var card: Card
    
    @State var flipped = false
    @State var flip = false
    @State var rightArrowTapped = false
    
    // @State var card: Card
    // MARK: - Drawing Constant
    @StateObject var deckCore:DeckCore
    @Binding var indexCard:Int
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Binding var correctAnswer:Int
    @Binding var falseAnswer:Int
    
    @State private var showStrokeBorder = false
    @Binding var animationActivated:Bool
    @State private var showSplash = false
    @State private var showSplashTilted = false
    @State private var showHearth = false
    @State private var opacity = 1
    
    var body: some View {
        VStack(spacing:20) {
            
            HStack {
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                    print("Back tapped")
                } label: {
                    Image(systemName: "arrowshape.turn.up.backward.fill")
                        .font(.title)
                        .foregroundColor(Color.init(hex: "6C63FF"))
                        .contentShape(Rectangle())
                    
                }
                .padding(.leading, 15)
                .padding(.top, 10)
                Spacer()
            }
            
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
            
            ZStack(alignment: .center) {
                Image(cardCore.imageName)
                    .resizable()
                    .frame(width: 250, height: 350)
                    .clipped()
                    .cornerRadius(12)
                
                
                
                
                //ForEach(0..<deckCore.cardsArray.count) { index in
                
                if deckCore.cardsArray.count >= 0 {
                    if flip == false {
                        //indexCard = deckCore.cardsArray.count
                        
                        ZStack {
                            Text(deckCore.cardsArray[indexCard].unwrappedWord)
                                .font(.custom("HelveticaNeue", size: 40))
                                .foregroundColor(.white)
                        }
                        
                        
                        
                    } else {
                        ZStack {
                            
                            Text(deckCore.cardsArray[indexCard].unwrappedDefinition)
                                .font(.custom("HelveticaNeue", size: 40))
                                .foregroundColor(.white)
                        }
                        
                        
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
            .padding(.top, 10)
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
                            indexCard -= 1
                        }
                        self.animationActivated = false
                        
                        //                                       self.showStrokeBorder = false
                        //                                       self.showHearth = false
                        //                                       self.showSplashTilted = false
                        //                                       self.showSplash = false
                        
                    case (-100)...(-1):
                        card.x = 0; card.degree = 0; card.y = 0
                    case let x where x < -100:
                        card.x  = -500; card.degree = -12
                        falseAnswer += 1
                        if  indexCard > 0 {
                            indexCard -= 1
                            
                        }
                        self.animationActivated = false
                        
                        
                    default:
                        card.x = 0; card.y = 0
                        // self.animationActivated = false
                        
                    }
                    
                }
                print("Correct:\(correctAnswer)")
                print("False: \(falseAnswer)")
                print("animationActivated is \(animationActivated)")
                
                
            }
            )
            
            
            
            Text("\(indexCard+1) of \(deckCore.cardsArray.count)")
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
            
                
                Button {
                    //some code
                    print("Like button tapped")
                    self.animationActivated.toggle()
                    print("Animation is \(animationActivated) in Like button")
                    //print("Animation is \(s) in Like button")
                } label: {
                    Image(systemName: "suit.heart")
                        .resizable()
                        .frame(width: 45, height: 45)
//                        .foregroundColor(animationActivated ? .pink : Color.init(hex: "6C63FF"))
                        .foregroundColor(Color.init(hex: "6C63FF"))
                    
                
                    ZStack {
                        if animationActivated == true {
                           HeartView()
                        }
                    }
            }
            
            
            
            
            
            
            //            Image(systemName: "suit.heart")
            //                .frame(width: 26, height: 26)
            //                .foregroundColor(.black)
            //                //.offset(x: 50, y: 340)
            //                .onTapGesture {
            //                    self.showLikeButton.toggle()
            //                    animation(likeTapped: showLikeButton)
            //                }
            
            
            
            
            
        }
        .navigationBarHidden(true)
        .padding(.top, 10)
    }

}

//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView(card: DeckCore.cardsArray[0])
//                    .previewLayout(.sizeThatFits)
//    }
//}
