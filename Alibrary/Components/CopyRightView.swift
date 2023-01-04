//
//  CopyRightView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 06/01/23.
//

import SwiftUI
import WebKit

struct CopyRightView: View {
    @StateObject var webViewModel = WebViewModel(url: "https://www.alibrary.in/claim-copyright")

    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationView {
            
            VStack {
                HStack(spacing: 25){
                    
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image(systemName: "arrow.backward").font(.system(size:22, weight:.heavy)).foregroundColor(.white)
                    })
                    
                    Text("Copy Right").font(.system(size: 26, weight: .regular)).foregroundColor(.white)
                    Spacer()
                    
                    
                }.padding().frame(width: UIScreen.main.bounds.width, height: 65).background(Color("orange"))
                
//                ZStack{
                    if webViewModel.isLoading {
                      
                        VStack{
                            Spacer()
                            
                            CircularProgressView()
                                .frame(height: 30).padding()
                            
                        }//.frame(alignment: .center)
                        
                    }
                    WebViewContainer(webViewModel: webViewModel)
                    //
//                }.frame(alignment: .center)
                
            }
        }
    }
}

struct CopyRightView_Previews: PreviewProvider {
    static var previews: some View {
        CopyRightView()

    }
}
