//
//  PDFKitView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 13/08/22.
//

import SwiftUI
import PDFKit




struct PDFKitViewRepresentable: UIViewRepresentable {
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


//Method for Next page
//
//func nextButton(num: Int){
//var pdfDocs = PDFDocument()
//    let num = num+1
//let urls = URL(string: "https://storage.googleapis.com/pdffilesalib/pdf/protectedpdf/Bountiful_bonsai_20220807192040_128/\(num).pdf")!
//print(urls)
// pdfDocs = PDFDocument(url: urls)!

//    print(pdfDocs)
//
//}
