//
//  webView.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 09/08/22.
//

import SwiftUI
import SwiftyJSON
import SDWebImageSwiftUI
import WebKit

struct webView: UIViewRepresentable {
    
    var url: String

        
        func makeUIView(context: UIViewRepresentableContext<webView>) -> WKWebView {
            
            let view = WKWebView()
                    view.load(URLRequest(url: URL(string: url)!))
                    return view
            
            
        }
        func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<webView>) {
       //
           }
    }


//struct webView_Previews: PreviewProvider {
//    static var previews: some View {
//        webView()
//    }
//}
