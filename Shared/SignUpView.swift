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
    
    @State var color = Color.black.opacity(1.0)
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
                    GeometryReader { geo in
                        Image("signup")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geo.size.width, height:geo.size.height)
                    }
                    Text("Log in to your account")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(self.color)
                        .padding(.top, 100)
                    TextField("", text: self.signUpVM.$loggedViaEmail)
                        .placeholder(when: self.signUpVM.loggedViaEmail.isEmpty) {
                                Text("Email").foregroundColor(.gray)
                        }
                        .autocapitalization(.none)
                        .padding()
                        .foregroundColor(Color(.systemGray4))
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.signUpVM.loggedViaEmail != "" ? Color(.systemRed) : self.color,lineWidth: 2))
                        .padding(.top, 1)
              

                    HStack(spacing: 15){
                        
                        VStack{
                            
                            if self.visible{
                                
                                TextField("", text: self.$signUpVM.pass)
                                    .placeholder(when: self.signUpVM.pass.isEmpty) {
                                            Text("Password").foregroundColor(.gray)
                                    }
                                    .autocapitalization(.none)
                                    .foregroundColor(self.color)

                            }
                            else{
                                
                                SecureField("", text: self.$signUpVM.pass)
                                    .placeholder(when: self.signUpVM.pass.isEmpty) {
                                            Text("Password").foregroundColor(.gray)
                                    }
                                    .autocapitalization(.none)
                                    .foregroundColor(self.color)

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
                    .foregroundColor(Color(.systemGray4))
                    .background(RoundedRectangle(cornerRadius: 4).stroke(self.signUpVM.pass != "" ? Color(.systemRed) : self.color,lineWidth: 2))
                    .padding(.top, 5)

                    
                    HStack(spacing: 15){
                        
                        VStack{
                            
                            if self.revisible{
                                
                                TextField("", text: self.$signUpVM.repass)
                                    .placeholder(when: self.signUpVM.repass.isEmpty) {
                                            Text("Re-enter").foregroundColor(.gray)
                                    }
                                    .autocapitalization(.none)
                                    .foregroundColor(self.color)

                                
                            }
                            else{
                                
                                SecureField("Re-enter", text: self.$signUpVM.repass)
                                    .placeholder(when: self.signUpVM.repass.isEmpty) {
                                            Text("Re-enter").foregroundColor(.gray)
                                    }
                                    .autocapitalization(.none)
                                    .foregroundColor(self.color)

                                
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
                    .foregroundColor(Color(.systemGray4))
                    .background(RoundedRectangle(cornerRadius: 4).stroke(self.signUpVM.repass != "" ? Color(.systemRed) : self.color,lineWidth: 2))
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

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
