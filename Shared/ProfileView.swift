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
    @Binding var avatarImageData:Data
    @Binding var imageHasChanged:Bool
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ProfileCore.id, ascending: true)],
           animation: .default)
       private var profileArrPersistent: FetchedResults<ProfileCore>
    
    @StateObject var profileCore = ProfileCore()
    @State private var index = 0
    
    @State private var rotateCheckMark = 30
    @State private var checkMarkValue = -60
    
    @State private var showCircle = 0
    
    @State private var isShowingCheckMark = false

    var body: some View {
        ZStack {
            GeometryReader { geo in
                VStack(spacing: 10) {
                    
                    if imageHasChanged == true {
                        if let imgData = avatarImageData{
                            Image(uiImage: UIImage(data: imgData) ?? avatarImage)
                                .resizable()
                                .scaledToFill()
                                .clipShape(Circle())
                                .frame(width:  geo.size.width * 0.2, height: geo.size.height * 0.2)
                                .onTapGesture {isShowingPhotoPicker = true}
                                .shadow(color: Color(UIColor(.black)), radius: 10, x: 5, y: 5)

                        }
                    } else {
                        if let image = profileArrPersistent.last?.image{
                            if let uiImage = UIImage(data: image)  {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFill()
                                    .clipShape(Circle())
                                    .frame(width:  geo.size.width * 0.2, height: geo.size.height * 0.2)
                                    .onTapGesture {isShowingPhotoPicker = true}
                                    .shadow(color: Color(UIColor(.black)), radius: 10, x: 5, y: 5)

                            }
                        } else {
                            Image(uiImage: avatarImage)
                                .resizable()
                                .scaledToFill()
                                .clipShape(Circle())
                                .frame(width:  geo.size.width * 0.2, height: geo.size.height * 0.2)
                                .onTapGesture {isShowingPhotoPicker = true}
                                .shadow(color: Color(UIColor(.black)), radius: 10, x: 5, y: 5)

                        }
                    }
                    
                    
                    
                    
                    Button(action: {
                        print("Change profile photo tapped")
                        isShowingPhotoPicker = true
                        
                    }) {
                        Text("Change Profile Photo")
                            .frame(width:  geo.size.width * 0.5, height: geo.size.height * 0.07)
                    }
                    .padding(.bottom, geo.size.height * 0.07)
                    
                    Group {
                        HStack(spacing:10) {
                            Text("Name: ")
                                .foregroundColor(Color.init(hex: "164430"))
                                .font(.title2)
                            VStack {
                                if let name =  profileArrPersistent.last?.name {
                                    TextField(" \(name)", text: $name)
                                        .font(.title2)
                                } else {
                                    TextField("Name", text: $name)
//                                        .font(Font.system(size: 25, design: .default))
                                    .font(.title2)                                }
                                Divider()
                                    
                                
                            }
                        }
                        
                        
                        
                        
                        HStack(spacing:10) {
                            Text("Last Name: ")
                                .foregroundColor(Color.init(hex: "164430"))
                                .font(.title2)
                            VStack {
                                if let lname =  profileArrPersistent.last?.lastName {
                                    TextField("\(lname)", text: $lastName)
                                    .font(.title2)
                                    
                                } else {
                                    TextField("Last Name", text: $lastName)
                                        .font(.title2)
                                    
                                }
                                Divider()
                                    
                                
                            }
                            
                        }
                        
                        
                        HStack(spacing:10){
                            Text("Age: ")
                                .foregroundColor(Color.init(hex: "164430"))
                                .font(.title2)

                            VStack {
                                if let age =  profileArrPersistent.last?.age {
                                    TextField("\(age)", text: $age)
                                        .font(.title2)                                         .textContentType(.oneTimeCode)
                                        .keyboardType(.numberPad)
                                } else {
                                    TextField("Age", text: $age)
                                        .font(.title2)                           .textContentType(.oneTimeCode)
                                        .keyboardType(.numberPad)
                                }
                                Divider()
                                
                            }
                            
                        }
                        
                        
                        HStack(spacing:10) {
                            Text("Sex: ")
                                .foregroundColor(Color.init(hex: "164430"))
                                .font(.title2)
                            VStack {
                                if let sex =  profileArrPersistent.last?.sex {
                                    TextField("\(sex)", text: $sex)
                                    .font(.title2)
                                    
                                } else {
                                    TextField("Sex", text: $sex)
                                        .font(.title2)
                                        
                                    }
                                Divider()
                                
                            }
                        }
                        
                        
                        HStack(spacing:10) {
                            Text("Location: ")
                                .foregroundColor(Color.init(hex: "164430"))
                                .font(.title2)
                            VStack {
                                if let loc =  profileArrPersistent.last?.location {
                                    TextField("\(loc)", text: $location)
                                    .font(.title2)
                                    
                                } else {
                                    TextField("Location", text: $location)
                                        .font(.title2)                                 }
                                Divider()
                                
                            }
                        }
                    }
//                    .padding(.leading, 30)
//                    .padding(.trailing, 30)
                    .padding(.leading, geo.size.width * 0.1)
                    .padding(.trailing, geo.size.width * 0.1)


                    
                    HStack {
                        Spacer()
                        
                        Button {
                            withAnimation{
                                isShowingCheckMark.toggle()
                            }
                            let profileCore = ProfileCore(context:viewContext)
                            if avatarImageData.isEmpty {
                                if let img = profileArrPersistent.last?.image {
                                    profileCore.image = img
                                }
                            } else {
                                profileCore.image = avatarImageData
                            }
                            //profileCore.image = avatarImageData
                            if name.isEmpty {
                                if let name = profileArrPersistent.last?.name {
                                    profileCore.name = name
                                }
                            } else {
                                profileCore.name = name
                            }
                            if lastName.isEmpty {
                                if let lastName = profileArrPersistent.last?.lastName {
                                    profileCore.lastName = lastName
                                }
                            } else {
                                profileCore.lastName = lastName
                            }
                            if age.isEmpty {
                                if let age = profileArrPersistent.last?.age {
                                    profileCore.age = age
                                }
                            } else {
                                profileCore.age = age
                            }
                            if sex.isEmpty {
                                if let sex = profileArrPersistent.last?.sex {
                                    profileCore.sex = sex
                                }
                            } else {
                                profileCore.sex = sex
                            }
                            if location.isEmpty {
                                if let loc = profileArrPersistent.last?.location {
                                    profileCore.location = loc
                                }
                            } else {
                                profileCore.location = location
                            }
                            PersistenceController.shared.saveContext()
                            
                            
                            showCircle = 1
                            rotateCheckMark = 0
                            checkMarkValue = 0
                        } label: {
                            Text("Save")
                                .font(.title)
                                .frame(width:  geo.size.width * 0.3, height: geo.size.height * 0.07)
                                .background(RadialGradient(gradient: Gradient(colors: [Color.init(hex: "164430"), Color.init(hex: "164430")]),  center: .center, startRadius: 5, endRadius: 120))
                                .clipShape(Capsule())
                                .foregroundColor(.white)
                                .overlay(Capsule().stroke(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.pink]), startPoint: .leading, endPoint: .trailing), lineWidth: 5))
                        }
                        .padding(.trailing, 30)
                        .padding(.top, geo.size.height * 0.04)
                        .shadow(color: Color(UIColor(.black)), radius: 10, x: 5, y: 5)

                        
                    }
                    
                    Spacer()
                    
                }
                .sheet(isPresented: $isShowingPhotoPicker) {
                    PhotoPicker(avatarImageData: $avatarImageData, imageHasChanged: $imageHasChanged)
                }
                //.padding(.top, geo.size.height * 0.02)
     //            .frame(width:geo.size.width * 0.7, height:  geo.size.height * 0.96, alignment: .center)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
            
            if isShowingCheckMark {
                ZStack {
                Circle()
                    .frame(width: 110, height: 110, alignment: .center)
                    .foregroundColor(.white)
                    .opacity(0.5)
                    .scaleEffect(CGFloat(showCircle))
                    .animation(Animation.interpolatingSpring(stiffness: 170, damping: 15).delay(0.5))
                    .transition(.asymmetric(insertion: .opacity, removal: .scale))

                    
                    
                    
                    VStack {
                        Image(systemName: "checkmark")
                            .foregroundColor(Color.init(hex: "067238"))
                            .font(.system(size: 60))
                            .rotationEffect(.degrees(Double(rotateCheckMark)))
                            .clipShape(Rectangle().offset(x: CGFloat(checkMarkValue)))
                            .animation(Animation.interpolatingSpring(stiffness: 170, damping: 15).delay(0.75))
                            .transition(.asymmetric(insertion: .opacity, removal: .scale))
                        
                        Text("Saved")
                            .font(.title2)
                            .clipShape(Rectangle().offset(x: CGFloat(checkMarkValue)))
                            .animation(Animation.interpolatingSpring(stiffness: 170, damping: 15).delay(0.75))
                            .transition(.asymmetric(insertion: .opacity, removal: .scale))
                    }
                    
                  
                    
                }
                
                .onAppear(perform: setDismissTimer)
            }
        }
        


    }
    
    func setDismissTimer() {
      let timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { timer in
        withAnimation(.easeInOut(duration: 2)) {
          self.isShowingCheckMark = false
        }
        timer.invalidate()
      }
      RunLoop.current.add(timer, forMode:RunLoop.Mode.default)
        
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
