//
//  HeartView.swift
//  FlashPad
//
//  Created by Emre Yasa on 9/3/21.
//

import SwiftUI

struct HeartView: View {
    //@Binding var isTapped:Bool
    @State var startAnimation = false
    @State var bgAnimaton = false
    @Binding var resetBg:Bool
    @State var fireworkAnimation = false
    @State var animationEnded = false
    

    //To avoid Taps during animation..
    @State var tapCompleted = false
    //@State var resetBg = false
   // @Binding var cardSwiped: Bool
    @StateObject var deckCore:DeckCore
    @Binding var indexCard:Int

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) private var viewContext
    
//    @FetchRequest(
//        entity: LikedCore.entity(),
//        sortDescriptors: []
//    ) var likedArrPersistent: FetchedResults<LikedCore>
   // @StateObject var likedCore:LikedCore

    var body: some View {
        
        Image(systemName: resetBg ? "suit.heart.fill" : "suit.heart")
            .font(.system(size: 45))
            .foregroundColor(resetBg ? .pink : .gray)
            .scaleEffect(startAnimation && !resetBg ? 0 : 1)
            .background(
                ZStack {
                //pass variable to change to
                CustomShapeLike(radius: resetBg ? 29 : 0)
                    .fill(Color.purple)
                    .clipShape(Circle())
                    .frame(width: 50, height: 50)
                    .scaleEffect(bgAnimaton ? 2.2 : 0)
                    .opacity(resetBg ? 1:0)
                
                ZStack {
                    //random colors
                    let colors:[Color] = [.red, .purple, .green, .yellow, .pink]
                    
                    ForEach(1...6, id: \.self) { index in
                        Circle()
                            .fill(colors.randomElement()!)
                            .frame(width: 12, height: 12)
                            .offset(x: fireworkAnimation ? 80:40)
                            .rotationEffect(.init(degrees: Double(index) * 60))
                    }
                    
                    ForEach(1...6, id: \.self) { index in
                        Circle()
                            .fill(colors.randomElement()!)
                            .frame(width: 8, height: 8)
                            .offset(x: fireworkAnimation ? 64:24)
                            .rotationEffect(.init(degrees: Double(index) * 60))
                            .rotationEffect(.init(degrees: -45))
                    }
                }
                .opacity(resetBg ? 1 : 0)
                .opacity(animationEnded ? 0 : 1)
                .opacity(!fireworkAnimation ? 0 : 1)
            }
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .contentShape(Rectangle())
            .onTapGesture {
                
//                if tapCompleted {
//                    //Resetting back
//                    startAnimation = false
//                    bgAnimaton = false
//                    resetBg = false
//                    fireworkAnimation = false
//                    animationEnded = false
//                    tapCompleted = false
//                    //isTapped = false
//                    return
//                }
//                if startAnimation {
////                    Image(systemName:"suit.heart")
////                        .font(.system(size: 45))
////                        .foregroundColor( .gray)
//                    return
//
//                }
                let likedCard = LikedCore(context: viewContext)
                //likedCard.id = Int16(indexCard)
                likedCard.word = deckCore.cardsArray[indexCard].unwrappedWord
                likedCard.definition = deckCore.cardsArray[indexCard].unwrappedDefinition
                likedCard.imageName = "cardBackg"
                PersistenceController.shared.saveContext()
//                for likedWord in likedCore.likedArray {
//                    print("likedWord is \(likedWord)")
//                }
                
                //isTapped = true
                withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)) {
                    startAnimation = true
                }
                
                //Sequence animation
                //Chain animation
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    withAnimation(.interactiveSpring(response: 0.4, dampingFraction: 0.5, blendDuration: 0.5)) {
                        bgAnimaton = true
                    }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)) {
                        resetBg = true
                    }
                    
                    //Fireworks..
                    withAnimation(.spring()) {
                        fireworkAnimation = true
                    }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    withAnimation(.easeOut(duration: 0.4)) {
                        animationEnded.toggle()
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        tapCompleted = true
                        fireworkAnimation = false
                    }
                }

            }
        

    }
}

//Custom shape for resetting center
struct CustomShapeLike: Shape {
    var radius: CGFloat
    
    var animatableData: CGFloat {
        get { return radius}
        set { radius = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            
            //adding center to circle
            let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
            path.move(to: center)
            path.addArc(center: center, radius: radius, startAngle: .zero, endAngle: .init(degrees: 360), clockwise: false)
        }
    }
}

//struct HeartView_Previews: PreviewProvider {
//    static var previews: some View {
//        HeartView()
//    }
//}
