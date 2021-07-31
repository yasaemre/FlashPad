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
    @State var nameOfCard = ""
    
    @State var dark = false
    @State var show = false
    
    @Environment(\.colorScheme) var colorScheme
    
    
    @StateObject var cardData = CardViewModel()
    let columns = Array(repeating: GridItem(.flexible(), spacing:25), count: 2)
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            
            TabView(selection: $selectedTab) {
                
                ZStack {
                    Color(UIColor.systemBackground)
                        .ignoresSafeArea(.all, edges: .all)
                    ScrollView {
                        //Tabs With Pages...
                        
                        LazyVGrid(columns: columns, spacing: 30, content: {
                            ForEach(cardData.cards) { card in
                                ZStack {
                                   Image("cardBackg")
                                        .resizable()
                                        .frame(width:150, height: 200)
                                        .cornerRadius(16)

                                    VStack(spacing: 10) {
                                        Text("\(card.cardName)")
                                            .font(.title).bold()
                                            .foregroundColor(.white)
                                            

                                            .onDrag ({
                                                //setting Current Page...
                                                cardData.currentCard = card
                                                
                                                //Sending ID for Sample..
                                                return NSItemProvider(object: card.cardName as NSString)
                                                
                                            })
                                            .onDrop(of: ["public.image"], delegate: DropViewDelegate(card: card, cardData: cardData))
                                        Text("\(card.numberOfCards) cards")
                                            .font(.title2)
                                            .foregroundColor(.white)
                                        Text("created on \n\(card.getTodayDate())")
                                            .font(.system(size: 12.0))
                                            .foregroundColor(.white)
                                    }
                                    .frame(width:150, height: 200)
                                }
                            }
                        })
                    }
                    VStack {
                        Spacer()
                        HStack {
                            
                            Button(action: {
                                print("Card added")
                                withAnimation {
                                    alertView()
                                }
                            }, label: {
                                Image(systemName: "plus")
                                    .font(.largeTitle)
                                    .frame(width: 60, height: 60)
                                    .background(RadialGradient(gradient: Gradient(colors: [Color.init(hex: "6C63FF"), Color.init(hex: "c8d4f5")]),  center: .center, startRadius: 5, endRadius: 120))
                                    .clipShape(Circle())
                                    .foregroundColor(.primary)
                                    .overlay(Capsule().stroke(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.pink]), startPoint: .leading, endPoint: .trailing), lineWidth: 5))
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
                Color(UIColor.systemBackground)
                    .ignoresSafeArea(.all, edges: .all)
                    .tag("liked")
                Color(UIColor.systemBackground)
                    .ignoresSafeArea(.all, edges: .all)
                    .tag("about")
            }
            
            
            
            
            //Custom tabbar
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
                                .frame(width: 35, height: 35)
                                .foregroundColor(selectedTab == image ? getColor(image: image) : Color.gray)
                                .padding(selectedTab == image ? 15 : 0)
                                .background(RadialGradient(gradient: Gradient(colors: [Color.init(hex: "c8d4f5"), Color.init(hex: "6C63FF")]),  center: .center, startRadius: 5, endRadius: 120).opacity(selectedTab == image ? 1 : 0).clipShape(Circle()))
                                .matchedGeometryEffect(id: image, in: animation)
                                .offset(x: selectedTab == image ? (reader.frame(in: .global).minX - reader.frame(in: .global).midX):0, y: selectedTab == image ? -60 : 0)
                        })
                            .onAppear {
                                if image == tabs.first {
                                    xAxis = reader.frame(in: .global).minX
                                }
                            }
                    }
                    .frame(width: 35, height: 35)
                    if image != tabs.last { Spacer(minLength: 0)}
                }
            }
            .padding(.horizontal, 30)
            .padding(.vertical)
            .background(RadialGradient(gradient: Gradient(colors: [Color.init(hex: "c8d4f5"), Color.init(hex: "6C63FF")]),  center: .center, startRadius: 5, endRadius: 120).clipShape(CustomShape(xAxis: xAxis)).cornerRadius(12))
            .padding(.horizontal)
            //Bottom edge
            .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
            
//            HStack {
//            SlideMenu(dark: self.$dark, show: self.$show)
//                    .preferredColorScheme(self.dark ? .dark : .light)
//                    .offset(x: self.show ? 0 : -UIScreen.main.bounds.width / 1.5)
//
//                Spacer(minLength: 0)
//            }
//            .background(Color.primary.opacity(self.show ? (self.dark ? 0.05 : 0.2) : 0).edgesIgnoringSafeArea(.all))
        }
        .toolbar {
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
        .ignoresSafeArea(.all, edges: .bottom)
        .foregroundColor(.primary)
        .overlay(Rectangle().stroke(Color.primary.opacity(0.1), lineWidth: 1).shadow(radius: 3).edgesIgnoringSafeArea(.top))
        
        HStack {
        SlideMenu(dark: self.$dark, show: self.$show)
                .preferredColorScheme(self.dark ? .dark : .light)
                .offset(x: self.show ? 0 : -UIScreen.main.bounds.width / 1.5)
            
            Spacer(minLength: 0)
        }
        .background(Color.primary.opacity(self.show ? (self.dark ? 0.05 : 0.2) : 0).edgesIgnoringSafeArea(.all))
        
    }
    
    func alertView() {
        let alert = UIAlertController(title: "Deck", message: "Create FlashPad Deck", preferredStyle: .alert)
        
        alert.addTextField { pass in
            pass.placeholder = "Enter name of deck"
        }
        
        //Action Buttons
        
        let create = UIAlertAction(title: "Create", style: .default) { (_) in
            //do your stuff..
            nameOfCard = alert.textFields![0].text!
            cardData.cards.append(Card(cardName: nameOfCard, numberOfCards: 10, dateCreated: nil))
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
