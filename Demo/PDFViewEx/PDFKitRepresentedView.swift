//
//  PDFKitRepresentedView.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 13/08/22.
//

import Foundation
import SwiftUI
import PDFKit




struct PDFKitRepresentedView: UIViewRepresentable {
   
    let url: URL

    init(_ url: URL) {
        self.url = url
    }

    func makeUIView(context: UIViewRepresentableContext<PDFKitRepresentedView>) -> PDFKitRepresentedView.UIViewType {
        // Create a `PDFView` and set its `PDFDocument`.
        let pdfView = PDFView()
        pdfView.document = PDFDocument(url: self.url)
        return pdfView
    }

//    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PDFKitRepresentedView>) {
//        // Update the view.
//    }
}



struct PDFKitView: View {
    var url: URL

    var body: some View {
        PDFKitRepresentedView(url)
    }
}


struct PDFViewController: UIViewControllerRepresentable {
    let url: URL
    let configuration: PSPDFConfiguration?

    init(_ url: URL, configuration: PSPDFConfiguration?) {
        self.url = url
        self.configuration = configuration
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<PDFViewController>) -> UINavigationController {
        // Create a `PSPDFDocument`.
        let document = PSPDFDocument(url: url)

        // Create the `PSPDFViewController`.
        let pdfController = PSPDFViewController(document: document, configuration: configuration)
        return UINavigationController(rootViewController: pdfController)
    }

    func updateUIViewController(_ uiViewController: UINavigationController, context: UIViewControllerRepresentableContext<PDFViewController>) {
        // Update the view controller.
    }
}



struct PSPDFKitView: View {
    var url: URL
    var configuration: PSPDFConfiguration?

    var body: some View {
        PDFViewController(url, configuration: configuration)
    }
}

