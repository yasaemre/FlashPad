//
//  SignUpViewModel.swift
//  FlashPad
//
//  Created by Emre Yasa on 7/1/21.
//

import Foundation
import Firebase
import SwiftUI

class SignUpViewModel: ObservableObject {
    
 
    @Published var pass = ""
    @Published var repass = ""
    @Published var alert = false
    @Published var error = ""
    
    @AppStorage("logged") var logged = false
    @AppStorage("loggedViaEmail") var loggedViaEmail = ""
    
    func register() {
        if !self.loggedViaEmail.isEmpty {
            if self.pass == self.repass {
                Auth.auth().createUser(withEmail: self.loggedViaEmail, password: self.pass) { result, error in
                    if error != nil {
                        self.error = error!.localizedDescription
                        self.alert.toggle()
                        return
                    }
                    
                    print("success")
                    UserDefaults.standard.set(true, forKey: "logged")
                    NotificationCenter.default.post(name: NSNotification.Name("logged"), object: nil)
                }
            } else {
                self.error = "Password mismatch"
                self.alert.toggle()
            }
        } else {
            self.error = "Please fill the all contents properly"
            self.alert.toggle()
        }
    }
}
