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

   // @StateObject var store = Store()
    @State var product = ""
    var body: some View {
        ZStack(alignment: .top) {
            if colorScheme == .light {
                LinearGradient(gradient: Gradient(colors: [.white, Color.init(hex:"81329b")]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.bottom)
            } else {
                LinearGradient(gradient: Gradient(colors: [.black,.black, Color.init(hex:"81329b")]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.bottom)
            }
            VStack(spacing: 5){
                
                Image("donation2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .padding(.top, 1)
                    .tint(Color.init(hex: "102FC3"))

                Text("Support development of the app, FlashPad is a free and open application, developed by a small team. The heart and soul of FlashPad is our global community of tons of users, and donors like yourself – all united to share unlimited access to well structured app. Your donations keep our knowledge projects like FlashPad freely available to everyone. Please help us keep FlashPad growing.")
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    .frame(width: UIScreen.main.bounds.width - 60)
                    .padding(.top, 1)
                
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(LinearGradient(gradient: Gradient(colors: [Color.init(hex: "BC4571"), Color.init(hex: "102FC3")]), startPoint: .leading, endPoint: .trailing))
                    .frame(width: 300, height: 50)
                    .shadow(color: Color(UIColor(.black)), radius: 10, x: 5, y: 5)
                    .overlay(
                    
                        Text("Select one time donation amount")
                            .foregroundColor(.white)
                    
                    )
                    .padding(.top, 13)
                
                Picker(selection:$product, label: Text("Picker"), content: {
                    Text("$0.99")
                        .tag( "emre.FlashPad.donation")

                    Text("$3.99").tag("emre.FlashPad.donation2")
                    Text("$6.99").tag("emre.FlashPad.donation3")
                    Text("$9.99").tag("emre.FlashPad.donation4")
                })
                    .pickerStyle(SegmentedPickerStyle())
                    .labelsHidden()
                    .font(.title2)
                    .padding([.leading, .trailing])
                    .overlay(Capsule().stroke(LinearGradient(gradient: Gradient(colors: [Color.init(hex: "BC4571"), Color.init(hex: "102FC3")]), startPoint: .leading, endPoint: .trailing), lineWidth: 3))
                    //.frame(maxWidth: .infinity, maxHeight: 20)
                    .padding(.top, 15)

                
                HStack {
                    Spacer()
                    Button(action: {
                        action(p: product)
                    }, label: {
                        Text("Continue")
                            .font(.title)
                            .frame(width: 150, height: 45)
                            //.foregroundColor(Color.init(hex: "271D76"))
                            .foregroundColor(.white)
//                            .overlay(Capsule().stroke(LinearGradient(gradient: Gradient(colors: [Color.init(hex: "BC4571"), Color.init(hex: "102FC3")]), startPoint: .leading, endPoint: .trailing), lineWidth: 5))
                            .background(LinearGradient(gradient: Gradient(colors: [Color.init(hex: "BC4571"), Color.init(hex: "102FC3")]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(20)
                    })
                        .padding(.trailing, 20)
                }
                    .padding(.top, 13)
                Spacer()

            }
        }
        
    }
    
    func action(p:String) {
        //ForEach(0..<store.allProducts, id: \.self) { indexP in
            if let product = store.product(for:p) {
                store.purchaseProduct(product)
            }
       //}
        
    }
}

struct DonateView_Previews: PreviewProvider {
    static var previews: some View {
        DonateView()
    }
}
