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
    var body: some View {
        VStack {
            
//            HStack(spacing:22) {
//                
////                NavigationLink(destination: HomeScreenView()) {
////                    Image(systemName: "arrowshape.turn.up.backward.fill")
////                    .symbolRenderingMode(.hierarchical)
////                    .font(.system(size: 24))
////                    .foregroundColor(Color.init(hex: "6C63FF"))
////                }
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
            .padding(.top)
            .padding(.bottom, 25)


            if let data = profileArrPersistent.last?.image {
                Image(uiImage: (UIImage(data: data) ?? UIImage(named: "profilePhoto"))!)
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 80, height: 80)
                    .padding(.trailing, 10)
            }
            
            VStack(spacing:12) {
                Text(profileArrPersistent.last?.name ?? "Anonymous")
                Text("Software Engineer")
                    .font(.caption)
            }
            .padding(.top, 25)
            
            HStack(spacing: 22) {
                Image(systemName: "moon.fill")
                    .font(.title)
                
                Text("Dark Mode")
                Spacer()
                Button(action: {
                    print("Flash button tapped")
                    self.dark.toggle()
                    
                    UIApplication.shared.windows.first?.rootViewController?.view.overrideUserInterfaceStyle = self.dark ? .dark : .light
                }) {
                    Image(systemName: "flashlight.off.fill")
                        .font(.title)
                        .rotationEffect(.init(degrees: self.dark ? 180 : 0))
                }
                
            }
            .padding(.top,25)
            
            
            
            Group {
                Button(action: {
                    
                }) {
                    HStack(alignment: .center, spacing:22) {
                        Image("scoreboard")
                            .resizable()
                            .frame(width: 70, height: 70)
                        Text("Scoreboard")
                    }
                }
                .padding(.top, 25)
                
                Button(action: {
                    
                }) {
                    HStack(alignment: .center, spacing:22) {
                        Image("desktop")
                            .resizable()
                            .frame(width: 70, height: 70)
                        Text("Desktop App")
                    }
                }
                .padding(.top, 25)
                
                Button(action: {
                    
                }) {
                    HStack(alignment: .center, spacing:22) {
                        Image("share")
                            .resizable()
                            .frame(width: 70, height: 70)
                        Text("Share with \nFriends")
                    }
                }
                .padding(.top, 25)
                Divider()
                    .padding(.top, 25)
                LogoutButtonView()
            }
            Spacer()
        }
        .foregroundColor(.primary)
        .padding(.horizontal, 20)
        .frame(width: UIScreen.main.bounds.width / 1.5)
        .background((colorScheme == .dark ? Color.black : Color.white).edgesIgnoringSafeArea(.all))
        .overlay(Rectangle().stroke(Color.primary.opacity(0.2), lineWidth: 2).shadow( radius:3).edgesIgnoringSafeArea(.all))

    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        SlideMenu(dark: .constant(false), show: .constant(false))
    }
}
