//
//  HomeView.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 13/08/22.
//

import SwiftUI
import PDFKit

struct HomeView: View {
    @State var data : Data?
    var deeds: [Deed] = deedsData
    
    var body: some View {
        NavigationView {
                List(deeds) { item in
                    Button(action: {
                        struct PDFKitRepresentedView: UIViewRepresentable {
                            typealias UIViewType = PDFView

                            let data: Data
                            let singlePage: Bool

                            init(_ data: Data, singlePage: Bool = false) {
                                self.data = data
                                self.singlePage = singlePage
                            }
                                

                            func makeUIView(context _: UIViewRepresentableContext<PDFKitRepresentedView>) -> UIViewType {
                                // Create a `PDFView` and set its `PDFDocument`.
                                let pdfView = PDFView()
                                pdfView.document = PDFDocument(data: data)
                                pdfView.autoScales = true
                                if singlePage {
                                    pdfView.displayMode = .singlePage
                                }
                                return pdfView
                            }

                            func updateUIView(_ pdfView: UIViewType, context _: UIViewRepresentableContext<PDFKitRepresentedView>) {
                                pdfView.document = PDFDocument(data: data)
                            }
                        }
                    }) {
                        HStack {
                            Image(systemName: "doc.fill")
                            Text(item.title)
                        }
                    }
                }
                .navigationTitle("title")
        }
       
    }
}








struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(deeds: deedsData)
    }
}


struct Deed: Identifiable {
    var id = UUID()
    var title: String
    var URL: String
}

let deedsData: [Deed] = [
    Deed(title: NSLocalizedString("civilCode", comment: "Civil code"), URL: "https://isap.sejm.gov.pl/isap.nsf/download.xsp/WDU19640160093/U/D19640093Lj.pdf"),
    Deed(title: NSLocalizedString("penalCode", comment: "Penal code"), URL: "https://isap.sejm.gov.pl/isap.nsf/download.xsp/WDU19970880553/U/D19970553Lj.pdf"),
    Deed(title: NSLocalizedString("civilProcedureCode", comment: "Code of civil procedure"), URL: "https://isap.sejm.gov.pl/isap.nsf/download.xsp/WDU19640430296/U/D19640296Lj.pdf"),
    Deed(title: NSLocalizedString("familyAndGuardianshipCode", comment: "Family and guardianship code"), URL: "http://isap.sejm.gov.pl/isap.nsf/download.xsp/WDU19640090059/U/D19640059Lj.pdf"),
    Deed(title: NSLocalizedString("laborCode", comment: "Labor code"), URL: "https://isap.sejm.gov.pl/isap.nsf/download.xsp/WDU19740240141/U/D19740141Lj.pdf"),
]
