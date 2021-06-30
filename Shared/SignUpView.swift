//
//  SignUpView.swift
//  FlashCards
//
//  Created by Emre Yasa on 6/18/21.
//
import SwiftUI
import Firebase
import QuartzCore

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
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        
        Color.white.ignoresSafeArea()
            .overlay(
                ZStack(alignment: .center) {
                VStack(alignment: .center) {

                    Image("signUp")
                        .frame(minWidth: 50, idealWidth: 100, maxWidth: 200, minHeight: 25, idealHeight: 50, maxHeight: 100, alignment: .center)
                        .aspectRatio(contentMode: .fit)
                
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
                    .padding(.top, 5)
                    
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
                    .padding(.top, 5)
                    
                    Button(action: {
                        
                        self.register()
                    }) {
                        
                        Text("Register")
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 50)
                    }
                    .background(.pink)
                    .cornerRadius(10)
                    .padding(.top, 35)
                    
                }
                .padding(.horizontal, 25)
                Spacer()
                
                
                if self.alert {
                    Spacer()
                    ErrorView(alert: self.$alert, error: self.$error)
                        .frame(width: 300, height: 250, alignment: .center)
                        .cornerRadius(22)
                        .opacity(0.9)
                }
            }
            .navigationBarBackButtonHidden(true)
                    .toolbar(content: {
                ToolbarItem (placement: .navigationBarLeading)  {
                   Image(systemName: "arrow.left")
                        .foregroundColor(.pink)
                   .onTapGesture {
                       // code to dismiss the view
                       self.presentation.wrappedValue.dismiss()
                   }
                }
             })
        )
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

