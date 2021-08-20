//
//  EditScreenView.swift
//  FlashPad
//
//  Created by Emre Yasa on 8/3/21.
//

import SwiftUI

struct EditScreenView: View {
    @StateObject var cardVM = CardViewModel()
    @State var flipped = false
    @State var flip = false
    @State var addCardTapped = false
    //@ObservedObject var card: Card
    @StateObject var card = Card()

   
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors:[]) var cardsArrPersistent: FetchedResults<CardCore>
    
    var body: some View {

        ZStack(alignment: .top) {
            Color(.systemBackground).opacity(0.2).edgesIgnoringSafeArea(.all)
            VStack(alignment: .center)  {
                   HStack() {

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
                       Spacer()
                       Button {
                           withAnimation {

                           }
                       } label: {
                           Text("Study")
                               .font(.title)
                               .frame(width: 130, height: 40)
                               .background(RadialGradient(gradient: Gradient(colors: [Color(UIColor.red), Color.init(hex: "c8d4f5")]),  center: .center, startRadius: 5, endRadius: 120))
                               .clipShape(Capsule())
                               .foregroundColor(.white)

                       }
                       .padding(.trailing, 15)

                   }
                   .padding(.top,1)
                   
                   HStack(spacing: 10) {
                       
                       Button {
                           withAnimation {
                               flip = false
                               //addCard()
                               saveContext()
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
                               //addCard()
                               saveContext()
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
                   .padding(.top, 50)

                if flipped == true {

                    TextField("Enter a word", text: $card.word)
                        .padding(.top, 10)
//                        .padding(.leading, 40)
//                        .padding(.trailing, 40)
                        .frame(width: 250, height: 75, alignment: .center)
                        .textFieldStyle(.roundedBorder)
                        .modifier(TextFieldClearButton(text: $card.word))
                } else {
                    TextField("Enter a definition", text: $card.definition)
                        .padding(.top, 10)
//                        .padding(.leading, 40)
//                        .padding(.trailing, 40)
                        .frame(width: 250, height: 75, alignment: .center)
                        .textFieldStyle(.roundedBorder)
                        .modifier(TextFieldClearButton(text: $card.definition))
                }
                
                   VStack {
                        if flipped == true {
                            CardView(card: card, flip: $flip, addCardTapped: $addCardTapped)
                       } else {
                           CardView(card: card, flip: $flip, addCardTapped: $addCardTapped)
                       }
                   }
                   .modifier(FlipEffect(flipped: $flipped, angle: flip ? 0 : 180))
                   .padding(.top, 15)

                Text("1 of \(cardsArrPersistent.count)")
                       .font(.title2)
                       .padding(.top, 10)
                

                   HStack(spacing: 30){
                       Button {
                           //
                       } label: {
                           Image(systemName: "arrowshape.turn.up.backward")
                               .font(.largeTitle)
                               .foregroundColor(Color.init(hex: "6C63FF"))
                       }

                       Button {
                           //
                           addCard()
                           
                       } label: {
                           Text("Add Card")
                               .font(.title)
                               .frame(width: 150, height: 60)
                               .background(RadialGradient(gradient: Gradient(colors: [Color.init(hex: "6C63FF"), Color.init(hex: "c8d4f5")]),  center: .center, startRadius: 5, endRadius: 120))
                               .clipShape(Capsule())
                               .foregroundColor(.white)
                               .overlay(Capsule().stroke(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.pink]), startPoint: .leading, endPoint: .trailing), lineWidth: 5))
                       }

                       Button {
                           //
                           card.word = ""
                           card.definition = ""
                       } label: {
                           Image(systemName: "arrowshape.turn.up.right")
                               .font(.largeTitle)
                               .foregroundColor(Color.init(hex: "6C63FF"))
                       }
                   }
                
//                if let cards = cardsArrPersistent, cardsArrPersistent.count > 0 {
//                    Text("\(cards[0].word ?? "No word") \(cards[0].definition ?? "No def.")")
//
//                }
               }
            
        }
        .navigationBarHidden(true)

    }
    private func saveContext() {
        
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let error = error as NSError
                fatalError("Unresolved Error: \(error)")
            }
        }
    }
    
    private func addCard() {

            let newCard = CardCore(context: viewContext)
            newCard.word = card.word
            newCard.definition = card.definition
        guard cardsArrPersistent != nil && cardsArrPersistent.count > 0 else {
            return
        }
        cardsArrPersistent.last?.word = newCard.word
        cardsArrPersistent.last?.definition = newCard.definition
        for card in cardsArrPersistent {
            print(card.word)
            print(card.definition)
        }
        addCardTapped.toggle()
        saveContext()
        
    }

}

struct TextFieldClearButton: ViewModifier {
    @Binding var text: String
    
    func body(content: Content) -> some View {
        HStack {
            content
            
            if !text.isEmpty {
                Button(
                    action: { self.text = "" },
                    label: {
                        Image(systemName: "delete.left")
                            .foregroundColor(Color(UIColor.opaqueSeparator))
                    }
                )
            }
        }
    }
}

struct FlipEffect: GeometryEffect {

    @Binding var flipped:Bool
    var angle:Double

    var animatableData: Double {
        get { angle }
        set { angle = newValue }
    }

    func effectValue(size: CGSize) -> ProjectionTransform {
        DispatchQueue.main.async {
            flipped = angle >= 90 && angle < 270
        }
        let newAngle = flipped ? -180 + angle : angle

        let angleInRadians = CGFloat(Angle(degrees: newAngle).radians)

        var transform3d = CATransform3DIdentity
        transform3d.m34 = -1/max(size.width, size.height)
        transform3d = CATransform3DRotate(transform3d, angleInRadians, 0, 1, 0)
        transform3d = CATransform3DTranslate(transform3d, -size.width / 2, -size.height/2, 0)
        let affineTransform = ProjectionTransform(CGAffineTransform(translationX: size.width / 2, y: size.height / 2))


        return ProjectionTransform(transform3d).concatenating(affineTransform)
    }
}

struct EditScreenView_Previews: PreviewProvider {
    static var previews: some View {
        EditScreenView()
    }
}
