//
//  HomeView.swift
//  FlashPad
//
//  Created by Emre Yasa on 6/30/21.
//

import SwiftUI

struct HomeView : View {
    
    @State var show = false
    //@State var logged = UserDefaults.standard.value(forKey: "logged") as? Bool ?? false
    @AppStorage("logged") var logged = false
    @AppStorage("loggedViaEmail") var loggedViaEmail = ""


    var body: some View{
        
        NavigationView{
            
            VStack{
                
                if self.logged {
                    HomeScreenView().navigationBarHidden(true)
                }
                else{
                    
                    ZStack{
                        
                        NavigationLink(destination: SignUpView(show: self.$show), isActive: self.$show) {
                        }
                        .hidden()
                        
                        LoginView(show: self.$show)
                    }
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .onAppear {
                
                NotificationCenter.default.addObserver(forName: NSNotification.Name("logged"), object: nil, queue: .main) { (_) in
                    
                    self.logged = UserDefaults.standard.value(forKey: "logged") as? Bool ?? false
                }
                
                print("\(loggedViaEmail)")
                }

        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
