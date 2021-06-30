//
//  HomeScreenView.swift
//  FlashPad
//
//  Created by Emre Yasa on 6/30/21.
//

import SwiftUI
import Firebase

struct HomeScreenView : View {

    
    @AppStorage("fbLogged") var fbLogged = false
    @AppStorage("fbEmail") var fbEmail = ""
    
    @AppStorage("googleLogged") var googleLogged = false
    @AppStorage("googleEmail") var googleEmail = ""
    
    var body: some View{
        
        VStack{
            Text(fbLogged ? "FB email: \(fbEmail)" : "Other type of login successfully")
                .font(.body)
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


struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}
