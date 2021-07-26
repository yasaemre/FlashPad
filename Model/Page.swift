//
//  Page.swift
//  FlashPad (iOS)
//
//  Created by Emre Yasa on 7/26/21.
//

import Foundation


//Sample URL Pages...

struct Page: Identifiable {
    var id = UUID().uuidString
    var url: URL
}
