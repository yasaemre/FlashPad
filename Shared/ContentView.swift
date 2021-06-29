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
            Home()
        } else {
            walkthrough
        }
    }
}
struct Home : View {
    
    @State var show = false
    @AppStorage("appleLogStatus") var appleLogStatus = false
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    
    @AppStorage("fbLogged") var fbLogged = false
    @AppStorage("fbEmail") var fbEmail = ""
    
    @AppStorage("googleLogged") var googleLogged = false
    @AppStorage("googleEmail") var googleEmail = ""

    var body: some View{
        
        NavigationView{
            
            VStack{
                
                if self.status || self.appleLogStatus || self.fbLogged || self.googleLogged {
                    Homescreen()
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
                                    
                                    self.fbLogged = UserDefaults.standard.value(forKey: "googleLogged") as? Bool ?? false
                                }
                print("\(fbEmail)")
                }

        }
    }
}

struct Homescreen : View {

    
    @AppStorage("fbLogged") var fbLogged = false
    @AppStorage("fbEmail") var fbEmail = ""
    
    @AppStorage("googleLogged") var googleLogged = false
    @AppStorage("googleEmail") var googleEmail = ""
    
    var body: some View{
        
        VStack{
            Text(fbLogged ? "FB email: \(fbEmail)" : "Other type of login successfully")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.black.opacity(0.7))
            Button(action: {

                UserDefaults.standard.set(false, forKey: "status")
                UserDefaults.standard.set(false, forKey: "appleLogStatus")
                UserDefaults.standard.set(false, forKey: "fbLogged")
                UserDefaults.standard.set(false, forKey: "googleLogged")

                NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                NotificationCenter.default.post(name: NSNotification.Name("appleLogStatus"), object: nil)
                NotificationCenter.default.post(name: NSNotification.Name("fbLogged"), object: nil)
                NotificationCenter.default.post(name: NSNotification.Name("googleLogged"), object: nil)
                
                try! Auth.auth().signOut()
                
            }) {
                
                Text("Log out")
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 50)
            }
            .background(Color("Color"))
            .cornerRadius(10)
            .padding(.top, 25)
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

