//
//  ScoreboardView.swift
//  FlashPad
//
//  Created by Emre Yasa on 9/13/21.
//

import SwiftUI
import CoreData

struct ScoreboardView: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ProfileCore.id, ascending: true)],
           animation: .default)
       private var profileArrPersistent: FetchedResults<ProfileCore>
    
    @FetchRequest(
           sortDescriptors: [NSSortDescriptor(keyPath: \DeckCore.deckName, ascending: true)],
           animation: .default)
       private var decksArrPersistent: FetchedResults<DeckCore>

    @State private var isShareSheetShowing = false

    
    @State private var selectedDeck: DeckCore

        init(moc: NSManagedObjectContext) {
            let fetchRequest: NSFetchRequest<DeckCore> = DeckCore.fetchRequest()
            fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \DeckCore.deckName, ascending: false)]
            fetchRequest.predicate = NSPredicate(value: true)
            self._decksArrPersistent = FetchRequest(fetchRequest: fetchRequest)
            do {
                let tempItems = try moc.fetch(fetchRequest)
                if(tempItems.count > 0) {
                    self._selectedDeck = State(initialValue: tempItems.first!)
                } else {
                    self._selectedDeck = State(initialValue: DeckCore(context: moc))
                    moc.delete(selectedDeck)
                }
            } catch {
                fatalError("Init Problem")
            }
        }
    
    
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 10) {
                if let data = profileArrPersistent.last?.image {
                    Image(uiImage: (UIImage(data: data) ?? UIImage(named: "profilePhoto"))!)
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width:  geo.size.width * 0.2, height: geo.size.height * 0.2)
                        .navigationBarItems(trailing:
                                                Image(systemName: "square.and.arrow.up")
                                                .font(.title)
                                                .foregroundColor(Color.init(hex: "164430"))
                                                .padding(.trailing, 1)
                                                .onTapGesture {
                            shareButton()
                            
                        }
                                            
                                            
                        )
                }
                
                
                
                
                HStack {
                    Text(profileArrPersistent.last?.name ?? "Anonymous")
                        .foregroundColor(Color.init(hex: "164430"))
                    Text(profileArrPersistent.last?.lastName ?? "Anonymous")
                        .foregroundColor(Color.init(hex: "164430"))
                }
                
                
                
                if (decksArrPersistent.count > 0) {
                    Picker("Please choose a deck", selection: $selectedDeck) {
                        ForEach(decksArrPersistent, id: \.self) { (deck:DeckCore) in
                            Text(deck.unwrappedDeckName)
                                .foregroundColor(Color.init(hex: "164430"))
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(width:geo.size.width * 0.8)
                    //CustomPicker()
                }
                
                Group {
                    if (decksArrPersistent.count > 0) {
                        Text("The Highest Correct Rate  of \(selectedDeck.unwrappedDeckName):")
                            .frame(width:  geo.size.width * 0.97, height: geo.size.height * 0.1)
                            .foregroundColor(Color.init(hex: "164430"))
                    }
                    Text("% \(String(round(selectedDeck.correctRate)))")
                        .fontWeight(.semibold)
//                        .frame(width: geo.size.width * 0.5, height: geo.size.height * 0.2)
                        .font(.title)
                        .foregroundColor(.red)
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }

    }
    
    public func shareButton() {
         isShareSheetShowing.toggle()
         // Subtitute the url with FlashPad
        //https://apps.apple.com/us/app/vintage-house/id1549251393
        let score:Double = selectedDeck.correctRate
        guard let deckName = selectedDeck.deckName, let url = URL(string: "https://apps.apple.com/us/app/vintage-house/id1549251393") else {
            return
        }
        let activityView = UIActivityViewController(activityItems:["My correct rate on \(deckName) deck is \(score). You can try FlashPad too. Fun way to memorize anything you need to learn", url], applicationActivities: nil)
      
         
         UIApplication.shared.windows.first?.rootViewController?.present(activityView, animated: true, completion: nil)
     }
}

//struct ScoreboardView_Previews: PreviewProvider {
//    static var previews: some View {
//        ScoreboardView()
//    }
//}
