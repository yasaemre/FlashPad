//
//  ProfileView.swift
//  FlashPad
//
//  Created by Emre Yasa on 9/12/21.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var name = ""
    @State private var lastName = ""
    @State private var age = ""
    @State private var sex = ""
    @State private var location = ""
    
    var body: some View {
        VStack(spacing: 30) {
            Button(action: {
                print("Profile button tapped")
            }) {
                Image("profilePhoto")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 90, height: 110)
            }
            
            Button(action: {
                print("Change profile photo tapped")
            }) {
                Text("Change Profile Photo")
            }
            
            Group {
                HStack(spacing:30) {
                    Text("Name: ")
                        .foregroundColor(Color.init(hex: "6C63FF"))
                        .font(.title)
                    VStack {
                        TextField("", text: $name)
                            .font(Font.system(size: 25, design: .default))
                        Divider()

                    }
                }
                
                
                
                
                HStack(spacing:30) {
                    Text("Last Name: ")
                        .foregroundColor(Color.init(hex: "6C63FF"))
                        .font(.title)
                    VStack {
                        TextField("", text: $lastName)
                            .font(Font.system(size: 25, design: .default))
                        Divider()
                    }

                }
                
                
                HStack(spacing:30){
                    Text("Age: ")
                        .foregroundColor(Color.init(hex: "6C63FF"))
                        .font(.title)
                    VStack {
                        TextField("", text: $age)
                            .font(Font.system(size: 25, design: .default))
                        Divider()
                    }

                }
                

                HStack(spacing:30) {
                    Text("Sex: ")
                        .foregroundColor(Color.init(hex: "6C63FF"))
                        .font(.title)
                    VStack {
                        TextField("", text: $sex)
                            .font(Font.system(size: 25, design: .default))
                        Divider()
                    }
                }
                

                HStack(spacing:30) {
                    Text("Location: ")
                        .foregroundColor(Color.init(hex: "6C63FF"))
                        .font(.title)

                    VStack {
                        TextField("", text: $location)
                            .font(Font.system(size: 25, design: .default))
                        Divider()
                    }
                }
                
                

            }
            .padding(.leading, 15)
            .padding(.trailing, 15)
            
            Spacer()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
