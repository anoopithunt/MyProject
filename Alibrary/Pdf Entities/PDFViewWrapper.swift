//
//  PDFViewWrapper.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 29/03/23.
//

import PDFKit
import SwiftUI


// MARK: PDF Reader

struct PDFViewWrapper: UIViewRepresentable {
    typealias UIViewType = PDFView
    let url: URL
    let password: String
    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.autoScales = true
        pdfView.displayMode = .singlePageContinuous
        pdfView.displayDirection = .horizontal
        return pdfView
    }
    
    func updateUIView(_ uiView: PDFView, context: Context) {
        
        DispatchQueue.global(qos: .background).async {
            if let document = PDFDocument(url: url) {
//                document.unlock(withPassword: "alib_4") // Unlock the document here
                DispatchQueue.main.async {
                    uiView.document = document
                    document.unlock(withPassword: password)
                    DispatchQueue.main.async {
                        uiView.document = document

                               }
                }
//            } else {
//                print("Error loading PDF")
            }
        }
    }
}

