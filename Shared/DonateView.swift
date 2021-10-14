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
    
    @State private var pickedTab = "emre.FlashPad.donation2"

    @State var product = ""
    var body: some View {
        ZStack(alignment: .top) {
            if colorScheme == .light {
                LinearGradient(gradient: Gradient(colors: [.white, Color.init(hex:"81329b")]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.bottom)
            } else {
                LinearGradient(gradient: Gradient(colors: [.black,.black, Color.init(hex:"81329b")]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.bottom)
            }
            GeometryReader { geo in
                VStack(spacing: 1){
                    
                    Image("donation2")
                        .resizable()
                        .scaledToFit()
                        .frame(width:  geo.size.width * 0.2, height: geo.size.height * 0.2)
                        .tint(Color.init(hex: "102FC3"))
                    
                    Text("Support development of the app, FlashPad is a free and open application, developed by a small team. The heart and soul of FlashPad is our global community of users, and donors like yourself – all united to share unlimited access to well structured app. Your donations will keep projects like FlashPad freely available to everyone. Please help us keep FlashPad growing.")
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .frame(width: geo.size.width * 0.9, height: geo.size.height * 0.4)
                        
                    
                    
                    RoundedRectangle(cornerRadius: 10)
                        .fill(LinearGradient(gradient: Gradient(colors: [Color.init(hex: "BC4571"), Color.init(hex: "102FC3")]), startPoint: .leading, endPoint: .trailing))
                        .frame(width:  geo.size.width * 0.8, height: geo.size.height * 0.06)
                        .shadow(color: Color(UIColor(.black)), radius: 10, x: 5, y: 5)
                        .overlay(
                            
                            Text("Select one time donation amount")
                                .foregroundColor(.white)
                                .font(.caption)
                        )
                    
                    Picker(selection:$product, label: Text("Picker"), content: {
                        Text("$0.99").tag( "com.emre.FlashPad.donation")
                        Text("$3.99").tag("com.emre.FlashPad.donation2")
                        Text("$6.99").tag("com.emre.FlashPad.donation3")
                        Text("$9.99").tag("com.emre.FlashPad.donation4")
                    })
                        .pickerStyle(SegmentedPickerStyle())
                        .labelsHidden()
                        .font(.title2)
                        .frame(width:  geo.size.width * 0.8, height: geo.size.height * 0.07)
                        .overlay(Capsule().stroke(LinearGradient(gradient: Gradient(colors: [Color.init(hex: "BC4571"), Color.init(hex: "102FC3")]), startPoint: .leading, endPoint: .trailing), lineWidth: 3))
                        .padding(.top, geo.size.height * 0.02)
                    
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            action(p: product)
                        }, label: {
                            Text("Continue")
                                .font(.title2)
                                .frame(width:  geo.size.width * 0.3, height: geo.size.height * 0.06)
                                .foregroundColor(.white)
                          
                                .background(LinearGradient(gradient: Gradient(colors: [Color.init(hex: "BC4571"), Color.init(hex: "102FC3")]), startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(20)
                        })
                            .padding(.trailing, geo.size.width * 0.1 )
                            
                    }
                    .padding(.top, geo.size.height * 0.02)
                    Spacer()
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
        }
        
    }
    
    func action(p:String) {
            if let product = store.product(for:p) {
                store.purchaseProduct(product)
            }        
    }
}

struct DonateView_Previews: PreviewProvider {
    static var previews: some View {
        DonateView()
    }
}
