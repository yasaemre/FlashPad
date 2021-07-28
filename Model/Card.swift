//
//  Page.swift
//  FlashPad (iOS)
//
//  Created by Emre Yasa on 7/26/21.
//

import Foundation


//Sample URL Pages...

struct Card: Identifiable {
    var id = UUID().uuidString
    var cardName: String
    var numberOfCards: Int
    var dateCreated: Date?
    
    func getTodayDate() -> String
    {
        let today = Date()
        let formatter3 = DateFormatter()
        formatter3.dateStyle = .short
        return formatter3.string(from: today)
        
        
    }
}
