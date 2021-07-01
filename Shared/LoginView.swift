//
//  LoginView.swift
//  FlashCards
//
//  Created by Emre Yasa on 6/17/21.
//
import SwiftUI
import Firebase
import AuthenticationServices
import FBSDKLoginKit
import GoogleSignIn

struct LoginView: View {
    
    @State var color = Color.black.opacity(0.7)
    @State private var email = ""
    @State private var pass = ""
    @State private var isVisible = false
    @Binding var show:Bool
    @State var alert = false
    @State var error = ""
    
    @StateObject var loginData = AppleLoginViewModel()
    
    
    @AppStorage("logged") var logged = false
    @AppStorage("loggedViaEmail") var loggedViaEmail = ""
    
    @State var manager = LoginManager()
    
    var body: some View {

            Color.init(hex: "C8D4F5").ignoresSafeArea()
            .overlay(
                VStack(alignment: .center, spacing: 20) {
                    GeometryReader { geo in
                        Image("welcome")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geo.size.width, height:geo.size.height)
                    }
                    //Spacer()
            
                SignInWithAppleButton { request in
                    //requesting parameters from Apple login
                    loginData.nonce = loginData.randomNonceString(length: 10)
                    request.requestedScopes = [.email, .fullName]
                    request.nonce = loginData.sha256(loginData.nonce)
                } onCompletion: { result in
                    switch result {
                    case .success(let user):
                        print("Success")
                        guard let credential = user.credential as? ASAuthorizationAppleIDCredential else {
                            print("sign with Apple")
                            return
                        }
                        loginData.authenticate(credential: credential)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                .signInWithAppleButtonStyle(.white)
                .frame(width: 300, height: 50, alignment: .center)
                .cornerRadius(25)
                
                
                Button(action: {
                    print("Google button was tapped")
                    
                    GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.last?.rootViewController
                    GIDSignIn.sharedInstance()?.signIn()
                    
                }) {
                    HStack(spacing: 4) {
                        Image("google")
                            .resizable()
                            .frame(width: 17.0, height: 17.0)
                            .padding(.leading, 0)

                            Text("Sign in with Google")
                                .fontWeight(.semibold)
                                .font(.system(size: 18))
                                .multilineTextAlignment(.trailing)
                    }

                }
                    .frame(width: 300, height: 50, alignment: .center)
                    .background(Color.white)
                    .foregroundColor(.black)
                    .clipShape(Capsule())

                Button(action: {
                    print("Facebook button was tapped")
                    if logged {
                        manager.logOut()
                        loggedViaEmail = ""
                        logged = false
                    } else {
                        manager.logIn(permissions: ["public_profile", "email"], from: nil) { result, error in
                            if !result!.isCancelled {
                                if error != nil {
                                    print(error!.localizedDescription)
                                    return
                                }
                                if AccessToken.current != nil {
                                    let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
                                    
                                    Auth.auth().signIn(with: credential) { res, err in
                                        if err != nil {
                                            print(err!.localizedDescription)
                                            return
                                        }
                                        print("success fb login")
                                    }
                                }
                                
                                self.logged = true
                                let req = GraphRequest(graphPath: "me", parameters: ["fields": "email"])
                                
                                req.start { _, res, _ in
                                    //it will return as dict
                                    guard let profileData = res as? [String: Any] else {
                                        return
                                    }
                                    loggedViaEmail = profileData["email"] as! String
                                }
                            }
                        }
                    }
                    
                }) {
                    HStack(spacing: 6) {
                        Image("fb")
                            .resizable()
                            .frame(width: 15.0, height: 15.0)
                            .padding(.leading, 20)

                            Text("Sign in with Facebook")
                                .fontWeight(.semibold)
                                .font(.system(size: 18))
                                .padding(.leading, 0)
                                .multilineTextAlignment(.trailing)
                    }

                }
                .frame(width: 300, height: 50, alignment: .center)
                .background(Color.white)
                .foregroundColor(.black)
                .border(Color.white, width: 2)
                .cornerRadius(25)
                
                Text("OR")
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                
                TextField(
                    "Email",
                    text:$loggedViaEmail)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 4).stroke(self.loggedViaEmail != "" ? Color("Color") : self.color, lineWidth: 2))
                    .foregroundColor(.white)
                
                HStack(spacing: 15) {
                    
                    VStack {
                        if self.isVisible {
                            TextField("Password", text: self.$pass)
                                .autocapitalization(.none)
                        } else {
                            SecureField("Password", text: self.$pass)
                                .autocapitalization(.none)
                        }
                    }
                    .foregroundColor(.white)
                    Button(action: {
                        self.isVisible.toggle()
                    }) {
                        Image(systemName: self.isVisible ? "eye.slash.fill" : "eye.fill").foregroundColor(self.color)
                    }

                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 4).stroke(self.pass != "" ? Color("Color") : self.color, lineWidth: 2))
                //.padding(.top)
                   
                HStack {
                    
                    Spacer()
                    
                    Button(action: {
                        self.reset()
                    }) {
                        Text("Forget password")
                            .fontWeight(.bold)
                            .foregroundColor(Color("Color"))
                    }
                }
                
                HStack(spacing: 30) {
                    
                    Button(action: {
                        print("Login button was tapped")
                        self.verify()
                    }) {
                        Text("Login")
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.trailing)
                    }
                    .frame(width: 100, height: 40, alignment: .center)
                    .background(Color.init(hex: "6C63FF"))
                    .foregroundColor(.white)
                    .cornerRadius(25)
                    
                    Button(action: {
                        print("Register button was tapped")
                        self.show.toggle()
                    }) {
                        Text("Register")
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.trailing)
                    }
                    .frame(width: 100, height: 40, alignment: .center)
                    .background(Color.init(hex: "6C63FF"))
                    .foregroundColor(.white)
                    .cornerRadius(25)
                }
                
                Text("Continue without sign in")
                    .fontWeight(.light)
                    .foregroundColor(.white)
                 
                
            }
                    .padding(.horizontal, 25)
                
            )
        if self.alert {
            ErrorView(alert: self.$alert, error: self.$error)
                .font(.system(size: 14))
                .frame(width: 300, height: 150, alignment: .center)
                .opacity(0.9)
        }
    
    }

    
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

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(show: .constant(false))
    }
}
