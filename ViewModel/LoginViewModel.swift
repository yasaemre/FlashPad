//
//  LoginViewModel.swift
//  FlashPad
//
//  Created by Emre Yasa on 7/2/21.
//

import Firebase
import SwiftUI


class LoginViewModel: ObservableObject {
    @Published var pass = ""
    @Published var repass = ""
    @Published var alert = false
    @Published var error = ""
    
    @AppStorage("logged") var logged = false
    @AppStorage("loggedViaEmail") var loggedViaEmail = ""
    func verify() {
        if self.loggedViaEmail != "" && self.pass != "" {
            Auth.auth().signIn(withEmail: self.loggedViaEmail, password: self.pass) { res, error in
                if error != nil {
                    self.error = error!.localizedDescription
                    self.alert.toggle()
                    return
                }
                UserDefaults.standard.set(true, forKey: "logged")
                NotificationCenter.default.post(name: NSNotification.Name("logged"), object: nil)
            }
        } else {
            self.error = "Please fill all the contents properly"
            self.alert.toggle()
        }
        
    }
    
    func reset() {
        if self.loggedViaEmail != "" {
            Auth.auth().sendPasswordReset(withEmail: self.loggedViaEmail) { error in
                if let error = error {
                    self.error = error.localizedDescription
                    self.alert.toggle()
                    return
                }
                
                self.error = "RESET"
                self.alert.toggle()
            }
        } else {
            self.error = "Email ID is empty"
            self.alert.toggle()
        }
        
    }

}
