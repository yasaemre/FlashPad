//
//  LogoutButtonView.swift
//  FlashPad
//
//  Created by Emre Yasa on 7/1/21.
//

import SwiftUI
import Firebase

struct LogoutButtonView: View {
    @AppStorage("logged") var logged = false
    @AppStorage("loggedViaEmail") var loggedViaEmail = ""
    
    var body: some View{
        
        VStack{
            
            Button(action: {

                UserDefaults.standard.set(false, forKey: "logged")
                UserDefaults.standard.set("", forKey: "loggedViaEmail")


                NotificationCenter.default.post(name: NSNotification.Name("logged"), object: nil)
                NotificationCenter.default.post(name: NSNotification.Name("loggedViaEmail"), object: nil)

                
                try! Auth.auth().signOut()
                
            }) {
                
                HStack(alignment: .center, spacing:22) {
                    Image(systemName: "pip.exit")
                        .resizable()
                        .frame(width: 25, height: 25)
                    Text("Log out")
                }
                Spacer()
            }
            .padding(.top, 25)
        }
    }

}

struct LogoutButtonView_Previews: PreviewProvider {
    static var previews: some View {
        LogoutButtonView()
    }
}
