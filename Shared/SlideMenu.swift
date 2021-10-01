//
//  MenuView.swift
//  FlashPad
//
//  Created by Emre Yasa on 7/29/21.
//

import SwiftUI


struct SlideMenu: View {
    @Binding var dark:Bool
    @Binding var show:Bool
    @Environment(\.colorScheme) var colorScheme
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ProfileCore.id, ascending: true)],
           animation: .default)
       private var profileArrPersistent: FetchedResults<ProfileCore>
    @Environment(\.managedObjectContext) private var viewContext
    @State private var isShareSheetShowing = false
    
    @Binding var imageHasChanged:Bool
    @Binding var avatarImageData:Data
    @State private var avatarImage = UIImage(named: "profilePhoto")!
    
   
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 20) {
                Button(action: {
                    withAnimation {
                        self.show.toggle()
                        print("Back button tapped")
                        print(show)
                    }
                }) {
                    Image(systemName: "arrowshape.turn.up.backward.fill")
                        .font(.title)
                        .foregroundColor(Color.init(hex: "6C63FF"))
                    
                        .contentShape(Rectangle())
                    
                    Spacer()
                    
                }
                .padding(.top, geo.size.height * 0.01)
                .padding(.bottom, geo.size.height * 0.03)
                .padding(.leading, geo.size.height * 0.01)
                
                
                if imageHasChanged == true {
                    if let imgData = avatarImageData{
                        Image(uiImage: UIImage(data: imgData) ?? avatarImage)
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .frame(width: 85, height: 85)
                            .padding()
                            .shadow(color: Color(UIColor(.black)), radius: 10, x: 5, y: 5)

                    }
                } else {
                    if let image = profileArrPersistent.last?.image{
                        if let uiImage = UIImage(data: image)  {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .clipShape(Circle())
                                .frame(width: 85, height: 85)
                                .padding()
                                .shadow(color: Color(UIColor(.black)), radius: 10, x: 5, y: 5)

                        }
                    } else {
                        Image(uiImage: avatarImage)
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .frame(width: 85, height: 85)
                            .padding()
                            .shadow(color: Color(UIColor(.black)), radius: 10, x: 5, y: 5)

                    }
                }
                
                VStack(spacing:12) {
                    if let name = profileArrPersistent.last?.name, let lastName = profileArrPersistent.last?.lastName {
                        Text("\(name) \(lastName)")
                            .font(.title3)
                    } else {
                        Text("Anonymous")
                            .font(.title3)
                    }
                }
                .frame(width:  geo.size.width * 0.5, height: geo.size.height * 0.04)
                
                HStack() {
                    Image(systemName: "moon.fill")
                        .font(.title2)
                    
                    Text("Dark Mode")
                        .frame(width:  geo.size.width * 0.3, height: geo.size.height * 0.04)

                    //Spacer()
                    Button(action: {
                        print("Flash button tapped")
                        self.dark.toggle()
                        
                        
                        UIApplication.shared.windows.first?.rootViewController?.view.overrideUserInterfaceStyle = self.dark ? .dark : .light
                    }) {
                        Image(systemName: "sunrise")
                            .font(.title2)
                            .rotationEffect(.init(degrees: self.dark ? 180 : 0))
                    }
                    
                }
                .padding(.top, geo.size.height * 0.02)

                
                
                
                Group {
                    
                    HStack(alignment: .center, spacing:2) {
                        
                        NavigationLink(destination: ScoreboardView(moc: viewContext)) {
                            Image("scoreboard")
                                .resizable()
                                .frame(width:  geo.size.width * 0.17, height: geo.size.height * 0.07)
                            Text("Scoreboard")
                                .frame(width:  geo.size.width * 0.3, height: geo.size.height * 0.04)

                        }
                    }
                    .padding(.top, geo.size.height * 0.02)

                    Button(action: {
                        
                    }) {
                        HStack(alignment: .center, spacing:2) {
                            Image("desktop")
                                .resizable()
                                .frame(width:  geo.size.width * 0.17, height: geo.size.height * 0.07)
                            Text("Desktop App")
                                .frame(width:  geo.size.width * 0.3, height: geo.size.height * 0.04)

                        }
                    }
                    Button(action: {
                        
                    }) {
                        HStack(alignment: .center, spacing: 2) {
                            Image("share")
                                .resizable()
                                .frame(width:  geo.size.width * 0.17, height: geo.size.height * 0.07)
                            Text("Share with \nFriends")
                                .frame(width:  geo.size.width * 0.3, height: geo.size.height * 0.1)

                        }
                        .onTapGesture {
                            shareButton()
                        }
                    }
                    Divider()
                    LogoutButtonView()
                        .frame(width:  geo.size.width * 0.5, height: geo.size.height * 0.04)

                }
                
                Spacer()
            }
            .foregroundColor(.primary)
            //.padding(.horizontal, 20)
            .frame(width: UIScreen.main.bounds.width / 1.6)
            .background((colorScheme == .dark ? Color.black : Color.white).edgesIgnoringSafeArea(.all))
            //.overlay(Rectangle().stroke(Color.primary.opacity(0.2), lineWidth: 2).shadow( radius:3).edgesIgnoringSafeArea(.all))
        }
    }
    
   public func shareButton() {
        isShareSheetShowing.toggle()
        
       //https://apps.apple.com/us/app/vintage-house/id1549251393
       guard let url = URL(string: "https://emre-yasa.tech/") else {
           return
       }
       
        let activityView = UIActivityViewController(activityItems: ["FlahPad is fun way of learning new words, language and formulas and so on. Here is the link to download", url], applicationActivities: nil)
   
        
        UIApplication.shared.windows.first?.rootViewController?.present(activityView, animated: true, completion: nil)
    }
}

//
//struct MenuView_Previews: PreviewProvider {
//    static var previews: some View {
//        SlideMenu(dark: .constant(false), show: .constant(false))
//    }
//}
