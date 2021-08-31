//
//  Card.swift
//  FlashPad
//
//  Created by Emre Yasa on 8/3/21.
//

import Foundation
import SwiftUI


class Card:ObservableObject, Identifiable{
    @Published var word:String = ""
    @Published var definition:String = ""
    @Published var id = UUID()
    /// Card x position
    @Published var x: CGFloat = 0.0
        /// Card y position
    @Published var y: CGFloat = 0.0
        /// Card rotation angle
    @Published var degree: Double = 0.0
}
