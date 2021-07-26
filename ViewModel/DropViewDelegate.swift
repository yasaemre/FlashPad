//
//  DropViewDelegate.swift
//  FlashPad (iOS)
//
//  Created by Emre Yasa on 7/26/21.
//

import SwiftUI

struct DropViewDelegate: DropDelegate {
    var page:Page
    var pageData: PageViewModel
    func performDrop(info: DropInfo) -> Bool {
        return true
    }
    
    //When User Dragged Into New Page...
    func dropEntered(info: DropInfo) {
        print("\(page.url)")
        
        let fromIndex = pageData.urls.firstIndex { (page) -> Bool in
            return page.id == pageData.currentPage?.id
        } ?? 0
        
        let toIndex = pageData.urls.firstIndex { (page) -> Bool in
            return page.id == self.page.id
        } ?? 0
        
        //Safe Check if both are not same...
        if fromIndex != toIndex {
            withAnimation {
                //Swapping Data...
                let fromPage = pageData.urls[fromIndex]
                pageData.urls[fromIndex] = pageData.urls[toIndex]
                pageData.urls[toIndex] = fromPage
            }
        }
        
        //Setting Action as Move...
        func dropUpdated(info:DropInfo) -> DropProposal? {
            return DropProposal(operation: .move)
        }
    }
}
