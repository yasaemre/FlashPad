//
//  IntsructionsView.swift
//  FlashPad
//
//  Created by Emre Yasa on 9/16/21.
//

import SwiftUI

struct IntsructionsView: View {
    var body: some View {
        ZStack(alignment: .top){
            Color.init(hex:"81329b")
                .ignoresSafeArea(.all, edges: .all)
            Image("worldMap")
                .resizable()
                .scaledToFit()
                .padding(.top, 1)
            
            VStack {
                Text("WELCOME TO\nFLASHPAD")
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(Color.init(hex: "606060"))
                    .frame(width: UIScreen.main.bounds.width - 40, height: 100)
                    //.padding(.bottom, 20)
                
                    RoundedRectangle(cornerRadius: 10)
                        .fill(LinearGradient(gradient: Gradient(colors: [Color.init(hex: "F7F2F2"), Color.init(hex: "c8d4f5")]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(width: UIScreen.main.bounds.width-40, height: UIScreen.main.bounds.height - 400)
                        .shadow(color: Color(UIColor(.black)), radius: 10, x: 5, y: 5)
                        .overlay(
                            VStack {
                            ScrollView{
                                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatasunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatasunt in culpa qui officia deserunt mollit anim id est laborum.")
                                    .frame(width: UIScreen.main.bounds.width-80)
                            }
                            
                             Spacer()
                            
                        }
                            
                        )
                        .opacity(0.8)
                        .padding(.top, 10)
               
                
                
               // Spacer()
            }
            .padding(.top, 50)
        }
      
        
    }
}

struct IntsructionsView_Previews: PreviewProvider {
    static var previews: some View {
        IntsructionsView()
    }
}
