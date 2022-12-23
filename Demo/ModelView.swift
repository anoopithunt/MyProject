//
//  ModelView.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 22/08/22.
//

import Foundation
import SwiftUI
import PDFKit
import WebKit

func getResourse(num: URL)
{
    print("GETResourse")
    FileView1(urlpdf: num)
    print(" Last GETResourse")
}
struct ModelView: View {
    let sfSymbol: String
    let text: String
 
    let fileUrl = Bundle.main.url(forResource: "document", withExtension: "pdf")!
    @State var navigated = false
    var body: some View {
        
        ZStack {
//        NavigationView{

           
        
            FileView1(urlpdf: URL(string: "https://storage.googleapis.com/pdffilesalib/pdf/protectedpdf/Bountiful_bonsai_20220807192040_128/5.pdf")!)
//
//            NavigationLink("Book URL", destination:  FileView1(urlpdf: self.fileUrl), isActive: $navigated)
//
                                Button(action: {
//                                   self.navigated.toggle()
                                    
//                                    FileView1(urlpdf: self.fileUrl)
                                    getResourse(num: self.fileUrl)
                                 
                                },
                                       label: {
                                    Image(systemName: sfSymbol)
                                        .foregroundColor(.init(red: 0.20, green: 0.33, blue: 0.55, opacity: 1.00))
                                    Text("Button") })
            }
//    }

    }
}

struct ModelView_Previews: PreviewProvider {
    static var previews: some View {
        ModelView(sfSymbol: "rectangle.expand.vertical", text: "WEBVIEW")
    }
}



struct FileView1: View {
    var urlpdf: URL
    var body: some View {
       
            PDFKitRepresentedView(urls: urlpdf)
    
    }
    
}

struct PDFKitRepresentedView: UIViewRepresentable {
    let urls: URL
    init(urls: URL) {
        self.urls = urls
    }

    func makeUIView(context: UIViewRepresentableContext<PDFKitRepresentedView>) -> PDFKitRepresentedView.UIViewType {
        let pdfView = PDFView()
        pdfView.document = PDFDocument(url: self.urls)
        pdfView.document?.unlock(withPassword: "alib_2834")
        pdfView.autoScales = true

            
            return pdfView
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PDFKitRepresentedView>) {
        // Update the view.
    }
}

