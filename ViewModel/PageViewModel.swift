//
//  PageViewModel.swift
//  FlashPad (iOS)
//
//  Created by Emre Yasa on 7/26/21.
//

import SwiftUI

class PageViewModel: ObservableObject {
    @Published var urls = [
        Page(url: URL(string: "https://www.google.com")!),
        Page(url: URL(string: "https://www.facebook.com")!),
        Page(url: URL(string: "https://www.apple.com")!),
        Page(url: URL(string: "https://www.twitter.com")!),
        Page(url: URL(string: "https://www.gmail.com")!),
        Page(url: URL(string: "https://www.instagram.com")!),
        Page(url: URL(string: "https://www.twitter.com")!),
        Page(url: URL(string: "https://www.facebook.com")!),
        Page(url: URL(string: "https://www.apple.com")!),
        Page(url: URL(string: "https://www.twitter.com")!),
        Page(url: URL(string: "https://www.google.com")!)
    ]
    
    //Currently Dragging Page...
    @Published var currentPage: Page?
}
