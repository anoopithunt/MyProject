//
//  DocumentView.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 13/08/22.
//

import SwiftUI
import UIKit
import PDFKit
import WebKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
         Uncomment one of the below lines depending on the method you want to use
         to display the PDF file.
         
         If you want to open the PDF from the remote URL, look at each section below
         and update it by uncommenting the code that will use the URL. Make sure to comment
         out the code that will load the local file.
         */
        
        self.displayWebView()
//        self.displayPdf()
    }
    
    private func resourceUrl(forFileName fileName: String) -> URL? {
        if let resourceUrl = Bundle.main.url(forResource: fileName,
                                             withExtension: "pdf") {
            return resourceUrl
        }
        
        return nil
    }
    
    /*
     View PDF with WKWebView
     */
    private func createWebView(withFrame frame: CGRect) -> WKWebView? {
        let webView = WKWebView(frame: frame)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
//        if let resourceUrl = self.resourceUrl(forFileName: "heaps") {
//            webView.loadFileURL(resourceUrl,
//                                allowingReadAccessTo: resourceUrl)
//
//            return webView
//        }
        
        /*
         Use the below if statement if you want to load the file from the remote URL
         */
        if let resourceUrl = URL(string: "https://web.stanford.edu/class/archive/cs/cs161/cs161.1168/lecture4.pdf") {
            let request = URLRequest(url: resourceUrl)
            webView.load(request)

            return webView
        }
        
        return nil
    }
    
    private func displayWebView() {
        if let webView = self.createWebView(withFrame: self.view.bounds) {
            self.view.addSubview(webView)
        }
    }
    
    
    /*
     View PDF with PDFKit
     */
    private func createPdfView(withFrame frame: CGRect) -> PDFView {
        let pdfView = PDFView(frame: frame)
        pdfView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        pdfView.autoScales = true
        
        return pdfView
    }
    
    private func createPdfDocument(forFileName fileName: String) -> PDFDocument? {
//        if let resourceUrl = self.resourceUrl(forFileName: fileName) {
//            return PDFDocument(url: resourceUrl)
//        }
//
//        return nil
        
        /*
         Use the below code if you want to open a PDF from the remote URL.
         */
        if let resourceUrl = URL(string: "https://web.stanford.edu/class/archive/cs/cs161/cs161.1168/lecture4.pdf") {
            return PDFDocument(url: resourceUrl)
        }

        return nil
    }
    
    private func displayPdf() {
        let pdfView = self.createPdfView(withFrame: self.view.bounds)
        
        if let pdfDocument = self.createPdfDocument(forFileName: "heaps") {
            self.view.addSubview(pdfView)
            pdfView.document = pdfDocument
        }
    }
}
