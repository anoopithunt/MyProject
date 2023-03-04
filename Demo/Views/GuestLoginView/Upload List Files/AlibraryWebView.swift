//
//  AlibraryWebView.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 14/03/23.
//

import SwiftUI

struct AlibraryWebView: View {
    
    @ObservedObject var webViewModel = WebViewModel(url: "https://www.alibrary.in/login")
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 1){
            HStack(spacing: 25){
                Button(action: {
                    dismiss()
                },
                       label: {
                    
                    Image(systemName: "arrow.backward")
                    
                        .font(.system(size:22, weight:.heavy))
                    
                        .foregroundColor(.white)
                })
                Text("aLibrary")
                    .font(.system(size: 22, weight: .medium))
                    .foregroundColor(.white)
                Spacer()
                
            }.padding(9)
              .frame(width: UIScreen.main.bounds.width, height: 65)
                .background(Color("orange"))
//
            
//            if webViewModel.isLoading {
//              VStack{
//                  Spacer()
//                        CircularProgressView()
//                            .frame(height: 30).padding()
//                  Spacer()
//                    }.frame(alignment: .center)
//
//            }
//            else{
                WebViewContainer(webViewModel: webViewModel)
//            }
               
            Spacer()
        }
    }
}

struct AlibraryWebView_Previews: PreviewProvider {
    static var previews: some View {
        AlibraryWebView()
    }
}
