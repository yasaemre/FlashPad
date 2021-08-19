//
//  CardView.swift
//  FlashPad
//
//  Created by Emre Yasa on 8/3/21.
//

import SwiftUI

struct CardView: View {
    @ObservedObject var card: Card
    @Binding var flip:Bool
    @State private var word = ""
    //@State var word = ""
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(LinearGradient(gradient: Gradient(colors: [Color.init(hex: "6C63FF"), Color.init(hex: "c8d4f5")]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .frame(width: 250, height: 350)
            .shadow(color: Color(UIColor(.black)), radius: 10, x: 5, y: 5)
            .overlay(
                VStack(alignment:.center, spacing: 10) {
            
                if flip == false {
                    TextView(text: $card.word)
                    //TextEditor(text: $card.word)
                    //word = $card.word
                    //Text("\(word)")
                } else {
                    TextView(text: $card.definition)
                    //TextEditor(text: $card.definition)
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
        CardView(card: Card(), flip: .constant(false))
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
