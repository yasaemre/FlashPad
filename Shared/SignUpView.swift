//
//  SignUpView.swift
//  FlashPad
//
//  Created by Emre Yasa on 6/18/21.
//
import SwiftUI
import Firebase
import QuartzCore

struct SignUpView : View {
    
    @State var color = Color.black.opacity(0.7)
    @State var visible = false
    @State var revisible = false
    @Binding var show : Bool

    @Environment(\.presentationMode) var presentation
    
    @AppStorage("logged") var logged = false
    @AppStorage("loggedViaEmail") var loggedViaEmail = ""
    @ObservedObject var signUpVM = SignUpViewModel()
    
    
    var body: some View {
        
        Color.white.ignoresSafeArea()
            .overlay(
                ZStack(alignment: .center) {
                VStack(alignment: .center) {
                    Image("signUp")
                        .frame(minWidth: 50, idealWidth: 100, maxWidth: 200, minHeight: 25, idealHeight: 50, maxHeight: 100, alignment: .center)
                        .padding(.top, 75)
                        .aspectRatio(contentMode: .fit)
                
                    Text("Log in to your account")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(self.color)
                        .padding(.top, 100)
                    TextField("Email", text: self.signUpVM.$loggedViaEmail)
                        .autocapitalization(.none)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.signUpVM.loggedViaEmail != "" ? Color("Color") : self.color,lineWidth: 2))
                        .padding(.top, 1)
                    
                    HStack(spacing: 15){
                        
                        VStack{
                            
                            if self.visible{
                                
                                TextField("Password", text: self.$signUpVM.pass)
                                    .autocapitalization(.none)
                            }
                            else{
                                
                                SecureField("Password", text: self.$signUpVM.pass)
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
                    .background(RoundedRectangle(cornerRadius: 4).stroke(self.signUpVM.pass != "" ? Color("Color") : self.color,lineWidth: 2))
                    .padding(.top, 5)
                    
                    HStack(spacing: 15){
                        
                        VStack{
                            
                            if self.revisible{
                                
                                TextField("Re-enter", text: self.$signUpVM.repass)
                                    .autocapitalization(.none)
                                
                            }
                            else{
                                
                                SecureField("Re-enter", text: self.$signUpVM.repass)
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
                    .background(RoundedRectangle(cornerRadius: 4).stroke(self.signUpVM.repass != "" ? Color("Color") : self.color,lineWidth: 2))
                    .padding(.top, 5)
                    
                    Button(action: {
                        
                        signUpVM.register()
                    }) {
                        
                        Text("Register")
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.trailing)
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 50)
                    }
                    .background(Color.init(hex: "6C63FF"))
                    .cornerRadius(10)
                    .padding(.top, 35)
                    .padding(.bottom, 100)
                    
                }
                .padding(.horizontal, 25)
                Spacer()
                
                
                if self.signUpVM.alert {
                    Spacer()
                    ErrorView(alert: self.$signUpVM.alert, error: self.$signUpVM.error)
                }
            }
            .navigationBarBackButtonHidden(true)
                    .toolbar(content: {
                ToolbarItem (placement: .navigationBarLeading)  {
                   Image(systemName: "arrow.left")
                        .foregroundColor(Color.init(hex: "6C63FF"))
                   .onTapGesture {
                       // code to dismiss the view
                       self.presentation.wrappedValue.dismiss()
                   }
                }
             })
        )
    }
    
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SignUpView(show: .constant(false))
        }
    }
}

