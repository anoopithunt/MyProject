//
//  GifImageView.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 16/05/23.
//

import SwiftUI
import WebKit

struct GifImageView: View {
    @State var buttonIsClicked = true
    var body: some View {
        VStack{
            if buttonIsClicked{
                GifImage("sound").frame(width: 55, height: 55)
            }
            else{
                GifImage("music").frame(width: 55, height: 55)
            }
            
            Button("Click to animate") {
                buttonIsClicked.toggle()
            }.foregroundColor(.black)
                .font(.system(size: 32, weight: .heavy))
        }
    }
}




struct GifImageView_Previews: PreviewProvider {
    static var previews: some View {
        GifImageView()
    }
}
struct GifImage: UIViewRepresentable {
    private let name: String

    init(_ name: String) {
        self.name = name
    }

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        let url = Bundle.main.url(forResource: name, withExtension: "gif")!
        let data = try! Data(contentsOf: url)
        webView.load(
            data,
            mimeType: "image/gif",
            characterEncodingName: "UTF-8",
            baseURL: url.deletingLastPathComponent()
        )
        webView.scrollView.isScrollEnabled = false

        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.reload()
    }

}
