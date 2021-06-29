//
//  SignUpView.swift
//  FlashCards
//
//  Created by Emre Yasa on 6/18/21.
//
import SwiftUI
import Firebase

struct SignUpView : View {
    
    @State var color = Color.black.opacity(0.7)
    @State var email = ""
    @State var pass = ""
    @State var repass = ""
    @State var visible = false
    @State var revisible = false
    @Binding var show : Bool
    @State var alert = false
    @State var error = ""
    
    var body: some View{
        
        //ZStack(alignment: .top){
            
            ZStack(alignment: .topLeading) {
                                    
                VStack(alignment: .center) {
                        
                    
                    GeometryReader { geo in
                            Image("signUp")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geo.size.width, height:geo.size.height)
                    }
                    Spacer()
                        
                        Text("Log in to your account")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(self.color)
                        
                        TextField("Email", text: self.$email)
                        .autocapitalization(.none)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.email != "" ? Color("Color") : self.color,lineWidth: 2))
                        .padding(.top, 1)
                        
                        HStack(spacing: 15){
                            
                            VStack{
                                
                                if self.visible{
                                    
                                    TextField("Password", text: self.$pass)
                                    .autocapitalization(.none)
                                }
                                else{
                                    
                                    SecureField("Password", text: self.$pass)
                                    .autocapitalization(.none)
                                }
                            }
                            
                            Button(action: {
                                
                                self.visible.toggle()
                                
                            }) {
                                
                                Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(self.color)
                            }
                            
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.pass != "" ? Color("Color") : self.color,lineWidth: 2))
                        .padding(.top, 15)
                        
                        HStack(spacing: 15){
                            
                            VStack{
                                
                                if self.revisible{
                                    
                                    TextField("Re-enter", text: self.$repass)
                                    .autocapitalization(.none)
                                    
                                }
                                else{
                                    
                                    SecureField("Re-enter", text: self.$repass)
                                    .autocapitalization(.none)
                            
                                }
                            }
                            
                            Button(action: {
                                
                                self.revisible.toggle()
                                
                            }) {
                                
                                Image(systemName: self.revisible ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(self.color)
                            }
                            
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.repass != "" ? Color("Color") : self.color,lineWidth: 2))
                        .padding(.top, 15)
                        
                        Button(action: {
                            
                            self.register()
                        }) {
                            
                            Text("Register")
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 50)
                        }
                        .background(Color("Color"))
                        .cornerRadius(10)
                        .padding(.top, 15)
                        
                    }
                    .padding(.horizontal, 25)
                
                
                    
                
                
        
                //.navigationBarBackButtonHidden(true)
            
            
                Button(action: {
                    
                    self.show.toggle()
                    
                }) {
                    
                    Image(systemName: "chevron.left")
                        .font(.title)
                        .foregroundColor(Color("Color"))
                }
                .padding()
                if self.alert {
                    Spacer()

                    ErrorView(alert: self.$alert, error: self.$error)
                }
        }
        .navigationBarBackButtonHidden(true)
        
        
    }

    func register() {
        if !self.email.isEmpty {
            if self.pass == self.repass {
                Auth.auth().createUser(withEmail: self.email, password: self.pass) { result, error in
                    if error != nil {
                        self.error = error!.localizedDescription
                        self.alert.toggle()
                        return
                    }
                    
                    print("success")
                    UserDefaults.standard.set(true, forKey: "status")
                    NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
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

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(show: .constant(false))
    }
}

