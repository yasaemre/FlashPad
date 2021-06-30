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

    private var walkthrough = WalkthroughView()
    @State var show = false
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    //@State var appleLogStatus = UserDefaults.standard.value(forKey: "appleLogStatus") as? Bool ?? false
    var body: some View {
        if currentPage > totalPages {
            HomeView()
        } else {
            walkthrough
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

