//
//  HomeScreenView.swift
//  FlashPad
//
//  Created by Emre Yasa on 6/30/21.
//

import SwiftUI
import Firebase

struct HomeScreenView : View {

    
    @AppStorage("logged") var logged = false
    @AppStorage("loggedViaEmail") var loggedViaEmail = ""
    
    var body: some View{
        
        VStack{
            Text(verbatim: "Logged = \(logged)")
                .font(.body)
                .fontWeight(.bold)
                .foregroundColor(Color.black.opacity(0.7))
            Text("Email: \(loggedViaEmail)")
            Button(action: {

                UserDefaults.standard.set(false, forKey: "logged")
                UserDefaults.standard.set("", forKey: "loggedViaEmail")


                NotificationCenter.default.post(name: NSNotification.Name("logged"), object: nil)
                NotificationCenter.default.post(name: NSNotification.Name("loggedViaEmail"), object: nil)

                
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
