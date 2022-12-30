//
//  CopyRightView.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 05/01/23.
//

import SwiftUI
import WebKit

struct CopyRightView: View {
    @ObservedObject var webViewModel = WebViewModel(url: "https://www.alibrary.in/claim-copyright")

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
                    
                    Text("Book Collection").font(.system(size: 26, weight: .regular)).foregroundColor(.white)
                    Spacer()
                        
                   
                }.padding().frame(width: UIScreen.main.bounds.width, height: 65).background(Color("orange"))
            
               if webViewModel.isLoading {
                   VStack{
                       Spacer()
                          
                           CircularProgressView()
                               .frame(height: 30).padding()
     
                       }.frame(alignment: .center)

               }
                   WebViewContainer(webViewModel: webViewModel)
             
            }.frame(alignment: .center)
            
        }
    }
}

struct CopyRightView_Previews: PreviewProvider {
    static var previews: some View {
        CopyRightView()

    }
}

class WebViewModel: ObservableObject {
    @Published var isLoading: Bool = false

    var url: String

    init(url: String) {
        self.url = url
    }
}





struct WebViewContainer: UIViewRepresentable {
  
    
    @ObservedObject var webViewModel: WebViewModel
    
    func makeCoordinator() -> WebViewContainer.Coordinator {
        Coordinator(self, webViewModel)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: self.webViewModel.url) else {
            return WKWebView()
        }
        
        let request = URLRequest(url: url)
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        webView.load(request)
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {

        
        
        
    }
}

extension WebViewContainer {
    class Coordinator: NSObject, WKNavigationDelegate {
        @ObservedObject private var webViewModel: WebViewModel
        private let parent: WebViewContainer
        
        init(_ parent: WebViewContainer, _ webViewModel: WebViewModel) {
            self.parent = parent
            self.webViewModel = webViewModel
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            webViewModel.isLoading = true
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            webViewModel.isLoading = false
//            webViewModel.title = webView.title ?? ""
//            webViewModel.canGoBack = webView.canGoBack
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            webViewModel.isLoading = false
        }
    }
}





