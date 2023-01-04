//
//  Tabview.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 23/07/22.
//

import SwiftUI

struct Tabview: View {
    
    @State private var defaultView: Int = 1
    
    var body: some View {
        VStack {
            TabView(selection: $defaultView){
                ContentView()
                .tabItem{
                    Text("Home")
                    Image(systemName: "house")
                }.tag(0)
                SwipeView()
                .tabItem{
                    Text("Play")
                    Image(systemName: "play")
                }.tag(1)
                
                ContentView()
                .tabItem{
                    Text("Search")
                    Image(systemName: "magnifyingglass")
                }.tag(3)
                
                WelcomeView()
                .tabItem{
                    Text("Notes")
                    Image(systemName: "pencil")
                }.tag(4)
            }
            .accentColor(.orange)
            .background(Color.gray)
        }
        Spacer()
    }
}

struct Tabview_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Tabview()
                Spacer()
        }
    }
}
