//
//  PublisherTotalEarningsView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 24/09/23.
//

import SwiftUI
import WebKit

struct PublisherTotalEarningsView: View {
    
    var body: some View {
        NavHeaderClosure(title: "aLibrary"){
            ZStack{
                
                WebView(urlString: "https://www.alibrary.in/publisher/tot-earning?email=alibpublisher@gmail.com&password=11111111")
            }
            
        }
        
    }
}

struct PublisherTotalEarningsView_Previews: PreviewProvider {
    static var previews: some View {
        PublisherTotalEarningsView()
    }
}


struct WebView: UIViewRepresentable {
    let urlString: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView
        
        init(_ parent: WebView) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            // Inject JavaScript to hide header element and adjust marginTop
            let hideHeaderScript = """
                document.querySelector('.navbar').style.display = 'none';
                setTimeout(function() {
                    document.querySelector('.navbar').style.marginTop = '90 !important';
                }, 100); // Adjust the delay time as needed
            """
            webView.evaluateJavaScript(hideHeaderScript, completionHandler: nil)
            
        }
        
    }
    
}
