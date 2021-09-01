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
    
    var body: some View {
        VStack {
            
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
                    .onAppear {
                        print("Image appear\(indexCard)")
                    }
                    
                
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
                    //else {
                       // ForEach(0..<deckCore.cardsArray.count, id:\.self) { index in
//                            if flip == false {
//                                //                                if rightArrowTapped == true {
//                                //                                    Text("")
//                                //                                } else {
//                                ZStack {
//
//                                    Text(deckCore.cardsArray[index].unwrappedWord)
//                                        .font(.custom("HelveticaNeue", size: 40))
//                                        .foregroundColor(.white)
//                                }
//
//                                //}
//                            } else {
//                                //                                if rightArrowTapped == true {
//                                //                                    Text("")
//                                //                                } else {
//                                ZStack {
//                                    Text(deckCore.cardsArray[index].unwrappedDefinition)
//                                        .font(.custom("HelveticaNeue", size: 40))
//                                        .foregroundColor(.white)
//                                }
//
//                                //}
//                            }
                            
                            
                            
                            
                       // }
                    //}
                //}

                    
                

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
                       if  indexCard > 0 {
                           indexCard -= 1
                       }
                       // print("View tapped! \(indexCard ?? 0)")
                                   
                                       
                                   
                               
                           }
                   )
                   
            
            
            Text("\(indexCard+1) of \(deckCore.cardsArray.count)")
                .font(.title2)
                .padding(.top, 10)
            
            HStack(spacing: 30){
                Button {
                   
                } label: {
                    Image(systemName: "arrowshape.turn.up.backward")
                        .font(.largeTitle)
                        .foregroundColor(Color.init(hex: "6C63FF"))
                }
                Spacer()
                Button {
                    //
                    
                } label: {
                    Image(systemName: "arrowshape.turn.up.right")
                        .font(.largeTitle)
                        .foregroundColor(Color.init(hex: "6C63FF"))
                }
            }
            
            
        }
    }
    
}

//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView(card: DeckCore.cardsArray[0])
//                    .previewLayout(.sizeThatFits)
//    }
//}
