//
//  EditView.swift
//  FlashPad
//
//  Created by Emre Yasa on 9/2/21.
//

import SwiftUI

struct EditView: View {
    
    @State var flipped = false
    @State var flip = false
    @State var rightArrowTapped = false
    //@State var cardCore: CardCore
    @State var card: Card
    @StateObject var deckCore:DeckCore
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Environment(\.managedObjectContext) private var viewContext
    @State var indexCard = UserDefaults.standard.integer(forKey: "indexCard")
   // @AppStorage("indexCard") var indexCard = 0
    //@State var indexCard = 0
    @StateObject var likedCore:LikedCore
    // @State var correctAnswer = 0
    @State private var rotateCheckMark = 30
    @State private var checkMarkValue = -60
    
    @State private var showCircle = 0
    
    @State private var isShowingCheckMark = false
    @Environment(\.colorScheme) var colorScheme


    
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                VStack(alignment: .center){
                HStack(spacing: 15) {
                    
                    Button {
                        withAnimation {
                            flip = false
                            print("Index in Editiew: \(indexCard)")
                        }
                    } label: {
                        Text("Word")
                            .font(.custom("Chalkduster", size: 24))
                            .frame(width:  geo.size.width * 0.35, height: geo.size.height * 0.07)
                            .background(!flip ? Color.init(hex: "164430") : .gray)
                            .clipShape(Capsule())
                            .foregroundColor(.white)
                            .navigationBarItems(trailing: NavigationLink(destination: StudyScreenView(deckCore: deckCore, card: card)) {
                                Text("Study")
                                    .font(.custom("Chalkduster", size: 24))
                                //.foregroundColor(Color.init(hex: "B74278"))
                                    .frame(width:  geo.size.width * 0.35, height: geo.size.height * 0.06)                   .background(RadialGradient(gradient: Gradient(colors: [Color.init(hex: "B74278"), Color.init(hex: "164430")]),  center: .center, startRadius: 5, endRadius: 120))
                                    .clipShape(Capsule())
                                    .foregroundColor(.white)
                                
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
                            .font(.custom("Chalkduster", size: 24))
                            .frame(width:  geo.size.width * 0.35, height: geo.size.height * 0.07)
                            .background(flip ? Color.init(hex: "164430") : .gray)
                            .clipShape(Capsule())
                            .foregroundColor(.white)
                    }
                }
                
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
                
//                RoundedRectangle(cornerRadius: 10)
//                    .fill(LinearGradient(gradient: Gradient(colors: [Color.init(hex: "164430"), Color.init(hex: "c8d4f5")]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    Image("bbS")
                        .resizable()
                    .frame(width: geo.size.width * 0.65, height: geo.size.height * 0.5)
                    .clipped()
                    .cornerRadius(12)
                    .shadow(color: Color(UIColor(.black)), radius: 10, x: 5, y: 5)
                    .overlay(
                        VStack( spacing: 5) {
                        if deckCore.cardsArray.count > 0 {
                            if flip == false {
                                if rightArrowTapped == true {
                                    Text("")
                                } else {
                                    Text(deckCore.cardsArray[indexCard].unwrappedWord)
                                        .font(.custom("Chalkduster", size: 40))
                                        .foregroundColor(.white)
                                        .overlay(Image(systemName: "minus.circle.fill")
                                                    .font(.title)
                                                    .foregroundColor(Color(.systemGray))
                                                    .offset(x: UIScreen.main.bounds.minX - geo.size.width * 0.32, y: UIScreen.main.bounds.minY - geo.size.height * 0.25)
                                                    .onTapGesture{
                                            print("idx card; \(indexCard)")
                                            alertViewDeleteCard(at: IndexSet.init(integer: indexCard))
                                        })
                                }
                            } else {
                                Text(deckCore.cardsArray[indexCard].unwrappedDefinition)
                                    .font(.custom("Chalkduster", size: 40))
                                    .foregroundColor(.white)
                                    .overlay(Image(systemName: "minus.circle.fill")
                                                .font(.custom("Chalkduster", size: 40))
                                                .foregroundColor(Color(.systemGray))
                                                .offset(x: UIScreen.main.bounds.minX - geo.size.width * 0.32, y: UIScreen.main.bounds.minY - geo.size.height * 0.25)

                                                .onTapGesture{
                                        
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
                                        .font(.custom("Chalkduster", size: 40))
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
                                        .font(.custom("Chalkduster", size: 40))
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
                            .foregroundColor(colorScheme == .dark ? Color(.systemGreen) : Color.init(hex: "164430"))
                    }
                    
                    Button {
                        
                        withAnimation{
                            isShowingCheckMark.toggle()
                        }
                        
                        addCard()
                        
                    } label: {
                        Text("Add Card")
                            .font(.custom("Chalkduster", size: 24))
                            .frame(width:  150, height: geo.size.height * 0.07)
                            .background(RadialGradient(gradient: Gradient(colors: [Color.init(hex: "164430"), Color.init(hex: "164430")]),  center: .center, startRadius: 5, endRadius: 120))
                            .clipShape(Capsule())
                            .foregroundColor(.white)
                            .overlay(Capsule().stroke(LinearGradient(gradient: Gradient(colors: [Color.init(hex: "164430"), Color.init(hex: "B74278")]), startPoint: .leading, endPoint: .trailing), lineWidth: 5))
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
                            .foregroundColor(colorScheme == .dark ? Color(.systemGreen) : Color.init(hex: "164430"))
                    
                    }
                }
                

            }
                .padding(.leading, geo.size.width * 0.3)
                .padding(.top, geo.size.height * 0.01)
                .frame(width:geo.size.width * 0.7, height:  geo.size.height * 0.97, alignment: .center)
        }
            if isShowingCheckMark {
                ZStack {
                Circle()
                    .frame(width: 110, height: 110, alignment: .center)
                    .foregroundColor(Color(.white))
                    .opacity(0.5)
                    .scaleEffect(CGFloat(showCircle))
                    .animation(Animation.interpolatingSpring(stiffness: 170, damping: 15).delay(0.5))
                    .transition(.asymmetric(insertion: .opacity, removal: .scale))

                    

                    
                    Image(systemName: "checkmark")
                        .foregroundColor(Color.init(hex: "067238"))
                        .font(.system(size: 60))
                        .rotationEffect(.degrees(Double(rotateCheckMark)))
                        .clipShape(Rectangle().offset(x: CGFloat(checkMarkValue)))
                        .animation(Animation.interpolatingSpring(stiffness: 170, damping: 15).delay(0.75))
                        .transition(.asymmetric(insertion: .opacity, removal: .scale))
                }
                .onAppear(perform: setDismissTimer)
            }

            
                   
            
        }
        //.navigationBarHidden(true)
        //navigationBarHidden work on real device iPhone x, but not in simulator for now keep it in active.
        
    }
    func setDismissTimer() {
      let timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { timer in
        withAnimation(.easeInOut(duration: 2)) {
          self.isShowingCheckMark = false
        }
        timer.invalidate()
      }
      RunLoop.current.add(timer, forMode:RunLoop.Mode.default)
        card.word = ""
        card.definition = ""
    }
    
    private func addCard() {
        
        let newCard = CardCore(context: viewContext)
        newCard.word = card.word
        newCard.definition = card.definition
        newCard.imageName = "bbS"
        //        guard cardsArrPersistent != nil && cardsArrPersistent.count > 0 else {
        //            return
        //        }
        //cardsArrPersistent.last?.word = newCard.word
        //cardsArrPersistent.last?.definition = newCard.definition
        //indexCard += 1
        deckCore.addToCards(newCard)
        PersistenceController.shared.saveContext()
        showCircle = 1
        rotateCheckMark = 0
        checkMarkValue = 0
            
        //UserDefaults.standard.set(self.indexOfCard, forKey: "indexOfCard")
        //print("\(Int(newCard.numOfCard))")
        //        for card in deckCore.cardsArray {
        //            print(card.word)
        //            print(card.definition)
        //        }
        
        
        
    }
    
    private func deleteCard(at offsets: IndexSet) {
        withAnimation {
            
            for index in offsets {
                let card = deckCore.cardsArray[index]
                if indexCard == 0 {
                    viewContext.delete(card)
                    PersistenceController.shared.saveContext()
                } else {
                    indexCard -= 1
                    viewContext.delete(card)
                    PersistenceController.shared.saveContext()
                }
                
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




//struct EditView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditView()
//    }
//}
