//
//  CardView.swift
//  FlashPad
//
//  Created by Emre Yasa on 8/3/21.
//

import SwiftUI

struct CardView: View {
    @ObservedObject var card: Card
    @StateObject var cardVM = CardViewModel()
    @Binding var flip:Bool
    @Binding var rightArrowTapped:Bool
    @Binding var numOfCard:Int
    @State private var word = ""
    @FetchRequest(sortDescriptors:[]) private var cards: FetchedResults<CardCore>

    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(LinearGradient(gradient: Gradient(colors: [Color.init(hex: "6C63FF"), Color.init(hex: "c8d4f5")]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .frame(width: 250, height: 350)
            .shadow(color: Color(UIColor(.black)), radius: 10, x: 5, y: 5)
            .overlay(
                VStack(alignment:.center, spacing: 10) {
            
                if flip == false {
                    if let cards = cards, cards.count > 0 {
                        if rightArrowTapped == true {
                            Text("")
                        } else {
                            Text(cards[numOfCard].word ?? "No word")
                                .font(.custom("HelveticaNeue", size: 40))
                                .foregroundColor(.white)
                        }
                    }
                    
                    
                }
                else {
                    if rightArrowTapped == true {
                        Text("")
                    } else {
                        if let cards = cards, cards.count > 0 {
                            Text(cards[numOfCard].definition ?? "No def")
                                .font(.custom("HelveticaNeue", size: 40))
                                .foregroundColor(.white)
                        }
                    }
                   
                }
                
            }
            )
        
    }

}

struct TextView: UIViewRepresentable {
    @Binding var text: String

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UITextView {

        let myTextView = UITextView()
        myTextView.delegate = context.coordinator

        myTextView.font = UIFont(name: "HelveticaNeue", size: 34)
        myTextView.isScrollEnabled = true
        myTextView.centerVertically()
        myTextView.text = "Type here"
        myTextView.textColor = UIColor.white
        myTextView.isEditable = true
        myTextView.isUserInteractionEnabled = true
        myTextView.textAlignment = .center
        myTextView.backgroundColor = UIColor(white: 0.0, alpha: 0.05)

        return myTextView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }

    class Coordinator : NSObject, UITextViewDelegate {

        var parent: TextView

        init(_ uiTextView: TextView) {
            self.parent = uiTextView
        }

        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            return true
        }

        func textViewDidChange(_ textView: UITextView) {
            print("text now: \(String(describing: textView.text!))")
            self.parent.text = textView.text
        }
    }
}
struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card(), flip: .constant(false), rightArrowTapped: .constant(false), numOfCard: .constant(0))
    }
}


extension UITextView {
    func centerVertically() {
        let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fittingSize)
        let topOffset = (bounds.size.height - size.height * zoomScale) / 2
        let positiveTopOffset = max(1, topOffset)
        contentOffset.y = -positiveTopOffset
    }
}
