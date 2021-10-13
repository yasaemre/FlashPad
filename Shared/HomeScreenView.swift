//
//  HomeScreenView.swift
//  FlashPad
//
//  Created by Emre Yasa on 6/30/21.
//

import SwiftUI
import Firebase

struct HomeScreenView : View {

    var body: some View{
        ZStack {
            TabBarView()
        }
        .navigationBarHidden(true)
        
    }
}


struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}
