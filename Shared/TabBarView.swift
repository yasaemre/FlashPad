//
//  TabBarView.swift
//  FlashPad
//
//  Created by Emre Yasa on 7/2/21.
//

import SwiftUI

struct TabBarView: View {
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    @State var selectedTab = "home"
    @State var xAxis:CGFloat = 0
    @Namespace var animation
    
    @State var customAlert = false
    @State var HUD = false
    //@State var nameOfDeck = ""
    
    @State var dark = false
    @State var show = false
        
    @Environment(\.colorScheme) var colorScheme
    @State var deck = Deck()
    @StateObject var deckVM = DeckViewModel()
    let columns = Array(repeating: GridItem(.flexible(), spacing:25), count: 2)
    
    @State private var navBarHidden = false
   // @State var indexCard = UserDefaults.standard.integer(forKey: "indexCard")
    @Environment(\.managedObjectContext) private var viewContext

    
    @FetchRequest(
           sortDescriptors: [NSSortDescriptor(keyPath: \DeckCore.deckName, ascending: true)],
           animation: .default)
       private var decksArrPersistent: FetchedResults<DeckCore>
    
    @State private var deckName = ""
    @State private var deckCreatedAt = ""
    @State private var numOfCardsInDeck = 0
    @State private var currentTotalNumOfCards = 0


  @State private var indexOfCard = UserDefaults.standard.integer(forKey: "indexOfCard")
   // var editScreenView = EditScreenView()

    var body: some View {
       // ZStack {
            ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
                
                TabView(selection: $selectedTab) {
                    Color(UIColor.systemBackground)
                        .ignoresSafeArea(.all, edges: .all)
                    ZStack {
                        //--
//                        Color(UIColor.systemBackground)
//                            .ignoresSafeArea(.all, edges: .all)
                        
                        //custom back button works here
                        NavigationView {
                        ScrollView {
                            //Tabs With Pages...
                            //--
                            LazyVGrid(columns: columns, spacing: 30, content: {
                                ForEach(decksArrPersistent, id: \.self) { deck in
                                    NavigationLink(destination: EditScreenView(deckCore: deck)){
                                        ZStack {
                                            Image("cardBackg")
                                                .resizable()
                                                .frame(width:150, height: 200)
                                                .cornerRadius(16)

                                            VStack(spacing: 10) {
                                                Text(deck.unwrappedDeckName)
                                                    .font(.title).bold()
                                                    .foregroundColor(.white)

                                                Text("\(deck.numberOfCardsInDeck) cards")
                                                    .font(.title2)
                                                    .foregroundColor(.white)
                                                    .onAppear {
                                                        deck.numberOfCardsInDeck = Int16(deck.cardsArray.count)
                                                    }
                                                Text("created on \n\(deck.deckCreatedAt ?? "")")
                                                    .font(.system(size: 12.0))
                                                    .foregroundColor(.white)
                                            }
                                            .frame(width:150, height: 200)
                                            
                                        }
                                        

                                    }
                                }
                            })
                                .toolbar {
                                    //Top custom Navigation bar
                                    ToolbarItemGroup(placement: .navigationBarLeading) {
                                        VStack(alignment: .center) {
                                            HStack(alignment: .center, spacing: 105) {

                                                Button(action: {
                                                    print("Slide in menu tapped")
                                                    self.show.toggle()
                                                }) {
                                                    Image(systemName: "list.bullet")
                                                }
                                                .symbolRenderingMode(.hierarchical)
                                                .font(.system(size: 24))
                                                .foregroundColor(Color.init(hex: "6C63FF"))
                                                .padding(.leading, 10)

                                                Button(action: {
                                                    print("iCloud button tapped")
                                                }) {
                                                    Image(systemName: "icloud.and.arrow.down")
                                                }
                                                //.frame(width: 60, height: 60, alignment: .center)
                                                .symbolRenderingMode(.palette)
                                                .font(.system(size: 24))
                                                .foregroundStyle(Color.init(hex: "6C63FF"), (colorScheme == .dark ? Color.white : Color.black))
                                                //.padding(100)
                                                Button(action: {
                                                    print("Profile button tapped")
                                                }) {
                                                    Image("profilePhoto")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: 50, height: 70)
                                                }
                                                .padding(.trailing, 10)
                                            }

                                        }
                                        .padding()

                                    }
                                }
                                .ignoresSafeArea(.all, edges: .all)
                                .foregroundColor(.primary)
                        }
                    }
                        VStack {
                            Spacer()
                            HStack {
                                
                                Button(action: {
                                    print("Deck added")
                                    withAnimation {
                                        alertView()
                                    }
                                }, label: {
                                    Image(systemName: "plus")
                                        .font(.largeTitle)
                                        .frame(width: 60, height: 60)
                                        .background(RadialGradient(gradient: Gradient(colors: [Color.init(hex: "6C63FF"), Color.init(hex: "c8d4f5")]),  center: .center, startRadius: 5, endRadius: 120))
                                        .clipShape(Circle())
                                        .foregroundColor(.white)
                                        .overlay(Capsule().stroke(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.pink]), startPoint: .leading, endPoint: .trailing), lineWidth: 5))
                                })
                            }
                            .padding(.vertical, 70)
                            .padding(.horizontal, 33)
                            
                        }
                    }
                    .tag("home")
                    .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)

                    .navigationBarHidden(true)
                    .ignoresSafeArea(.all, edges: .all)
                    
                    
                    Color(UIColor.systemBackground)
                        .tag("donate")
                        .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                        .navigationBarHidden(true)

                        .ignoresSafeArea(.all, edges: .all)
                    
                    Color(UIColor.systemBackground)
                        .tag("liked")
                        .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                        .navigationBarHidden(true)

                        .ignoresSafeArea(.all, edges: .all)
                    
                    Color(UIColor.systemBackground)
                        .tag("about")
                        .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                        .navigationBarHidden(true)

                        .ignoresSafeArea(.all, edges: .all)
                    
                    
                }
                .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)

                //Custom bottom tabbar
                HStack(spacing: 0) {
                    ForEach(tabs, id: \.self) { image in
                        GeometryReader { reader in
                            Button(action: {
                                withAnimation(.spring()) {
                                    selectedTab = image
                                    xAxis = reader.frame(in: .global).minX
                                }
                            }, label: {
                                Image(image)
                                    .resizable()
                                    .renderingMode(.original)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(selectedTab == image ? getColor(image: image) : Color.gray)
                                    .padding(selectedTab == image ? 15 : 0)
                                    .background(RadialGradient(gradient: Gradient(colors: [Color.init(hex: "c8d4f5"), Color.init(hex: "6C63FF")]),  center: .center, startRadius: 5, endRadius: 120).opacity(selectedTab == image ? 1 : 0).clipShape(Circle()))
                                    .matchedGeometryEffect(id: image, in: animation)
                                    .offset(x: selectedTab == image ? (reader.frame(in: .global).minX - reader.frame(in: .global).midX) : 0, y: selectedTab == image ? -50 : 0)
                            })
                                .onAppear {
                                    if image == tabs.first {
                                        xAxis = reader.frame(in: .global).minX
                                    }
                                }
                        }
                        .frame(width: 25, height: 30)
                        if image != tabs.last { Spacer(minLength: 0)}
                    }
                }
                .padding(.horizontal, 30)
                .padding(.vertical)
                //.padding(.bottom, 1)
                .background(RadialGradient(gradient: Gradient(colors: [Color.init(hex: "c8d4f5"), Color.init(hex: "6C63FF")]),  center: .center, startRadius: 5, endRadius: 120).clipShape(CustomShape(xAxis: xAxis))
                .cornerRadius(12))
                .padding(.horizontal)
                //Bottom edge
                .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)

            }
            .ignoresSafeArea(.all, edges: .bottom)
            .navigationBarHidden(true)
            //.overlay(Rectangle().stroke(Color.primary.opacity(0.1), lineWidth: 1).shadow(radius: 3).edgesIgnoringSafeArea(.top))

//        }
//        .navigationBarTitle("")
//        .navigationBarHidden(true)
//        .accentColor(Color.init(hex: "6C63FF"))

        HStack {
            SlideMenu(dark: self.$dark, show: self.$show)
                .preferredColorScheme(colorScheme == .dark ? .dark : .light)
                    .offset(x: self.show ? 0 : -UIScreen.main.bounds.width / 1.5)

                Spacer(minLength: 0)
            }
            .background(Color.primary.opacity(self.show ? (self.dark ? 0.05 : 0.2) : 0))

    }
    
    private func addDeck() {
        indexOfCard = 0
        let newDeck = DeckCore(context: viewContext)

        
        newDeck.deckName = deckName
        newDeck.numberOfCardsInDeck = Int16(numOfCardsInDeck)
        newDeck.deckCreatedAt = deckCreatedAt
        
        PersistenceController.shared.saveContext()
        print("new deck card count\(newDeck.cardsArray.count)")
        guard decksArrPersistent != nil && decksArrPersistent.count > 0 else {
            return
        }
        for deck1 in decksArrPersistent {
            print("deck name \(deck1.deckName)")
            print("Num of card \(deck1.numberOfCardsInDeck)")
            print("")
        }

       

    }
    
    //Use with tap gesture or delete button
    private func deleteCard(offsets: IndexSet) {
        withAnimation {
            offsets.map {decksArrPersistent[$0]}.forEach(viewContext.delete)
            PersistenceController.shared.saveContext()
        }
    }
    
    func alertView() {
        
        
        let alert = UIAlertController(title: "Deck", message: "Create FlashPad Deck", preferredStyle: .alert)
        
        alert.addTextField { pass in
            pass.placeholder = "Enter name of deck"
        }
        
        //Action Buttons
        

        
        let create = UIAlertAction(title: "Create", style: .default) { (_) in
            //do your stuff..
            self.deckName = alert.textFields![0].text!
            
            self.numOfCardsInDeck = Int(Int16(indexOfCard))
            self.deckCreatedAt = deck.getTodayDate()
            
            //deckVM.decks.append(Deck( deckName: deck.deckName, numberOfCardsInDeck: deck.numberOfCardsInDeck, deckCreatedAt: deck.deckCreatedAt))
            addDeck()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive) { _ in
            //same
        }
        
        alert.addAction(cancel)
        alert.addAction(create)
        
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: {
            //code
            
        })
    }
    
    func getColor(image: String) -> Color {
        switch image {
        case "home":
            return Color.yellow
        case "donate":
            return Color.black
        case "liked":
            return Color.green
        default:
            return Color.blue
        }
    }
}

var tabs = ["home", "donate", "liked", "about"]

//Curve..
struct CustomShape:Shape {
    var xAxis: CGFloat
    
    var animatableData: CGFloat {
        get { return xAxis }
        set {xAxis = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            
            let center = xAxis
            
            path.move(to: CGPoint(x: center-50, y: 0))
            
            let to1 = CGPoint(x: center, y: 35)
            let control1 = CGPoint(x: center-25, y: 0)
            let control2 = CGPoint(x: center-25, y: 35)
            
            let to2 = CGPoint(x: center+50, y: 0)
            let control3 = CGPoint(x: center+25, y: 35)
            let control4 = CGPoint(x: center+25, y: 0)
            
            path.addCurve(to: to1, control1: control1, control2: control2)
            path.addCurve(to: to2, control1: control3, control2: control4)
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
