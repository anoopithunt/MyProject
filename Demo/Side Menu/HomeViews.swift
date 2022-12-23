//
//  HomeView.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 23/08/22.
//

import SwiftUI

struct HomeViews: View {
    @State private var showMenu: Bool = false
     
     // MARK: - View Body
     
     var body: some View {
       NavigationView {
         
         ZStack {
           
           Color.gray.ignoresSafeArea(.all, edges: .all)
           
           VStack {
             Text("HomeViews")
               .padding()
               .font(.title)
               .foregroundColor(.white)
           }
           
           GeometryReader { _ in
             
             HStack {
               Spacer()
                 Button {
                   self.showMenu.toggle()
                 } label: {
                   
                   if showMenu {
                     
                     Image(systemName: "xmark")
                       .font(.title)
                       .foregroundColor(.red)
                     
                   } else {
                     Image(systemName: "text.justify")
                       .font(.title)
                       .foregroundColor(.red)
                   }
                   
                 }
                 Spacer()
               SideMenuViews()
                 .offset(x: showMenu ? -122 : UIScreen.main.bounds.width-780)
                 .animation(.easeInOut(duration: 0.4), value: showMenu)
             }
             
           }
           .background(Color.orange.opacity(showMenu ? 0.5 : 0))
           
         }
         
         .navigationTitle("Side Menu Demo")
         .navigationBarTitleDisplayMode(.inline)
         .toolbar {
           
        
         }
       }
     }
   }

struct HomeViews_Previews: PreviewProvider {
    static var previews: some View {
        HomeViews()
    }
}
