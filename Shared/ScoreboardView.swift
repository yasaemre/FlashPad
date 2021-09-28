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
        VStack(spacing: 10) {
            if let data = profileArrPersistent.last?.image {
                Image(uiImage: (UIImage(data: data) ?? UIImage(named: "profilePhoto"))!)
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 130, height: 130)
                    .padding(.trailing, 10)
                    .navigationBarItems(trailing:
                        Image(systemName: "square.and.arrow.up")
                                            .font(.title)
                                            .foregroundColor(Color.init(hex: "B74278"))
                                            .padding(.trailing, 1)
                                            .onTapGesture {
                        shareButton()
                        
                    }
                            
                    
                    )
            }
            
            
            
            
            HStack {
                Text(profileArrPersistent.last?.name ?? "Anonymous")
                    .foregroundColor(Color.init(hex: "6C63FF"))
                Text(profileArrPersistent.last?.lastName ?? "Anonymous")
                    .foregroundColor(Color.init(hex: "6C63FF"))
            }
            
            
            
            if (decksArrPersistent.count > 0) {
                Picker("Please choose a deck", selection: $selectedDeck) {
                    ForEach(decksArrPersistent, id: \.self) { (deck:DeckCore) in
                        Text(deck.unwrappedDeckName)
                            .foregroundColor(Color.init(hex: "6C63FF"))
                    }
                }
                .pickerStyle(.wheel)
                //CustomPicker()
            }
      
            Group {
                if (decksArrPersistent.count > 0) {
                Text("The Highest Correct Rate \nfor \(selectedDeck.unwrappedDeckName):")
                    .font(.title)
                    .foregroundColor(Color.init(hex: "1F3CD6"))
                }
                Text("% \(String(round(selectedDeck.correctRate)))")
                    .fontWeight(.semibold)
                    .font(.system(size: 54))
                    .foregroundColor(.red)
            }
            .padding(.top, 20)
            Spacer()
        }

    }
    
    public func shareButton() {
         isShareSheetShowing.toggle()
         
        //https://apps.apple.com/us/app/vintage-house/id1549251393
         let score = selectedDeck.correctRate
        let activityView = UIActivityViewController(activityItems:[score], applicationActivities: nil)
         
         UIApplication.shared.windows.first?.rootViewController?.present(activityView, animated: true, completion: nil)
     }
}

//struct ScoreboardView_Previews: PreviewProvider {
//    static var previews: some View {
//        ScoreboardView()
//    }
//}
