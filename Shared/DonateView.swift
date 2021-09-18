//
//  DonateView.swift
//  FlashPad
//
//  Created by Emre Yasa on 9/17/21.
//

import SwiftUI
import StoreKit

struct DonateView: View {
    
    @State private var amount: Double = 0
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject private var store:Store
   // @StateObject var store = Store()
    var body: some View {
        ZStack(alignment: .top) {
            if colorScheme == .light {
                LinearGradient(gradient: Gradient(colors: [.white,.white, Color.init(hex:"81329b")]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.bottom)
            } else {
                LinearGradient(gradient: Gradient(colors: [.black,.black, Color.init(hex:"81329b")]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.bottom)
            }
            VStack(spacing: 5){
                
                Image("donate")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .padding(.top, 1)

                Text("Support development of the app, FlashPad is a free and open application, developed by a small team. The heart and soul of FlashPad is our global community of tons of users, and donors like yourself – all united to share unlimited access to well structured app. Your donations keep our knowledge projects like FlashPad freely available to everyone. Please help us keep FlashPad growing.")
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    .frame(width: UIScreen.main.bounds.width - 60)
                    .padding(.top, 1)
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(LinearGradient(gradient: Gradient(colors: [.white]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 300, height: 100)
                    .shadow(color: Color(UIColor(.black)), radius: 10, x: 5, y: 5)
                    .overlay(
                        VStack {
                        Text("Donate whatever it's worth for you")
                            .foregroundColor(.black)

                        Text("One time purchase")
                            .foregroundColor(.black)

                            .font(.system(size: 10))
                        Slider(value: $amount, in: 0.99...10)
                        Text("Donation amount is  $\(amount, specifier: "%.2f")")
                            .foregroundColor(.black)

                    }
                    )
                    .padding(.top, 13)
                
                HStack {
                    Spacer()
                    Button(action: action, label: {
                        Text("Continue")
                            .font(.title)
                            .frame(width: 150, height: 60)
                            .foregroundColor(Color.init(hex: "271D76"))
                            .overlay(Capsule().stroke(LinearGradient(gradient: Gradient(colors: [Color.init(hex: "BC4571"), Color.init(hex: "102FC3")]), startPoint: .leading, endPoint: .trailing), lineWidth: 5))
                    })
                        .padding(.trailing, 20)
                }
                    .padding(.top, 13)
                Spacer()

            }
        }
        
    }
    
    func action() {
        if let product = store.product(for: SKProduct().productIdentifier) {
            store.purchaseProduct(product)
        }
        
    }
}

struct DonateView_Previews: PreviewProvider {
    static var previews: some View {
        DonateView()
    }
}
