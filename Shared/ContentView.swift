//
//  ContentView.swift
//  FlashCards
//
//  Created by Emre Yasa on 6/15/21.
//
import SwiftUI
import Firebase

struct ContentView: View {

    @AppStorage("currentPage") var currentPage = 1

    //private var walkthrough = WalkthroughView()
    @State var show = false
    @State var logged = UserDefaults.standard.value(forKey: "logged") as? Bool ?? false
    //@State var appleLogStatus = UserDefaults.standard.value(forKey: "appleLogStatus") as? Bool ?? false
    var body: some View {
        if currentPage > totalPages {
            HomeView().navigationBarHidden(true)
                .onAppear {
                    UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
                    AppDelegate.orientationLock = .portrait
                }
//                .onDisappear {
//                    AppDelegate.orientationLock = .all
//                }

        } else {
            WalkthroughView()
                .onAppear {
                    UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
                    AppDelegate.orientationLock = .portrait
                }
//                .onDisappear {
//                    AppDelegate.orientationLock = .all
//                }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

