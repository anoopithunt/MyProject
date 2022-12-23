//
//  PDFView.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 13/08/22.
//

import SwiftUI
import PDFKit
import UIKit

struct PDFView: View {
    let documentURL = Bundle.main.url(forAuxiliaryExecutable: URL(string: "https://cloud.google.com/files/apigee/apigee-apis-for-dummies-ebook.pdf"))!
//      let configuration = PSPDFConfiguration {
//          $0.pageTransition = .scrollContinuous
//          $0.pageMode = .single
//          $0.scrollDirection = .vertical
//          $0.backgroundColor = .white
//      }
      var body: some View {
          VStack(alignment: .leading) {
              Text("PSPDFKit SwiftUI")
                  .font(.largeTitle)
              HStack(alignment: .top) {
                  Text("Made with ❤ at WWDC19")
                      .font(.title)
              }
              PSPDFKitView(url: documentURL)
          }
      }
}

struct PDFView_Previews: PreviewProvider {
    static var previews: some View {
        PDFView()
    }
}
