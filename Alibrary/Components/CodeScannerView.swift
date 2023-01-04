//
//  CodeScannerView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 08/11/22.
//

import SwiftUI

struct CodeScannerView: View {
    
    @State private var isShowingScanner = false
    
    var body: some View {
       
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                VStack {
                    Spacer()
                    Image(systemName: "qrcode.viewfinder").font(.system(size: 245)).frame(width: 235,height: 235).foregroundColor(.white)
                    
                    Spacer()
                    NavigationLink("SCAN QR CODE", destination: EmptyView()).foregroundColor(Color("orange")).font(.system(size: 35))
                        
                    
                }.padding()
            }
        }
        
        
    }
}

struct CodeScannerView_Previews: PreviewProvider {
    static var previews: some View {
        CodeScannerView()
    }
}
