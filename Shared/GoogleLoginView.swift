//
//  GoogleLoginView.swift
//  FlashPad (iOS)
//
//  Created by Emre Yasa on 6/28/21.
//

import SwiftUI
import GoogleSignIn
import Firebase

struct GoogleLoginView: UIViewRepresentable {
    
    func makeCoordinator() -> GoogleLoginView.Coordinator {
        return GoogleLoginView.Coordinator()
    }
    
    class Coordinator: NSObject, GIDSignInDelegate {
        func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
          if let error = error {
            print(error.localizedDescription)
            return
          }

          guard let authentication = user.authentication else { return }
          let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                            accessToken: authentication.accessToken)
          Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
              print(error.localizedDescription)
              return
            }
            print("signIn result: " + authResult!.user.email!)
          }
            
        }
    }
    
    func makeUIView(context: UIViewRepresentableContext<GoogleLoginView>) -> GIDSignInButton {
        let view = GIDSignInButton()
        
        return view
    }
    
    func updateUIView(_ uiView: GIDSignInButton, context: UIViewRepresentableContext<GoogleLoginView>) { }
}
