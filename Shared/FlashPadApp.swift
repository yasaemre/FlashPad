//
//  FlashCardsApp.swift
//  FlashCards
//
//  Created by Emre Yasa on 6/15/21.
//

import SwiftUI
import Firebase
import FBSDKLoginKit
import GoogleSignIn


@main
struct FlashCardsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    let persistenceController = PersistenceController.shared
    @Environment(\.scenePhase) var scenePhase
    
    @StateObject private var store = Store()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(store)
            
        }.onChange(of: scenePhase) { _ in
            persistenceController.saveContext()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate, GIDSignInDelegate {
    
    
    @AppStorage("logged") var logged = false
    @AppStorage("loggedViaEmail") var loggedViaEmail = ""
    
    static var orientationLock = UIInterfaceOrientationMask.all
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.orientationLock
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
         if let error = error {
           print(error.localizedDescription)
           return
         }

         guard let authentication = user.authentication else { return }
         let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                           accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential) { [self] (authResult, error) in
           if let error = error {
             print(error.localizedDescription)
             return
           }
             self.logged = true
             self.loggedViaEmail = authResult!.user.email!
               
             print("google email \(self.loggedViaEmail), googleLogged: \(self.logged) ")
         }
           
       }

       func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
           if let error = error {
             print(error.localizedDescription)
             return
           }
       }
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions:
            launchOptions
        )
        FirebaseApp.configure()
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self

        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {

        return ApplicationDelegate.shared.application(
            app,
            open: url,
            options: options
        )
    }
    
    
    
}
