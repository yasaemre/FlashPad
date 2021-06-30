//
//  HomeView.swift
//  FlashPad
//
//  Created by Emre Yasa on 6/30/21.
//

import SwiftUI

struct HomeView : View {
    
    @State var show = false
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    
    @AppStorage("appleLogStatus") var appleLogStatus = false
    
    @AppStorage("fbLogged") var fbLogged = false
    @AppStorage("fbEmail") var fbEmail = ""
    
    @AppStorage("googleLogged") var googleLogged = false
    @AppStorage("googleEmail") var googleEmail = ""

    var body: some View{
        
        NavigationView{
            
            VStack{
                
                if self.status || self.appleLogStatus || self.fbLogged || self.googleLogged {
                    HomeScreenView()
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
                
                NotificationCenter.default.addObserver(forName: NSNotification.Name("status"), object: nil, queue: .main) { (_) in
                    
                    self.status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
                }
                
                NotificationCenter.default.addObserver(forName: NSNotification.Name("appleLogStatus"), object: nil, queue: .main) { (_) in
                    
                    self.appleLogStatus = UserDefaults.standard.value(forKey: "appleLogStatus") as? Bool ?? false
                }
                
                NotificationCenter.default.addObserver(forName: NSNotification.Name("fbLogged"), object: nil, queue: .main) { (_) in
                                    
                                    self.fbLogged = UserDefaults.standard.value(forKey: "fbLogged") as? Bool ?? false
                                }
                
                NotificationCenter.default.addObserver(forName: NSNotification.Name("googleLogged"), object: nil, queue: .main) { (_) in
                                    
                                    self.googleLogged = UserDefaults.standard.value(forKey: "googleLogged") as? Bool ?? false
                                }
                print("\(fbEmail)")
                }

        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
