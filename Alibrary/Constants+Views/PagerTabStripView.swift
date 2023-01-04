//
//  PagerTabStripView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 13/04/23.
//

import Foundation
import SwiftUI

struct PagerTabStripView<Content: View>: View {
    let views: [Content]
    let tabItemNames: [String]
    @State private var selectedTab = 0
    
    init(views: [Content], tabItemNames: [String]) {
        self.views = views
        self.tabItemNames = tabItemNames
    }
    
    var body: some View {
        VStack(spacing:0) {

            HStack(spacing: 0) {
                ForEach(0..<tabItemNames.count) { index in
                    Button(action: { self.selectedTab = index }) {
                        Text(tabItemNames[index])
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.orange)
                    }
                    .overlay(
                        selectedTab == index ?
                            Rectangle()
                                .frame(height: 4)
                                .foregroundColor(.black)
//                                .animation(.linear(duration: 1))
                                .padding(.top, 52) : nil
                    )
                }
            }.foregroundColor(.white).font(.system(size: 19, weight: .bold))
            
            TabView(selection: $selectedTab) {
                ForEach(0..<views.count, id: \.self) { index in
                    views[index].tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
    }
}
