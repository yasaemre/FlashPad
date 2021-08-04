//
//  CardView.swift
//  FlashPad
//
//  Created by Emre Yasa on 8/3/21.
//

import SwiftUI

struct CardView: View {
    @State var card:Card
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(LinearGradient(gradient: Gradient(colors: [Color.init(hex: "6C63FF"), Color.init(hex: "c8d4f5")]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .frame(width: 250, height: 350)
            .shadow(color: Color(UIColor(.black)), radius: 10, x: 5, y: 5)
            .overlay(
                VStack(alignment: card.image != "" ? .center : .leading, spacing: 10) {
                
                
                if card.image != "" {
                    Image(card.image)
                    
                }
                //Image(card.image)
                Text(card.word)
                    .font(.title2)
                    .foregroundColor(.white)
                
                if card.definition != "" {
                    Text(card.definition)
                        .font(.body)
                        .foregroundColor(.white)
                }
            }
            )
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card(word: "asa", definition: "dafds", image: "sdf"))
    }
}
