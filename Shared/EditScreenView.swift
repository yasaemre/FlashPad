//
//  EditScreenView.swift
//  FlashPad
//
//  Created by Emre Yasa on 8/3/21.
//

import SwiftUI

struct EditScreenView: View {
    
    @State var flipped = false
    @State var flip = false
    @State var rightArrowTapped = false

    @State var card: Card
    @StateObject var deckCore:DeckCore
   
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Environment(\.managedObjectContext) private var viewContext
    @State var indexCard = UserDefaults.standard.integer(forKey: "indexCard")
    
    @GestureState private var dragOffset = CGSize.zero
    

    var body: some View {
       // NavigationView {
        ZStack(alignment: .topLeading) {
           // Color(.systemBackground).opacity(0.2).edgesIgnoringSafeArea(.all)
            VStack(alignment: .center)  {
//                   HStack() {
//
//                       Button {
//                           self.presentationMode.wrappedValue.dismiss()
//                           print("Back tapped")
//                       } label: {
//                           Image(systemName: "arrowshape.turn.up.backward.fill")
//                               .font(.title)
//                               .foregroundColor(Color.init(hex: "6C63FF"))
//                               .contentShape(Rectangle())
//
//                       }
//                       .padding(.leading, 15)
////                       NavigationLink(destination: TabBarView().navigationBarHidden(true)) {
////                           Image(systemName: "arrowshape.turn.up.backward.fill")
////                               .font(.title)
////                               .foregroundColor(Color.init(hex: "6C63FF"))
////                               .contentShape(Rectangle())
////                       }
////                       .padding(.leading, 15)
////                       Image(systemName: "arrowshape.turn.up.backward.fill")
////                           .font(.title)
////                           .foregroundColor(Color.init(hex: "6C63FF"))
////                           .contentShape(Rectangle())
////                           .onTapGesture {
////                               self.presentationMode.wrappedValue.dismiss()
////                           }
//                       
////                       Group {
////                           Image(systemName: "arrowshape.turn.up.backward.fill")
////                               .font(.title)
////                               .foregroundColor(Color.init(hex: "6C63FF"))
////                               .contentShape(Rectangle())
////                       }
////                       .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
////                            if(value.startLocation.x < 20 &&
////                                       value.translation.width > 100) {
////                                self.presentationMode.wrappedValue.dismiss()
////                            }
////                       }))
//                       Spacer()
//                       Button {
//                           withAnimation {
//
//                           }
//                       } label: {
//                           Text("Study")
//                               .font(.title)
//                               .frame(width: 130, height: 40)
//                               .clipShape(Capsule())
//                               .foregroundColor(Color.init(hex: "6C63FF"))
//
//
//                       }
////                       .padding(.trailing, 15)
////                       NavigationLink(destination: StudyScreenView()) {
////                           Text("Study")
////                               .font(.title)
////                               .frame(width: 130, height: 40)
////                               .clipShape(Capsule())
////                               .foregroundColor(Color.init(hex: "6C63FF"))
////                       }
//
//                   }
//                   .padding(.top,1)
                   
                   HStack(spacing: 15) {
                       
                       Button {
                           withAnimation {
                               flip = false
                               //addCard()
                               //saveContext()

                           }
                       } label: {
                           Text("Word")
                               .font(.title)
                               .frame(width: 130, height: 40)
                               .background(!flip ? Color.init(hex: "6C63FF") : .gray)
                               .clipShape(Capsule())
                               .foregroundColor(.white)
                               .navigationBarItems(trailing: NavigationLink(destination: StudyScreenView(deckCore: deckCore, card: card)) {
                                       Text("Study")
                                           .font(.title)
                                           .foregroundColor(Color.init(hex: "6C63FF"))
                                           .padding(.trailing, 1)
                                   }
                               )
                           

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
                   .padding(.top, 10)

                if flipped == true {

                    TextField("Enter a word", text: $card.word)
                        .padding(.top, 1)
//                        .padding(.leading, 40)
//                        .padding(.trailing, 40)
                        .frame(width: 250, height: 75, alignment: .center)
                        .textFieldStyle(.roundedBorder)
                        .modifier(TextFieldClearButton(text: $card.word))
                } else {
                    TextField("Enter a definition", text: $card.definition)
                        .padding(.top, 1)
//                        .padding(.leading, 40)
//                        .padding(.trailing, 40)
                        .frame(width: 250, height: 75, alignment: .center)
                        .textFieldStyle(.roundedBorder)
                        .modifier(TextFieldClearButton(text: $card.definition))
                }
                
//                   VStack {
//                        if flipped == true {
//                            CardView(card: card, flip: $flip, rightArrowTapped: $rightArrowTapped, numOfCard: $indexOfCard, deckCore: deckCore)
//                       } else {
//                           CardView(card: card, flip: $flip, rightArrowTapped: $rightArrowTapped, numOfCard: $indexOfCard, deckCore: deckCore)
//                       }
//                   }
//                   .modifier(FlipEffect(flipped: $flipped, angle: flip ? 0 : 180))
//                   .padding(.top, 15)
                RoundedRectangle(cornerRadius: 10)
                    .fill(LinearGradient(gradient: Gradient(colors: [Color.init(hex: "6C63FF"), Color.init(hex: "c8d4f5")]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 250, height: 350)
                    .shadow(color: Color(UIColor(.black)), radius: 10, x: 5, y: 5)
                    .overlay(
                        VStack(alignment:.center, spacing: 5) {
                        if deckCore.cardsArray.count > 0 {
                            if flip == false {
                                if rightArrowTapped == true {
                                    Text("")
                                } else {
                                    Text(deckCore.cardsArray[indexCard].unwrappedWord)
                                        .font(.custom("HelveticaNeue", size: 40))
                                        .foregroundColor(.white)
                                        .overlay(Image(systemName: "minus.circle.fill")
                                                    .font(.title)
                                                    .foregroundColor(Color(.systemGray))
                                                    .offset(x: -123, y: -175)
                                                    .onTapGesture{
                                            //deleteDeck(at: IndexSet.init(integer: index))
                                            alertViewDeleteCard(at: IndexSet.init(integer: indexCard))
                                        })
                                }
                            } else {
//                                if rightArrowTapped == true {
//                                    Text("")
//                                } else {
                                Text(deckCore.cardsArray[indexCard].unwrappedDefinition)
                                        .font(.custom("HelveticaNeue", size: 40))
                                        .foregroundColor(.white)
                                        .overlay(Image(systemName: "minus.circle.fill")
                                                    .font(.title)
                                                    .foregroundColor(Color(.systemGray))
                                                    .offset(x: -123, y: -175)
                                                  .onTapGesture{
                                            //deleteDeck(at: IndexSet.init(integer: index))
                                            alertViewDeleteCard(at: IndexSet.init(integer: indexCard))
                                        })
                                //}
                            }
                        } else {
                            ForEach(0..<deckCore.cardsArray.count, id:\.self) { index in
                                if flip == false {
    //                                if rightArrowTapped == true {
    //                                    Text("")
    //                                } else {
                                        Text(deckCore.cardsArray[index].unwrappedWord)
                                            .font(.custom("HelveticaNeue", size: 40))
                                            .foregroundColor(.white)
                                            .overlay(Image(systemName: "minus.circle.fill")
                                                        .font(.title)
                                                        .foregroundColor(Color(.systemGray))
                                                        .offset(x: -123, y: -175)
                                                       .onTapGesture{
                                                //deleteDeck(at: IndexSet.init(integer: index))
                                                alertViewDeleteCard(at: IndexSet.init(integer: index))
                                            })
                                    
                                            
                                    //}
                                } else {
    //                                if rightArrowTapped == true {
    //                                    Text("")
    //                                } else {
                                    Text(deckCore.cardsArray[index].unwrappedDefinition)
                                            .font(.custom("HelveticaNeue", size: 40))
                                            .foregroundColor(.white)
                                            .overlay(Image(systemName: "minus.circle.fill")
                                                        .font(.title)
                                                        .foregroundColor(Color(.systemGray))
                                                        .offset(x: -123, y: -175)
                                                       .onTapGesture{
                                                //deleteDeck(at: IndexSet.init(integer: index))
                                                alertViewDeleteCard(at: IndexSet.init(integer: index))
                                            })
                                    //}
                                }
                                
                                
                        
                                
                            }
                        }
                            
                        
                    }
                            
                    )
                    .modifier(FlipEffect(flipped: $flipped, angle: flip ? 0 : 180))
                    .padding(.top, 5)


               
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
            .accentColor(Color.init(hex: "6C63FF"))
            .onAppear {
                UINavigationBar.appearance().titleTextAttributes = [
                .font : UIFont(name: "HelveticaNeue-Thin", size: 2)!]
            }

            
            

        //}

        }
        .navigationBarHidden(true)

    }
  
    
    private func addCard() {
        
        let newCard = CardCore(context: viewContext)
        newCard.word = card.word
        newCard.definition = card.definition
        newCard.imageName = "cardBackg"
//        guard cardsArrPersistent != nil && cardsArrPersistent.count > 0 else {
//            return
//        }
        //cardsArrPersistent.last?.word = newCard.word
        //cardsArrPersistent.last?.definition = newCard.definition
        //indexCard += 1
        deckCore.addToCards(newCard)
        PersistenceController.shared.saveContext()
       
        //UserDefaults.standard.set(self.indexOfCard, forKey: "indexOfCard")
        //print("\(Int(newCard.numOfCard))")
//        for card in deckCore.cardsArray {
//            print(card.word)
//            print(card.definition)
//        }
        
        
        
    }
    
    //Use with tap gesture or delete button
    private func deleteCard(at offsets: IndexSet) {
        withAnimation {

            for index in offsets {
                let card = deckCore.cardsArray[index]
                viewContext.delete(card)
                PersistenceController.shared.saveContext()
            }
        }
    }
    
    func alertViewDeleteCard(at index: IndexSet) {
        
        
        let alert = UIAlertController(title: "Delete Card", message: "Do you want to delete this card?", preferredStyle: .alert)
 
        
        let delete = UIAlertAction(title: "Delete", style: .default) { (_) in
            //do your stuff..
            
            
            //deckVM.decks.append(Deck( deckName: deck.deckName, numberOfCardsInDeck: deck.numberOfCardsInDeck, deckCreatedAt: deck.deckCreatedAt))
            deleteCard(at: index)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive) { _ in
            //same
        }
        
        alert.addAction(cancel)
        alert.addAction(delete)
        
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: {
            //code
            
        })
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

//struct EditScreenView_Previews: PreviewProvider {
//    static var previews: some View {
//        let viewContext = PersistenceController.preview.container.viewContext
//        let newDeck = DeckCore(context: viewContext)
//        newDeck.deckName = "Prev1"
//        
//        let card1 = CardCore(context: viewContext)
//        card1.word = "Jobs"
//        
//        let card2 = CardCore(context: viewContext)
//        card2.word = "Jobs"
//        
//        newDeck.addToCards(card1)
//        newDeck.addToCards(card2)
//        return EditScreenView(deckCore: newDeck)
//            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
