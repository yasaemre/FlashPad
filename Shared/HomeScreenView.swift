//
//  HomeScreenView.swift
//  FlashPad
//
//  Created by Emre Yasa on 6/30/21.
//

import SwiftUI
import Firebase

struct HomeScreenView : View {
    
    @StateObject var pageData = PageViewModel()
    let columns = Array(repeating: GridItem(.flexible(), spacing:45), count: 2)
    
    var body: some View{
        VStack {
            LogoutButtonView()
                .frame(width: .infinity, height: 140, alignment: .top )
            ScrollView {
                //Tabs With Pages...
                
                LazyVGrid(columns: columns, spacing: 20, content: {
                    ForEach(pageData.urls) { page in
                        WebView(url: page.url)
                            .frame(height: 200)
                            .cornerRadius(15)
                            .onDrag ({
                                //setting Current Page...
                                pageData.currentPage = page
                                
                               //Sending ID for Sample..
                                return NSItemProvider(contentsOf: URL(string: "\(page.id)")!)!
                                
                            })
                            .onDrop(of: [.url], delegate: DropViewDelegate(page: page, pageData: pageData))
                    }
                })
            }
            .frame(width: .infinity, height: 455, alignment: .center)
            TabBarView()
        }
        
    }
}


struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}
