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
    @State var card = Card()
    @StateObject var deckVM = DeckViewModel()
    let columns = Array(repeating: GridItem(.flexible(), spacing:25), count: 2)
    
    @State private var navBarHidden = false
   // @State var indexCard = UserDefaults.standard.integer(forKey: "indexCard")
   @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ProfileCore.id, ascending: true)],
           animation: .default)
       private var profileArrPersistent: FetchedResults<ProfileCore>
    @FetchRequest(
           sortDescriptors: [NSSortDescriptor(keyPath: \DeckCore.deckName, ascending: true)],
           animation: .default)
       private var decksArrPersistent: FetchedResults<DeckCore>
    @StateObject var likedCore = LikedCore()
   // @State var imageHasChanged = false
    //@State var indexCard = 0
    //@Binding var indexCard:Int
    @State private var deckName = ""
    @State private var deckCreatedAt = ""
    @State private var numOfCardsInDeck = 0
    @State private var currentTotalNumOfCards = 0
    @FetchRequest(
           sortDescriptors: [NSSortDescriptor(keyPath: \LikedCore.word, ascending: true)],
           animation: .default)
       private var likedArrPersistent: FetchedResults<LikedCore>

  @State private var indexOfCard = UserDefaults.standard.integer(forKey: "indexOfCard")
   // var editScreenView = EditScreenView()
    @StateObject var deckCore = DeckCore()
    @State private var calendarWiggles = false
    var body: some View {
       // ZStack {
        NavigationView {

            ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
                
                TabView(selection: $selectedTab) {
                    Color(UIColor.systemBackground)
                        .ignoresSafeArea(.all, edges: .all)
                    ZStack {
                        //--
//                        Color(UIColor.systemBackground)
//                            .ignoresSafeArea(.all, edges: .all)
                        
                        //custom back button works here
                        ScrollView {
                            //Tabs With Pages...
                            //--
                            LazyVGrid(columns: columns, spacing: 30, content: {
                                ForEach(0..<decksArrPersistent.count, id: \.self) { index in
                                    NavigationLink(destination: EditScrnView(card: card, deckCore: decksArrPersistent[index], likedCore: likedCore)){
                                        
                                        ZStack {
                                            
                                            Image("cardBackg")
                                                .resizable()
                                                .frame(width:150, height: 200)
                                                .cornerRadius(16)
                                                .overlay(Image(systemName: "minus.circle.fill")
                                                            .font(.title)
                                                            .foregroundColor(Color(.systemGray))
                                                            .offset(x: -70, y: -95)
                                                            .onTapGesture{
                                                    //deleteDeck(at: IndexSet.init(integer: index))
                                                    alertViewDeleteDeck(at: IndexSet.init(integer: index))
                                                })
                                               
                                                
                                                

                                            VStack(spacing: 10) {
                                                Text(decksArrPersistent[index].unwrappedDeckName)
                                                    .font(.title).bold()
                                                    .foregroundColor(.white)

                                                Text("\(decksArrPersistent[index].numberOfCardsInDeck) cards")
                                                    .font(.title2)
                                                    .foregroundColor(.white)
                                                    .onAppear {
                                                        decksArrPersistent[index].numberOfCardsInDeck = Int16(decksArrPersistent[index].cardsArray.count)
                                                    }
                                                Text("created on \n\(decksArrPersistent[index].deckCreatedAt ?? "")")
                                                    .font(.system(size: 12.0))
                                                    .foregroundColor(.white)
                                            }
                                            .frame(width:150, height: 200)
                                            
                                        }

                                        

                                    }
                                    
                                }
                            })
 
                        }
                   // }
                        
                        
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
                                        .background(RadialGradient(gradient: Gradient(colors: [Color.init(hex: "271D76"), Color.init(hex: "102FC3")]),  center: .center, startRadius: 5, endRadius: 120))
                                        .clipShape(Circle())
                                        .foregroundColor(.white)
                                        .overlay(Capsule().stroke(LinearGradient(gradient: Gradient(colors: [Color.init(hex: "BC4571"), Color.init(hex: "102FC3")]), startPoint: .leading, endPoint: .trailing), lineWidth: 5))
                                })
                            }
                            .padding(.vertical, 70)
                            .padding(.horizontal, 33)
                            
                        }
                    }
                    .tag("home")
                    
                    Color(UIColor.systemBackground)
                        .ignoresSafeArea(.all, edges: .all)
                        .tag("donate")

                    LikedCardView()
                    .tag("liked")

                    IntsructionsView()
                    .tag("about")
                    
                    
                    
                }

                
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
                                    .background(RadialGradient(gradient: Gradient(colors: [Color.init(hex: "c8d4f5"), Color.init(hex: "271D76")]),  center: .center, startRadius: 5, endRadius: 120).opacity(selectedTab == image ? 1 : 0).clipShape(Circle()))
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
                .background(RadialGradient(gradient: Gradient(colors: [Color.init(hex: "8092EA"), Color.init(hex: "1130C1")]),  center: .center, startRadius: 5, endRadius: 120).clipShape(CustomShape(xAxis: xAxis)).cornerRadius(12))
                .padding(.horizontal)
                //Bottom edge
                .ignoresSafeArea(.all, edges: .bottom)

                .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                
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
//                                Button(action: {
//                                    print("Profile button tapped")
//                                }) {
//                                    Image("profilePhoto")
//                                        .resizable()
//                                        .aspectRatio(contentMode: .fit)
//                                        .frame(width: 50, height: 70)
//                                }
                                NavigationLink(destination: ProfileView()) {
                                    if let data = profileArrPersistent.last?.image {
                                        Image(uiImage: (UIImage(data: data) ?? UIImage(named: "profilePhoto"))!)
                                            .resizable()
                                            .scaledToFill()
                                            .clipShape(Circle())
                                            .frame(width: 47, height: 47)
                                            .padding(.trailing, 10)
                                    } else {
                                        Image("profilePhoto")
                                            .resizable()
                                            .scaledToFill()
                                            .clipShape(Circle())
                                            .frame(width: 47, height: 47)
                                            .padding(.trailing, 10)
                                    }
                                }
                                .padding(.trailing, 10)
                            }

                        }

                    }
                }
                .ignoresSafeArea(.all, edges: .all)
                .foregroundColor(.primary)

            }
            .ignoresSafeArea(.all, edges: .bottom)
            
    }
        .accentColor(Color.init(hex: "6C63FF"))
        
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
        
//        print("new deck card count\(newDeck.cardsArray.count)")
//        guard decksArrPersistent != nil && decksArrPersistent.count > 0 else {
//            return
//        }
//        for deck1 in decksArrPersistent {
//            print("deck name \(deck1.deckName)")
//            print("Num of card \(deck1.numberOfCardsInDeck)")
//            print("")
//        }

       

    }
    
    
    
    //Use with tap gesture or delete button
    private func deleteDeck(at offsets: IndexSet) {
        withAnimation {
//            offsets.map {decksArrPersistent[$0]}.forEach(viewContext.delete)
            for index in offsets {
                let deck = decksArrPersistent[index]
                viewContext.delete(deck)
                PersistenceController.shared.saveContext()
            }
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
    
    func alertViewDeleteDeck(at index: IndexSet) {
        
        
        let alert = UIAlertController(title: "Delete Deck", message: "Do you want to delete this deck?", preferredStyle: .alert)
        
//        alert.addTextField { pass in
//            pass.placeholder = "Enter name of deck"
//        }
        
        //Action Buttons
        

        
        let delete = UIAlertAction(title: "Delete", style: .default) { (_) in
            //do your stuff..
            
            
            //deckVM.decks.append(Deck( deckName: deck.deckName, numberOfCardsInDeck: deck.numberOfCardsInDeck, deckCreatedAt: deck.deckCreatedAt))
            deleteDeck(at: index)
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

struct NavigationBarModifier: ViewModifier {

var backgroundColor: UIColor?

init(backgroundColor: UIColor?) {
    UITabBar.appearance().isHidden = true
    self.backgroundColor = backgroundColor

    let coloredAppearance = UINavigationBarAppearance()
    coloredAppearance.configureWithTransparentBackground()
    coloredAppearance.backgroundColor = backgroundColor
    coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

    
    UINavigationBar.appearance().standardAppearance = coloredAppearance
    UINavigationBar.appearance().compactAppearance = coloredAppearance
    UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    UINavigationBar.appearance().tintColor = .white
}

func body(content: Content) -> some View {
    ZStack{
        content
        VStack {
            GeometryReader { geometry in
                Color(self.backgroundColor ?? .clear)
                    .frame(height: geometry.safeAreaInsets.top)
                    .edgesIgnoringSafeArea(.top)
                Spacer()
            }
        }
    }
}}
