//
//  PDFKitView.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 13/08/22.
//

import SwiftUI
import PDFKit


struct PDFKitView: View {
  @State var pdfDoc: PDFDocument!
    var pdfview : PDFView!
  @State  var  url = URL(string: "https://storage.googleapis.com/pdffilesalib/pdf/protectedpdf/Bountiful_bonsai_20220807192040_128/5.pdf")!

            var pdfName = "MyFile"
    @State var currentPg: Int = 18
    
    
    
    
    
            init(currentPg: Int){
//             url = URL(string: "https://storage.googleapis.com/pdffilesalib/pdf/protectedpdf/Bountiful_bonsai_20220807192040_128/\(currentPg).pdf")!
            pdfDoc = PDFDocument(url: url)!

            }
    
    
        var body: some View {
                                   ZStack {
//                       PDFKitViews(pdfDocument: pdfDoc)
                                       PDFKitView(currentPg: 5)
                        
                                       if currentPg != 0{
                                       Button(action: {
                                    
                                            currentPg = currentPg+1
                                           nextButton(num: currentPg)
                                           pdfDoc = PDFDocument(url: url)!
                                           print(currentPg)
                                       }) {
                                              Text("Login")
                                               .foregroundColor(.orange)
                                               .bold()
                                           Image(systemName: "ellipsis")
                                               .foregroundColor(.orange)
                                               .font(.system(size: 45))
                                               .rotationEffect(.degrees(-90))
                                               
                                  
                    }
                                       }
                    }
             
        }

}

 

struct PDFKitView_Previews: PreviewProvider {
static var previews: some View {
    PDFKitView(currentPg: 55)
}
}

 

struct PDFKitViews: UIViewRepresentable {
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

func nextButton(num: Int){
var pdfDocs = PDFDocument()
    let num = num+1
let urls = URL(string: "https://storage.googleapis.com/pdffilesalib/pdf/protectedpdf/Bountiful_bonsai_20220807192040_128/\(num).pdf")!
print(urls)
 pdfDocs = PDFDocument(url: urls)!
//    PDFKitViews(pdfDocument: pdfDocs)
    PDFKitView(currentPg: num)
    print(pdfDocs)

}
