//
//  EditScreenView.swift
//  FlashPad
//
//  Created by Emre Yasa on 8/3/21.
//

import SwiftUI

struct EditScreenView: View {
    @StateObject var cardData = CardViewModel()
    @State var flipped = false
    @State var flip = false

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var btnBack : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "arrowshape.turn.up.left.fill")
                    .font(.system(size: 24))
                    .padding(.leading, 10)
                Text("Go back")
            }
        }
    }
    
    var body: some View {
            ZStack {
               VStack {
                   HStack(spacing: 10) {
                       Button {
                           //
                       } label: {
                           Text("Question")
                               .font(.title)
                               .frame(width: 130, height: 40)
                               .background(RadialGradient(gradient: Gradient(colors: [Color.init(hex: "6C63FF"), Color.init(hex: "c8d4f5")]),  center: .center, startRadius: 5, endRadius: 120))
                               .clipShape(Capsule())
                               .foregroundColor(.white)
       //                        .overlay(Capsule().stroke(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.blue]), startPoint: .leading, endPoint: .trailing), lineWidth: 5))
                           
                       }
                       
                       Button {
                           //
                       } label: {
                           Text("Answer")
                               .font(.title)
                           .frame(width: 130, height: 40)
                           .background(RadialGradient(gradient: Gradient(colors: [Color.init(hex: "6C63FF"), Color.init(hex: "c8d4f5")]),  center: .center, startRadius: 5, endRadius: 120))
                           .clipShape(Capsule())
                           .foregroundColor(.white)
                       }
                   }
                   .padding(.top, 5)

                   ZStack {
                       CardView(card: Card(word: "Rambling(adj)", definition: "basi bos, derme capma "))
                           .opacity(flipped ? 0 : 1)
                       CardView(card: Card(word: "Rambling(adj)",image: ""))
                           .opacity(flipped ? 1 : 0)
           //                .frame(width: 250, height: 350)
           //                .cornerRadius(16)
                   }
                   .modifier(FlipEffect(flipped: $flipped, angle: flip ? 0 : 180))
                   .onTapGesture {
                       withAnimation {
                           flip.toggle()
                       }
                   }
                   .padding(.top, 15)
                   
                   Text("1 of 14")
                       .font(.title2)
                       .padding(.top, 10)
                   
                   HStack(spacing: 30){
                       Button {
                           //
                       } label: {
                           Image(systemName: "arrowshape.turn.up.backward")
                               .font(.largeTitle)
                               .foregroundColor(Color.init(hex: "6C63FF"))
                       }
                       
                       Button {
                           //
                       } label: {
                           Text("Add Card")
                               .font(.title)
                               .frame(width: 150, height: 60)
                               .background(RadialGradient(gradient: Gradient(colors: [Color.init(hex: "6C63FF"), Color.init(hex: "c8d4f5")]),  center: .center, startRadius: 5, endRadius: 120))
                               .clipShape(Capsule())
                               .foregroundColor(.white)
                               .overlay(Capsule().stroke(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.pink]), startPoint: .leading, endPoint: .trailing), lineWidth: 5))
                       }
                       
                       Button {
                           //
                       } label: {
                           Image(systemName: "arrowshape.turn.up.right")
                               .font(.largeTitle)
                               .foregroundColor(Color.init(hex: "6C63FF"))
                       }
                   }

               }
               .navigationBarTitle("Edit")

//               .toolbar {
//                   ToolbarItemGroup(placement: .navigationBarLeading) {
//                       VStack(alignment: .center) {
//                           HStack(alignment: .center, spacing: 105) {
////                               NavigationLink(destination: HomeScreenView()) {
////                                   Image(systemName: "arrowshape.turn.up.left.fill")
////                                       .symbolRenderingMode(.hierarchical)
////                                       .font(.system(size: 24))
////                                       .foregroundColor(Color.init(hex: "6C63FF"))
////                                       .padding(.leading, 10)
////
////                               }
//                               Button(action: {
//                                          self.presentationMode.wrappedValue.dismiss()
//                                       }) {
//                                           Image(systemName: "arrowshape.turn.up.left.fill")
//                                               .symbolRenderingMode(.hierarchical)
//                                               .font(.system(size: 24))
//                                               .foregroundColor(Color.init(hex: "6C63FF"))
//                                               .padding(.leading, 10)
//                                       }
//                                       .navigationBarHidden(true)
//
////                               Button(action: goBack) {
////                                           Image(systemName: "arrowshape.turn.up.left.fill")
////                                               .symbolRenderingMode(.hierarchical)
////                                               .font(.system(size: 24))
////                                               .foregroundColor(Color.init(hex: "6C63FF"))
////                                               .padding(.leading, 10)
////                                       }
////                                       .navigationBarHidden(true)
//
//                                   Spacer()
//                                   //.padding(100)
//                                   Button(action: {
//                                       print("Profile button tapped")
//                                   }) {
//                                       Text("Study")
//                                           .font(.title)
//                                           .frame(width: 90, height: 40)
//                                           .background(RadialGradient(gradient: Gradient(colors: [Color.init(hex: "e54860"), Color.white]),  center: .center, startRadius: 5, endRadius: 120))
//                                           .clipShape(Capsule())
//                                           .foregroundColor(.white)
//
//                                   }
//                                   .padding(.trailing, 20)
//                           }
//
//                       }
//                       .padding()
//                   }
//
//               }
           }
//            .navigationBarBackButtonHidden(true)
//            .navigationBarItems(leading: btnBack)


//            .navigationBarItems(leading: Button(action: {
//                self.presentationMode.wrappedValue.dismiss()
//            }) {
//                Image(systemName: "arrowshape.turn.up.left.fill")
//                    .symbolRenderingMode(.hierarchical)
//                    .font(.system(size: 24))
//                    .foregroundColor(Color.init(hex: "6C63FF"))
//                    .padding(.leading, 10)
//            }, trailing: Button(action: {
//                print("Profile button tapped")
//            }) {
//                Text("Study")
//                    .font(.title)
//                    .frame(width: 90, height: 40)
//                    .background(RadialGradient(gradient: Gradient(colors: [Color.init(hex: "e54860"), Color.white]),  center: .center, startRadius: 5, endRadius: 120))
//                    .clipShape(Capsule())
//                    .foregroundColor(.white)
//            })
//            .navigationBarBackButtonHidden(false)
            .background(Color(UIColor.systemBackground))


    }
    
    func goBack(){
           //here I save CoreData context if it changes
           self.presentationMode.wrappedValue.dismiss()
        print("Back button tapped")
       }
}

struct FlipEffect: GeometryEffect {
    
    @Binding var flipped:Bool
    var angle:Double
    
    var animatableData: Double {
        get { angle }
        set { angle = newValue }
    }

    func effectValue(size: CGSize) -> ProjectionTransform {
        DispatchQueue.main.async {
            flipped = angle >= 90 && angle < 270
        }
        let newAngle = flipped ? -180 + angle : angle
        
        let angleInRadians = CGFloat(Angle(degrees: newAngle).radians)
        
        var transform3d = CATransform3DIdentity
        transform3d.m34 = -1/max(size.width, size.height)
        transform3d = CATransform3DRotate(transform3d, angleInRadians, 0, 1, 0)
        transform3d = CATransform3DTranslate(transform3d, -size.width / 2, -size.height/2, 0)
        let affineTransform = ProjectionTransform(CGAffineTransform(translationX: size.width / 2, y: size.height / 2))
        
        
        return ProjectionTransform(transform3d).concatenating(affineTransform)
    }
}

struct EditScreenView_Previews: PreviewProvider {
    static var previews: some View {
        EditScreenView()
    }
}
