//
//  GuestPublishedView.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 14/03/23.
//

import SwiftUI

struct GuestPublishedView: View {
    
    @FocusState private var isTextFieldFocused: Bool

    @Environment(\.dismiss) var dismiss
    
    @State  var searchText: String = ""
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    
    var body: some View {
        ZStack{
            Image("u").resizable().ignoresSafeArea()
            
            VStack(spacing:2){
                HStack(spacing: 25){
                    Button(action: {
                        dismiss()
                    },
                           label: {
                        
                        Image(systemName: "arrow.backward")
                            .font(.system(size:22, weight:.heavy))
                            .foregroundColor(.white)
                    })
                    Text("Published Books")
                        .font(.system(size: 22, weight: .medium))
                        .foregroundColor(.white)
                    Spacer()
                    
                    
                }.padding(.horizontal)
                    .frame(width: UIScreen.main.bounds.width, height: 65)
                    .background(Color("orange"))
                TextField("Search books..", text: $searchText)
                    .font(.title)
                    .padding(.vertical,4)
                    .padding(.leading,12)
                    .padding(.trailing,26)
                    .foregroundColor(.gray)
                    .cornerRadius(8)
                    .focused($isTextFieldFocused)
                    .showClearButton($searchText)
                    .overlay(
                        RoundedRectangle(cornerRadius: 18)
                            .stroke(Color.red, lineWidth: 0.6)
                    )
                Spacer()
                
                ScrollView{
                    LazyVGrid(columns: columns, spacing: 10){
                        
                    }
                    
                }.refreshable(action: {
                  //Refresh Action for recall the API
                })
                
                
            }
            
            
            
        }
    }
}

struct GuestPublishedView_Previews: PreviewProvider {
    static var previews: some View {
        GuestPublishedView()
    }
}
