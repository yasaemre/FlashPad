//
//  MenuView.swift
//  FlashPad
//
//  Created by Emre Yasa on 7/29/21.
//

import SwiftUI

struct MenuView: View {
    @State var dark = false
    @State var show = false
    
    var body: some View {
        ZStack(alignment:.leading) {
            GeometryReader{ _ in
//                VStack{
//                    ZStack {
//                        HStack {
//                            Button(action: {
//                                withAnimation(.default) {
//                                    self.show.toggle()
//                                }
//                            }) {
//                                Image(systemName: "arrowshape.turn.up.backward.fill")
//                                    .resizable()
//                                    .frame(width: 25, height: 25)
//                            }
//                        }
//                        Text("Home")
//                    }
//                    .padding()
//                    .foregroundColor(.primary)
//
//                    .overlay(Rectangle().stroke(Color.primary.opacity(0.1), lineWidth: 1).shadow( radius:3).edgesIgnoringSafeArea(.top))
//
//                    Spacer()
//                    Text("Dark Mode Menu")
//                    Spacer()
//                }
            }
    //        HStack {
                SlideMenu(dark: $dark, show: $show)
                    .preferredColorScheme(self.dark ? .dark : .light)
//                     .offset(x: self.show ? 0 : -UIScreen.main.bounds.width / 1.5)
                
//                Spacer(minLength: 0)
//            }
//            .background(Color.primary.opacity(self.show ? (self.dark ? 0.05 : 0.2) : 0).edgesIgnoringSafeArea(.all))
        }
    }
}

struct SlideMenu: View {
    @Binding var dark:Bool
    @Binding var show:Bool
    
    var body: some View {
        VStack {
            HStack {
                NavigationLink(destination: HomeScreenView()) {
                    Button(action: {
                        self.show.toggle()
                        print("Back button tapped")
                    }) {
                        Image(systemName: "arrowshape.turn.up.backward.fill")
                            .symbolRenderingMode(.hierarchical)
                            .font(.system(size: 24))
                            .foregroundColor(Color.init(hex: "6C63FF"))
                    }
                }
                
                Spacer()
                
                Button(action: {
                    print("Tweet button tapped")
                }) {
                    Image(systemName:"square.and.pencil")
                        .font(.title)
                }
            }
            .padding(.top)
            .padding(.bottom, 25)
            
            Image("profilePhoto")
                .resizable()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
            
            VStack(spacing:12) {
                Text("Emre")
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
                Button(action: {
                    
                }) {
                    HStack(alignment: .center, spacing:22) {
                        Image(systemName: "pip.exit")
                            .resizable()
                            .frame(width: 25, height: 25)
                        Text("Log out")
                    }
                    Spacer()
                }
                .padding(.top, 25)
            }
            Spacer()
        }
        .foregroundColor(.primary)
        .padding(.horizontal, 20)
        .frame(width: UIScreen.main.bounds.width / 1.5)
        .background((self.dark ? Color.black : Color.white).edgesIgnoringSafeArea(.all))
        .overlay(Rectangle().stroke(Color.primary.opacity(0.2), lineWidth: 2).shadow( radius:3).edgesIgnoringSafeArea(.all))
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
