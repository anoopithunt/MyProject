//
//  pdfView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 16/08/22.
//

import SwiftUI
import PDFKit
import Foundation

struct PdfView: View {
    var nextBt: Int = 1
    var pdfViews: PDFView?
    var pdfDoc: PDFDocument
 
        var pdfName = "MyFile"
    
    
    
    
    
    
    init() {
           var   nextBtn = String(nextBt)
           var url = URL(string: "https://storage.googleapis.com/pdffilesalib/pdf/protectedpdf/Bountiful_bonsai_20220807192040_128/1.pdf")!
                pdfDoc = PDFDocument(url: url)!

        
            
        }
    
    
//    func nextButton(pageNumber: Int){
//        var count = String(pageNumber+1)
//        init(num: Str)
//
        
//        return count
//    }
    
    
        var body: some View {
            VStack {
                PDFKitViews(showing: pdfDoc)
                Spacer()

                    Text("Next Button")
                        .background(.orange)
                        .foregroundColor(.white)
                        .cornerRadius(22)
                        .frame(width: UIScreen.main.bounds.width*0.9, height: 55)
                        .padding()
                        .onTapGesture() {
//                               nextButton(pageNumber: nextBt)
                           }
   
                
            }
            
             
          
        }
}


struct PDFKitViews: UIViewRepresentable {
    let pdfDocument: PDFDocument
    init(showing pdfDoc: PDFDocument) {
        self.pdfDocument = pdfDoc
    }
    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = pdfDocument
        pdfView.document?.unlock(withPassword: "alib_2834")
        pdfView.displayMode = .singlePageContinuous


        pdfView.document?.accessibilityScroll(.right)
       
        return pdfView
    }
    
    
    func updateUIView(_ pdfView: PDFView, context: Context) {
        pdfView.document = pdfDocument
        
    }
    
    
    
    private func createPDFViewUsing(document : PDFDocument) -> PDFView {
           
           let pdfView = PDFView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
           pdfView.document = document
          
           return pdfView
       }
    
    
    
    

}

struct PdfView_Previews: PreviewProvider {
    static var previews: some View {
        PdfView()
    }
}




