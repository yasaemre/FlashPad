//
//  Card.swift
//  FlashPad
//
//  Created by Emre Yasa on 8/3/21.
//

import Foundation
import SwiftUI


class Card:ObservableObject{
   @Published var word:String = ""
    @Published var definition:String = ""
}
