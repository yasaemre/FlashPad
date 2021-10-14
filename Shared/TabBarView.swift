//
//  TabBarView.swift
//  FlashPad
//
//  Created by Emre Yasa on 7/2/21.
//

import SwiftUI
import Combine

struct TabBarView: View {
    init() {
        #if os(iOS)
        UITabBar.appearance().isHidden = true
        #endif
    }

    @State var selectedTab = "home"
    @State var xAxis:CGFloat = 0
    @Namespace var animation
    
    @State var customAlert = false
    @State var HUD = false
    
    @State var dark = false
    @State var show = false
        
    @Environment(\.colorScheme) var colorScheme
    @State var deck = Deck()
    @State var card = Card()
    @StateObject var deckVM = DeckViewModel()
    let columns = Array(repeating: GridItem(.flexible(), spacing:25), count: 2)
    
    @State private var navBarHidden = false
   @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ProfileCore.id, ascending: true)],
           animation: .default)
       private var profileArrPersistent: FetchedResults<ProfileCore>
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \DeckCore.deckCreatedAt, ascending: false)],
           animation: .default)
       private var decksArrPersistent: FetchedResults<DeckCore>
    @StateObject var likedCore = LikedCore()

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
    @State var imageHasChanged = false
    @State private var avatarImageData = Data()
    @State private var avatarImage = UIImage(named: "profilePhoto")!

    var body: some View {
        
            NavigationView {
                GeometryReader { geo in
                ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
                    #if os(iOS)
                    TabView(selection: $selectedTab) {
                        Color(UIColor.systemBackground)
                            .ignoresSafeArea(.all, edges: .all)
                        ZStack {
                            ScrollView {

                                LazyVGrid(columns: columns, spacing: 30, content: {
                                    ForEach(0..<decksArrPersistent.count, id: \.self) { index in
                                        NavigationLink(destination: EditScrnView(card: card, deckCore: decksArrPersistent[index], likedCore: likedCore)){
                                            
                                            ZStack {
                                                
                                                Image("blackboardM")
                                                    .resizable()
                                                    .frame(width:150, height: 200)
                                                    .cornerRadius(16)
                                                    .overlay(Image(systemName: "minus.circle.fill")
                                                                .font(.title)
                                                                .foregroundColor(Color(.systemGray))
                                                                .offset(x: -70, y: -95)
                                                                .onTapGesture{
                                                        alertViewDeleteDeck(at: IndexSet.init(integer: index))
                                                    })
                                                   
                                                    
                                                    

                                                VStack(spacing: 10) {
                                                    Text(decksArrPersistent[index].unwrappedDeckName)
                                                        .font(.custom("Chalkduster", size: 22))

                                                        .foregroundColor(.white)

                                                    Text("\(decksArrPersistent[index].numberOfCardsInDeck) cards")
                                                        .font(.custom("Chalkduster", size: 18))
                                                        .foregroundColor(.white)
                                                        .onAppear {
                                                            decksArrPersistent[index].numberOfCardsInDeck = Int16(decksArrPersistent[index].cardsArray.count)
                                                        }
                                                    Text("created on \n\(decksArrPersistent[index].deckCreatedAt ?? "")")
                                                        .font(.custom("Chalkduster", size: 14))
                                                        .foregroundColor(.white)
                                                }
                                                .frame(width:120, height: 170)
                                                
                                            }
                                        }
                                        
                                    }
                                })
     
                            }
                                HStack {
                                    
                                    Button(action: {
                                        print("Deck added")
                                        withAnimation {
                                            alertView()
                                        }
                                    }, label: {
                                        Image(systemName: "plus")
                                            .font(.largeTitle)
                                            .frame(width:  geo.size.width * 0.15, height: geo.size.height * 0.15)
                                            .background(RadialGradient(gradient: Gradient(colors: [Color.init(hex: "164430"), Color.init(hex: "164430")]),  center: .center, startRadius: 5, endRadius: 120))
                                            .clipShape(Circle())
                                            .foregroundColor(Color.init(hex: "C9E9E2"))
                                            .overlay(Circle().stroke(LinearGradient(gradient: Gradient(colors: [Color.init(hex: "C9E9E2"), Color.init(hex: "DFD5B8")]), startPoint: .leading, endPoint: .trailing), lineWidth: 5))
                                    })

                                }
                                .offset(y: UIScreen.main.bounds.minY + geo.size.height * 0.32 )
                                .padding(.horizontal, 33)
                            
                        }
                        .tag("home")
                        DonateView()
                        .tag("donation2")

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
                                        .background(RadialGradient(gradient: Gradient(colors: [Color.init(hex: "c8d4f5"), Color.init(hex: "164430")]),  center: .center, startRadius: 5, endRadius: 120).opacity(selectedTab == image ? 1 : 0).clipShape(Circle()))
                                        .matchedGeometryEffect(id: image, in: animation)
                                        .offset(x: selectedTab == image ? (reader.frame(in: .global).minX - reader.frame(in: .global).midX) : 0, y: selectedTab == image ? -50 : 0)
                                })
                                    .onAppear {
                                        if image == tabs.first {
                                            xAxis = reader.frame(in: .global).minX
                                        }
                                    }
                            }
                            .frame(width: 25, height: geo.size.height * 0.04)
                            if image != tabs.last { Spacer(minLength: 0)}
                        }
                    }
                    .padding(.horizontal, 30)
                    .padding(.vertical)
                    .background(RadialGradient(gradient: Gradient(colors: [Color.init(hex: "8092EA"), Color.init(hex: "164430")]),  center: .center, startRadius: 5, endRadius: 120).clipShape(CustomShape(xAxis: xAxis)).cornerRadius(12))
                    .padding(.horizontal)
                    .padding(.bottom, UIScreen.main.bounds.minY + geo.size.height * 0.03)
                    
                    //Top custom Navigation bar
                    .toolbar {
                        ToolbarItemGroup(placement: .navigationBarLeading) {
                          VStack {
                            HStack {

                                    Button(action: {
                                        print("Slide in menu tapped")
                                        self.show.toggle()
                                    }) {
                                        Image(systemName: "list.bullet")
                                    }
                                    .symbolRenderingMode(.hierarchical)
                                    .font(.system(size: 24))
                                    .foregroundColor(colorScheme == .dark ? Color(.systemGreen) : Color.init(hex: "164430"))

                                    Spacer()
                                    Spacer()

                                    NavigationLink(destination: ProfileView(avatarImageData: $avatarImageData, imageHasChanged: $imageHasChanged)) {
                                        if imageHasChanged == true {
                                            if let imgData = avatarImageData{
                                                Image(uiImage: UIImage(data: imgData) ?? avatarImage)
                                                .resizable()
                                                .scaledToFill()
                                                .clipShape(Circle())
                                                //.frame(width: 45, height: 45)
                                            }
                                        } else {
                                            if let image = profileArrPersistent.last?.image{
                                                if let uiImage = UIImage(data: image)  {
                                                    Image(uiImage: uiImage)
                                                        .resizable()
                                                        .scaledToFill()
                                                        .clipShape(Circle())
                                                }
                                            } else {
                                                Image(uiImage: avatarImage)
                                                    .resizable()
                                                    .scaledToFill()
                                                    .clipShape(Circle())
                                            }
                                        }
                                    }

                                }
                            .frame(width: UIScreen.main.bounds.width * 0.95)

                           }
                          .frame(maxWidth: .infinity, maxHeight: .infinity, alignment:.top)

                        }
                    }
                    .foregroundColor(.primary)
                    .padding(.top, UIScreen.main.bounds.minY + geo.size.height * 0.1)
                    #else
                    ZStack {
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    #endif
                    

                   
                }
            }
        }
            .accentColor(colorScheme == .dark ? Color(.systemGreen) : Color.init(hex: "164430"))
            
            HStack {
                SlideMenu(dark: self.$dark, show: self.$show, imageHasChanged: $imageHasChanged, avatarImageData: $avatarImageData)
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

       

    }
    
    func getDevice() -> Device {
        #if os(iOS)
        
        //Since there is no direct device for iPad OS
        if UIDevice.current.model.contains("iPad") {
            return .iPad
        }
        else {
            return .iPhone
        }
        #else
        return .macOS
        #endif
    }
    
    
    
    //Use with tap gesture or delete button
    private func deleteDeck(at offsets: IndexSet) {
        withAnimation {
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
        let delete = UIAlertAction(title: "Delete", style: .default) { (_) in
            deleteDeck(at: index)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .destructive) { _ in
        }
        
        alert.addAction(cancel)
        alert.addAction(delete)
        
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: {
            
        })
    }

    
    func getColor(image: String) -> Color {
        switch image {
        case "home":
            return Color.yellow
        case "donation2":
            return Color.black
        case "liked":
            return Color.green
        default:
            return Color.blue
        }
    }
}

var tabs = ["home", "donation2", "liked", "about"]

struct InsideTabBarItems: View {
    @Binding var selectedTab: String
    @StateObject var homeData = HomeViewModel()

    var body: some View {
        Group {
            TabButton(image: "house", title: "Home", selectedTab: $homeData.selectedTab).padding(.top, 30)
            TabButton(image: "textformat.123", title: "Scoreboard", selectedTab: $homeData.selectedTab)
            TabButton(image: "heart.circle", title: "Liked Cards", selectedTab: $homeData.selectedTab)
            TabButton(image: "doc.text.magnifyingglass", title: "Instructions", selectedTab: $homeData.selectedTab)
            TabButton(image: "person.crop.circle", title: "Profile", selectedTab: $homeData.selectedTab)
        }
    }
}

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


//extension View {
//    func getScreen() -> CGRect {
//        #if os(iOS)
//        return UIScreen.main.bounds
//        #elseif
//        return NSScreen.main!.visibleFrame
//        #endif
//    }
//}

enum Device {
    case iPhone
    case iPad
    case macOS
}
class HomeViewModel: ObservableObject {
    @Published var selectedTab = "Home"
    
    @Published var search = ""
    
    @Published var message = ""

    @Published var isExpanded = false
    
    @Published var pickedTab = "Media"
}
