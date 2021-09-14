//
//  ScoreboardView.swift
//  FlashPad
//
//  Created by Emre Yasa on 9/13/21.
//

import SwiftUI

struct ScoreboardView: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ProfileCore.id, ascending: true)],
           animation: .default)
       private var profileArrPersistent: FetchedResults<ProfileCore>
    var body: some View {
        VStack(spacing: 20) {
            if let data = profileArrPersistent.last?.image {
                Image(uiImage: (UIImage(data: data) ?? UIImage(named: "profilePhoto"))!)
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 80, height: 80)
                    .padding(.trailing, 10)
            }
            
        
            HStack {
                Text(profileArrPersistent.last?.name ?? "Anonymous")
                    .foregroundColor(Color.init(hex: "6C63FF"))
                Text(profileArrPersistent.last?.lastName ?? "Anonymous")
                    .foregroundColor(Color.init(hex: "6C63FF"))
            }
            
            Group {
                Text("The Highest Correct Rate:")
                    .font(.title)
                    .foregroundColor(Color.init(hex: "1F3CD6"))
                
                Text("%96")
                    .fontWeight(.semibold)
                    .font(.system(size: 54))
                    .foregroundColor(.red)
                
                Text("Time spent:")
                    .font(.title)
                    .foregroundColor(Color.init(hex: "1F3CD6"))
                
                Text("3 hrs 23 min")
                    .font(.title)
                    .foregroundColor(.red)
            }
            .padding(.top, 30)
            Spacer()
        }
    }
}

struct ScoreboardView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreboardView()
    }
}
