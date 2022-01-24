//
//  ContentView.swift
//  FlashCards
//
//  Created by Emre Yasa on 6/15/21.
//
import SwiftUI
import Firebase
import FBSDKLoginKit


struct ContentView: View {

    @AppStorage("currentPage") var currentPage = 1

    @State var show = false
    @State var logged = UserDefaults.standard.value(forKey: "logged") as? Bool ?? false
    var body: some View {
        if currentPage > totalPages {
            HomeView().navigationBarHidden(true)
                .onAppear {
                    UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
                    AppDelegate.orientationLock = .portrait
                }

        } else {
            WalkthroughView()
                .onAppear {
                    UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
                    AppDelegate.orientationLock = .portrait
                }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

