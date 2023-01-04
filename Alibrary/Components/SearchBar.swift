//
//  SearchBar.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 07/11/22.
//

import Foundation
import SwiftUI
struct SearchBar: View {
    @Binding var searchText: String

    @State private var isEditing = true

   
    var body: some View {
        HStack {
            
            TextField("**Search magazines**", text: $searchText)
                .padding(10).font(.system(size: 24))
                .padding(.trailing, 25)
                .padding(.horizontal, 10).overlay(alignment: .trailing,content: {
                    if isEditing{
                        
                        Button(action: {
                            self.isEditing = true
//                            self.searchText = ""
                            
                        }) {
                            Image(systemName: "magnifyingglass").font(.system(size: 26)).foregroundColor(Color.black).padding(.trailing)
                        
                        }

                    }
                    else{
//                        Image(systemName: "multiply").foregroundColor(.black).font(.system(size: 25)).padding()
                        
   
                    }
                    
                })
                .background(Color.white)
                .cornerRadius(22)
            
//                .onTapGesture {
//                    self.isEditing = true
//                    isEditing.toggle()
//                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.linear, value: isEditing)
            
        }.overlay(
            RoundedRectangle(cornerRadius: 22)
                .stroke(Color.orange, lineWidth: 1)
            
            
      ).padding(.horizontal,5)
        }
}
