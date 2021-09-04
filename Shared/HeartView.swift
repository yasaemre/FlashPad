//
//  HeartView.swift
//  FlashPad
//
//  Created by Emre Yasa on 9/3/21.
//

import SwiftUI

struct HeartView: View {
    @State private var showStrokeBorder = false
    @State private var showSplash = false
    @State private var showSplashTilted = false
    @State private var showHearth = false
    @State private var opacity = 1
    
    var body: some View {
            ZStack {
//                Image(systemName: "suit.heart")
//                    .resizable()
//                    .frame(width: 45, height: 45)
//                .foregroundColor(Color.init(hex: "6C63FF"))
                
                Circle()
                    .strokeBorder(lineWidth: showStrokeBorder ? 1 : 35/2, antialiased: false)
                    .opacity(showStrokeBorder ? 0 : 1)
                    .frame(width: 45, height: 45)
                    .foregroundColor(.purple)
                    .scaleEffect(showStrokeBorder ? 1 : 0)
                    //.offset(x: 50, y: 340)
                    .animation(Animation.easeOut(duration: 0.5))
                    .onAppear {
                        self.showStrokeBorder.toggle()
                    }
                
                Image("splash")
                    .resizable()
                    .opacity(showSplash ? 0 : 1)
                    .frame(width: 45, height: 45)
                    .scaleEffect(showSplash ? 1 : 0)
                    //.offset(x: 50, y: 340)
                    .animation(Animation.easeOut(duration: 0.5).delay(0.1))
                    .onAppear {
                        self.showSplash.toggle()
                    }
                
                Image("splashTilted")
                    .resizable()
                    .opacity(showSplash ? 0 : 1)
                    .frame(width: 45, height: 45)
                    .scaleEffect(showSplashTilted ? 1.1 : 0)
                    //.scaleEffect(1.1)
                    //.offset(x: 50, y: 340)
                    .animation(Animation.easeOut(duration: 0.5).delay(0.1))
                    .onAppear {
                        self.showSplashTilted.toggle()
                    }
                
                Image(systemName: "suit.heart.fill")
                    .resizable()
                    .frame(width: 45, height: 45)
                    .foregroundColor(.pink)
                    .scaleEffect(showHearth ? 1 : 0)
                //.offset(x: 50, y: 340)//
                    .animation(Animation.interactiveSpring().delay(0.2))
                    .onAppear {
                        self.showHearth.toggle()
            }
            }
        

    }
}

struct HeartView_Previews: PreviewProvider {
    static var previews: some View {
        HeartView()
    }
}
