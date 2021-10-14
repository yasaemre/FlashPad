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
            TabBarView().toolbar {
                ToolbarItem(placement: .navigation) {
                    Button(action: toggleSidebar, label: { // 1
                        Image(systemName: "sidebar.leading")
                    })
                }
            }

        }
        .navigationBarHidden(true)
        
    }
    private func toggleSidebar() { // 2
          #if os(iOS)
          #else
          NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
          #endif
      }
}


struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}
