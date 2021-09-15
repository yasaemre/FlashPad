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
    @State private var isShowingPhotoPicker = false
    @State private var avatarImage = UIImage(named: "profilePhoto")!
    @State private var avatarImageData:Data? = Data()
    @State private var imageHasChanged = false
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ProfileCore.id, ascending: true)],
           animation: .default)
       private var profileArrPersistent: FetchedResults<ProfileCore>
    
    @StateObject var profileCore = ProfileCore()
    @State private var index = 0

    var body: some View {

        VStack(spacing: 30) {
            
            if imageHasChanged == true {
                if let imgData = avatarImageData{
                    Image(uiImage: UIImage(data: imgData) ?? avatarImage)
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 150, height: 150)
                    .padding()
                    .onTapGesture {isShowingPhotoPicker = true}
                }
            } else {
                if let image = profileArrPersistent.last?.image{
                    if let uiImage = UIImage(data: image)  {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .frame(width: 150, height: 150)
                            .padding()
                            .onTapGesture {isShowingPhotoPicker = true}
                    }
                } else {
                    Image(uiImage: avatarImage)
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 150, height: 150)
                        .padding()
                        .onTapGesture {isShowingPhotoPicker = true}
                }
            }
            
           

            
            
            
            
            Button(action: {
                print("Change profile photo tapped")
                isShowingPhotoPicker = true
            }) {
                Text("Change Profile Photo")
            }
            
            Group {
                HStack(spacing:10) {
                    Text("Name: ")
                        .foregroundColor(Color.init(hex: "1130C1"))
                        .font(.title)
                    VStack {
                        if let name =  profileArrPersistent.last?.name {
                        TextField(" \(name)", text: $name)
                            .font(Font.system(size: 25, design: .default))
                        } else {
                            TextField("Name", text: $name)
                                .font(Font.system(size: 25, design: .default))
                        }
                        Divider()
                        
                    }
                }
                
                
                
                
                HStack(spacing:10) {
                    Text("Last Name: ")
                        .foregroundColor(Color.init(hex: "1130C1"))
                        .font(.title)
                    VStack {
                        if let lname =  profileArrPersistent.last?.lastName {
                        TextField("\(lname)", text: $lastName)
                            .font(Font.system(size: 25, design: .default))
                        } else {
                            TextField("Last Name", text: $lastName)
                                .font(Font.system(size: 25, design: .default))
                        }
                        Divider()
                        
                    }

                }
                
                
                HStack(spacing:10){
                    Text("Age: ")
                        .foregroundColor(Color.init(hex: "1130C1"))
                        .font(.title)
                    VStack {
                        if let age =  profileArrPersistent.last?.age {
                        TextField("\(age)", text: $age)
                            .font(Font.system(size: 25, design: .default))
                            .textContentType(.oneTimeCode)
                                .keyboardType(.numberPad)
                        } else {
                            TextField("Age", text: $age)
                                .font(Font.system(size: 25, design: .default))
                                .textContentType(.oneTimeCode)
                                    .keyboardType(.numberPad)
                        }
                        Divider()
                        
                    }

                }
                

                HStack(spacing:10) {
                    Text("Sex: ")
                        .foregroundColor(Color.init(hex: "1130C1"))
                        .font(.title)
                    VStack {
                        if let sex =  profileArrPersistent.last?.sex {
                        TextField("\(sex)", text: $sex)
                            .font(Font.system(size: 25, design: .default))
                        } else {
                            TextField("Sex", text: $sex)
                                .font(Font.system(size: 25, design: .default))
                        }
                        Divider()
                        
                    }
                }
                

                HStack(spacing:10) {
                    Text("Location: ")
                        .foregroundColor(Color.init(hex: "1130C1"))
                        .font(.title)

                    VStack {
                        if let loc =  profileArrPersistent.last?.location {
                        TextField("\(loc)", text: $location)
                            .font(Font.system(size: 25, design: .default))
                        } else {
                            TextField("Location", text: $location)
                                .font(Font.system(size: 25, design: .default))
                        }
                        Divider()
                        
                    }
                }
                
                

            }
            .padding(.leading, 15)
            .padding(.trailing, 15)
            
            HStack {
                Spacer()
                
                Button {
                    let profileCore = ProfileCore(context:viewContext)
                    profileCore.image = avatarImageData
                    profileCore.name = name
                    profileCore.lastName = lastName
                    profileCore.age = age
                    profileCore.sex = sex
                    profileCore.location = location
                    PersistenceController.shared.saveContext()
                    
                } label: {
                    Text("Save")
                        .font(.title)
                        .frame(width: 130, height: 50)
                        .background(RadialGradient(gradient: Gradient(colors: [Color.init(hex: "1130C1"), Color.init(hex: "c8d4f5")]),  center: .center, startRadius: 5, endRadius: 120))
                        .clipShape(Capsule())
                        .foregroundColor(.white)
                        .overlay(Capsule().stroke(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.pink]), startPoint: .leading, endPoint: .trailing), lineWidth: 5))
                }
                .padding(.trailing, 20)

            }
            
            Spacer()
        
        }
        .sheet(isPresented: $isShowingPhotoPicker) {
            PhotoPicker(avatarImageData: $avatarImageData, imageHasChanged: $imageHasChanged)
        }
        


    }
}

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//    }
//}


extension UIImage {
    var jpeg: Data? { jpegData(compressionQuality: 1) }  // QUALITY min = 0 / max = 1
    var png: Data? { pngData() }
}
