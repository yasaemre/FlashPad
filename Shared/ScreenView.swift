//
//  ScreenView.swift
//  FlashCards
//
//  Created by Emre Yasa on 6/17/21.
//
import SwiftUI

struct ScreenView: View {
    
    var image: String
    var title: String
    var detail: String
    @AppStorage("currentPage") var currentPage = 1
    
    var body: some View {
        VStack(spacing: 20) {
            
            HStack {

                if currentPage == 1 {
                } else {
                    //Back Button
                    Button(action: {
                        withAnimation(.easeInOut) {
                            currentPage -= 1
                        }
                    }, label:{
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .padding(.vertical,10)
                            .padding(.horizontal)
                            .background(Color.black.opacity(0.4))
                            .cornerRadius(10)
                        
                    })
                
                }
                Spacer()
                
                Button(action: {
                    withAnimation(.easeInOut){
                        currentPage = 5
                    }
                }) {
                    Text("Skip")
                        .foregroundColor(.gray)
                        .fontWeight(.semibold)
                        .kerning(1.2)
                }
            }
            .foregroundColor(.white)
            .padding()
            
            
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.init(hex: "5A80E1"))
                .padding(.top)
            
            Text(detail)
                .fontWeight(.none)
                .kerning(1.1)
                .multilineTextAlignment(.center)
                .padding()
            
            //Min spacing when Phone is reducing
            Spacer(minLength: 120)
        }
    }
}

struct ScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ScreenView(image: "dsfds", title: "Wilcomen", detail: "hjkdsf asdf;das fdsf s; fasd")
    }
}
