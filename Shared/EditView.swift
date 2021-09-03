//
//  EditView.swift
//  FlashPad
//
//  Created by Emre Yasa on 9/2/21.
//

import SwiftUI

struct EditView: View {
    
    @State var flipped = false
    @State var flip = false
    @State var rightArrowTapped = false
    
    @State var card: Card
    @StateObject var deckCore:DeckCore
   
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Environment(\.managedObjectContext) private var viewContext
    @State var indexCard = UserDefaults.standard.integer(forKey: "indexCard")
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

//struct EditView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditView()
//    }
//}
