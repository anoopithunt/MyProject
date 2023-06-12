//
//  PSPDFKITView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 17/08/22.
//

import SwiftUI
import PDFKit

struct Pdf: View{
    @State var currentPage: Int = 1
    @State var totalPage: Int = 1
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
        @Environment(\.verticalSizeClass) var verticalSizeClass
        
    @StateObject var list = PreviewBooksViewModel()
    
    var body: some View {
        VStack{
//            PDFViewWrapper(url: URL(string: "\(list.path)/123.pdf")!)
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
            VStack {
                        if horizontalSizeClass == .compact && verticalSizeClass == .regular {
                            // Layout for portrait iPhone
                            Text("Portrait iPhone")
                        } else if horizontalSizeClass == .compact && verticalSizeClass == .compact {
                            // Layout for landscape iPhone
                            Text("Landscape iPhone")
                        } else if horizontalSizeClass == .regular && verticalSizeClass == .regular {
                            // Layout for iPad
                            Text("iPad")
                        }
                    }
            
            
            
        }.onAppear{
            list.getBookData(id: 17)
        }
    }
}






struct PdfView_Previews: PreviewProvider {
    static var previews: some View {

        Pdf()
    }
}



//struct PDFKitV : UIViewRepresentable {
//
//    var url: URL?
//    var document: PDFDocument?
//    var password: String
//
//    init(url: URL, password: String){
//        self.url = url
//        self.password = password
//    }
//    func makeUIView(context: Context) -> UIView {
//        let pdfView = PDFView()
//
//        if let url = url, let document = PDFDocument(url: url) {
//            pdfView.document = document
//            pdfView.document?.unlock(withPassword: password)
//        } else {
//            // Handle the case where url is nil
//            // For example, you can display an error message or a placeholder view
//        }
//        return pdfView
//    }
//    func updateUIView(_ uiView: UIView, context: Context) {
//        // Empty
//    }
//}
//
//
//
//
//
//
//            PDFKitV(url: URL(string: "https://storage.googleapis.com/pdffilesalib/pdf/protectedpdf/Bountiful_bonsai_20220807192040_128/21.pdf")!, password: "alib_2834")

