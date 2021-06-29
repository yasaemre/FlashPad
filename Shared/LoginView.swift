//
//  LoginView.swift
//  FlashCards
//
//  Created by Emre Yasa on 6/17/21.
//
import SwiftUI
import Firebase
import AuthenticationServices
//import FBSDKLoginKit

struct LoginView: View {
    
    @State var color = Color.black.opacity(0.7)
    @State private var email = ""
    @State private var pass = ""
    @State private var isVisible = false
    @Binding var show:Bool
    @State var alert = false
    @State var error = ""
    
    @StateObject var loginData = LoginViewModel()
    
    @AppStorage("fbLogged") var fbLogged = false
    @AppStorage("fbEmail") var fbEmail = ""
    
    var body: some View {

            Color.init(hex: "5A80E1").ignoresSafeArea()
            .overlay(
                VStack(alignment: .center, spacing: 20) {
                    GeometryReader { geo in
                        Image("welcome")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geo.size.width, height:geo.size.height)
                    }
                    Spacer()

//                Button(action: {
//                    print("Apple button was tapped")
//                    SignInWithAppleButton { request in
//                        //requesting parameters from Apple login
//                        loginData.nonce = loginData.randomNonceString(length: 10)
//                        request.requestedScopes = [.email, .fullName]
//                        request.nonce = loginData.sha256(loginData.nonce)
//                    } onCompletion: { result in
//                        switch result {
//                        case .success(let user):
//                            print("Success")
//                            guard let credential = user.credential as? ASAuthorizationAppleIDCredential else {
//                                print("error with Firabase")
//                                return
//                            }
//                            loginData.authenticate(credential: credential)
//                        case .failure(let error):
//                            print(error.localizedDescription)
//                        }
//                    }
//                }) {
//                        HStack(spacing: 40) {
//                            Image("apple")
//                                .resizable()
//                                .frame(width: 32.0, height: 32.0)
//
//                                Text("Continue with Apple")
//                                    .fontWeight(.semibold)
//                                    .multilineTextAlignment(.trailing)
//                        }
//
//                    }
//                    .frame(width: 300, height: 50, alignment: .center)
//                    .background(Color.white)
//                    .foregroundColor(.black)
//                    .border(Color.white, width: 2)
//                    .cornerRadius(25)
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
                            print("error with Firabase")
                            return
                        }
                        loginData.authenticate(credential: credential)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                .frame(width: 300, height: 50, alignment: .center)
                .clipShape(Capsule())
                
                
                Button(action: {
                    print("Google button was tapped")
                }) {
                    HStack(spacing: 40) {
                        Image("google")
                            .resizable()
                            .frame(width: 32.0, height: 32.0)
                            
                            Text("Continue with Google")
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.trailing)
                    }
                    
                }
                .frame(width: 300, height: 50, alignment: .center)
                .background(Color.white)
                .foregroundColor(.black)
                .border(Color.white, width: 2)
                .cornerRadius(25)
                

                FBLoginView()
                    .frame(width: 300, height: 50, alignment: .center)
                    .background(Color.white)
                    .foregroundColor(.black)
                    .cornerRadius(25)
                
//                Button(action: {
//                    print("Facebook button was tapped")
//                }) {
//                    HStack(spacing: 40) {
//                        Image("fb")
//                            .resizable()
//                            .frame(width: 32.0, height: 32.0)
//
//                            Text("Continue with Apple")
//                                .fontWeight(.semibold)
//                                .multilineTextAlignment(.trailing)
//                    }
//
//                }
//                .frame(width: 300, height: 50, alignment: .center)
//                .background(Color.white)
//                .foregroundColor(.black)
//                .border(Color.white, width: 2)
//                .cornerRadius(25)
                
//                Text("OR")
//                    .fontWeight(.semibold)
//                    .foregroundColor(.white)
                TextField(
                    "Email",
                    text: $email)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 4).stroke(self.email != "" ? Color("Color") : self.color, lineWidth: 2))
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
    func continueWithApple() {
        print("dsf")
    }
    
    func verify() {
        if self.email != "" && self.pass != "" {
            Auth.auth().signIn(withEmail: self.email, password: self.pass) { res, error in
                if error != nil {
                    self.error = error!.localizedDescription
                    self.alert.toggle()
                    return
                }
                UserDefaults.standard.set(true, forKey: "status")
                NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
            }
        } else {
            self.error = "Please fill all the contents properly"
            self.alert.toggle()
        }
        
    }
    
    func reset() {
        if self.email != "" {
            Auth.auth().sendPasswordReset(withEmail: self.email) { error in
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

struct FBLoginView: UIViewRepresentable {

    func makeCoordinator() -> FBLoginView.Coordinator {
        
        return FBLoginView.Coordinator()
    }

    func makeUIView(context: UIViewRepresentableContext<FBLoginView>) -> FBLoginButton {
        let button = FBLoginButton()
        button.delegate = context.coordinator
        button.permissions = ["email", "public_profile"]
        return button
    }
    
    func updateUIView(_ uiView: FBLoginButton, context: UIViewRepresentableContext<FBLoginView>) {
        
    }
    
    class Coordinator: NSObject, LoginButtonDelegate {
        @AppStorage("fbLogged") var fbLogged = false

        func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
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
                    self.fbLogged = true
                    print("success fb login")
                }
            }
        }
        
        func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
            try! Auth.auth().signOut()
        }
    
    }
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView(show: .constant(false))
//    }
//}
