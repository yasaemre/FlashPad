//
//  WebView.swift
//  FlashPad (iOS)
//
//  Created by Emre Yasa on 7/26/21.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {

    var url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        let view = WKWebView()
        view.load(URLRequest(url: url))
        view.isUserInteractionEnabled = false
        //Scaling webView...
        view.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
        return view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        //Add code
    }

}
