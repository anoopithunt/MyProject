//
//  PdfPage.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 19/08/22.
//

import SwiftUI
import PDFKit

struct PdfPage: View {
    
    @State var currentPg: Int = 18
    @State var pdfDoc: PDFDocument!
      var pdfview : PDFView!
    @State  var  baseurl:String =  "https://storage.googleapis.com/pdffilesalib/pdf/protectedpdf/Bountiful_bonsai_20220807192040_128/"
    @State var extensionurl: String  = ".pdf"
//    @State var url: String  = baseurl+String(currentPg)+extensionurl
    
    

              var pdfName = "MyFile"
     
    
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct PdfPage_Previews: PreviewProvider {
    static var previews: some View {
        PdfPage()
    }
}












struct PDFPageView: UIViewRepresentable {
    func updateUIView(_ pdfView: PDFView, context: Context) {
            pdfView.document = pdfDocument
        }
    
    
    let pdfDocument: PDFDocument
    
func makeUIView(context: Context) -> PDFView {
    let pdfView = PDFView()
    pdfView.document = pdfDocument
    pdfView.autoScales = true
    pdfView.document?.unlock(withPassword: "alib_2834")
    pdfView.displayMode = .singlePage
    pdfView.displayDirection = .horizontal
    pdfView.usePageViewController(true)
   
    
    return pdfView
}



}
