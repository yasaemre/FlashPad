//
//  CardView.swift
//  
//
//  Created by Emre Yasa on 8/31/21.
//

import SwiftUI
import Foundation

struct CardView: View {
    @State var cardCore: CardCore
    @State var card: Card

    @Binding var flipped:Bool
    @Binding var flip: Bool
    // @State var card: Card
    // MARK: - Drawing Constant
    @StateObject var deckCore:DeckCore
   
    @Binding var indexCard:Int
    //@State var indexCard = UserDefaults.standard.integer(forKey: "indexCard")
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) private var viewContext
    @State var correctRate = 0.0

    @Binding var correctAnswer:Int
    @Binding var falseAnswer:Int
//    @State var isTapped = false
//    @State var startAnimation = false
//    @State var bgAnimaton = false
   @Binding var resetBg:Bool
    //@StateObject var likedCore: LikedCore
    //@State var fireworkAnimation = false
    //@Binding var isTapped:Bool
    //@State var correctA = 0
    //@AppStorage("correctA") var correctA = 0.0
    @Binding var correctA:Double
    //@State var correctA = UserDefaults.standard.double(forKey: "correctA")
    @Environment(\.colorScheme) var colorScheme


    //To avoid Taps during animation..
    
    
    
    var body: some View {
        GeometryReader { geo in
            VStack() {
                
                HStack {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                        print("Back tapped")
                    } label: {
                        Image(systemName: "arrowshape.turn.up.backward")
                            .font(.title)
                            .foregroundColor(colorScheme == .dark ? Color(.systemGreen) : Color.init(hex: "164430"))
                            .contentShape(Rectangle())
                        
                    }
                    Spacer()
                }
                .padding(.leading, 15)
                .padding(.top, UIScreen.main.bounds.height * 0.02)
                .padding(.bottom, UIScreen.main.bounds.height * 0.03)

                
                //Spacer()
                
                
                HStack(spacing: 25) {
                    
                    Button {
                        withAnimation {
                            flip = false
                        }
                    } label: {
                        Text("Word")
                            .font(.custom("Chalkduster", size: 24))
                            .frame(width:  geo.size.width * 0.35, height: geo.size.height * 0.07)
                            .background(!flip ? Color.init(hex: "164430") : .gray)
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
                            .font(.custom("Chalkduster", size: 24))
                            .frame(width:  geo.size.width * 0.35, height: geo.size.height * 0.07)
                            .background(flip ? Color.init(hex: "164430") : .gray)
                            .clipShape(Capsule())
                            .foregroundColor(.white)
                    }
                }
                .padding(.bottom, UIScreen.main.bounds.height * 0.05)

                
                ZStack(alignment: .center) {
                    Image("bbS")
                        .resizable()
                        .frame(width: geo.size.width * 0.7, height: geo.size.height * 0.50)
                        .clipped()
                        .cornerRadius(12)

                    //ForEach(0..<deckCore.cardsArray.count) { index in
                    
                    if deckCore.cardsArray.count >= 0 {
                        if flip == false {
                            
                            ZStack {
                                Text(deckCore.cardsArray[indexCard].unwrappedWord)
                                    .font(.custom("Chalkduster", size: 40))
                                    .foregroundColor(.white)
                            }
                            
                            
                            
                        } else {
                            ZStack {
                                
                                Text(deckCore.cardsArray[indexCard].unwrappedDefinition)
                                    .font(.custom("Chalkduster", size: 40))
                                    .foregroundColor(.white)
                            }
                            
                            
                        }
                    }
                    HStack {
                        Image("correct")
                            .resizable()
                            .font(.custom("Chalkduster", size: 22))
                            .aspectRatio(contentMode: .fit)
                            .frame(width:75,height: 75)
                            .offset(x: 60, y: -140)
                            .opacity(Double(card.x/10 - 1))
                        
                        Spacer()
                        Image("false")
                            .resizable()
                            .font(.custom("Chalkduster", size: 22))
                            .aspectRatio(contentMode: .fit)
                            .frame(width:75,height: 75)
                            .offset(x: -60, y: -140)
                            .opacity(Double(card.x/10 * -1 - 1))
                    }
                    
                }
                .modifier(FlipEffect(flipped: $flipped, angle: flip ? 0 : 180))
                .padding(.top, 10)
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
                                    correctA += 1
                                    if  indexCard > 0 {
                                        indexCard -= 1
                                    }
                                    // self.isTapped = true
                                    self.resetBg = false
                                    
                                case (-100)...(-1):
                                    card.x = 0; card.degree = 0; card.y = 0
                                case let x where x < -100:
                                    card.x  = -500; card.degree = -12
                                    falseAnswer += 1
                                    if  indexCard > 0 {
                                        indexCard -= 1
                                        
                                    }
                                    // self.isTapped = true
                                    self.resetBg = false
                                    
                                    
                                default:
                                    card.x = 0; card.y = 0
                                    
                                }
                                
                                
                                
                            }
                            
                            
                            
                        }
                )
                
                
                
                Text("\(indexCard+1) of \(deckCore.cardsArray.count)")
                    .font(.title2)
                    .padding(.top, 10)
                
                HStack(spacing: 40){
                    
                    Text("Correct: \(correctAnswer)")
                        .font(.custom("Chalkduster", size: 22))
                        .frame(width:  geo.size.width * 0.4, height: geo.size.height * 0.07)
                        .background(Color.init(hex: "164430"))
                        .clipShape(Capsule())
                        .foregroundColor(.white)
                    
                    
                    
                    Text("False: \(falseAnswer)")
                        .font(.custom("Chalkduster", size: 22))
                        .frame(width:  geo.size.width * 0.4, height: geo.size.height * 0.07)
                        .foregroundColor(Color.init(hex: "164430"))
                        .background(Color(.lightGray))
                        .clipShape(Capsule())
                }
                
                
                Button {
                    //some code
                    //  let newLikedCard = PersonCore(context: viewContext)
                    
                    print("Like button tapped")
                } label: {
                    
                    HeartView(resetBg: $resetBg, deckCore:deckCore, indexCard: $indexCard)
                    
                }
                .navigationBarHidden(true)
            }
           //.padding(.top, geo.size.height * 0.02)
           .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)


        }
        
    }
}

