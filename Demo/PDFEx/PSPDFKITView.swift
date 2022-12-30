//
//  PSPDFKITView.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 17/08/22.
//

import SwiftUI
import PDFKit




struct PDFKitRepresentedViews: UIViewRepresentable {
    var url: URL
    @Binding var currentPage: Int
    @Binding var total: Int
    init(_ url: URL, _ currentPage: Binding<Int>, _ total: Binding<Int>) {
        self.url = url
        self._currentPage = currentPage
        self._total = total
        
    }
    func makeUIView(context: Context) -> UIView {
        guard let document = PDFDocument(url: self.url) else { return UIView()
            
        }
        let pdfView = PDFView()
        pdfView.document = document
        pdfView.document?.unlock(withPassword: "alib_3")
//    pdfView.displayMode = .singlePage
        pdfView.displayDirection = .horizontal
        pdfView.autoScales = true
   
        pdfView.usePageViewController(true)
   

        DispatchQueue.main.async {
            self.total = document.pageCount
            print("Total pages: \(total)")
            
        }
        return pdfView
        
    }
    func updateUIView(_ uiView: UIView, context: Context) {
        guard let pdfView = uiView as? PDFView else {
            return
            
        }
        if currentPage < total {
             pdfView.go(to: pdfView.document!.page(at: currentPage)!)
                    }
                }
 
        }

struct PSPDFKITView_Previews: PreviewProvider {
    static var previews: some View {
        PDFKitView(totalPage: 2)
    }
}



//Modal of Preview Books
import Foundation

// MARK: - Welcome
public struct PreviewBooksModel: Decodable {
    public let book: PreviewModel

}

// MARK: - Book
public struct PreviewModel: Decodable {
    public let id: Int
//    public let name: String
    public let tot_pages: Int
//    public let title: String
//    public let author_name: String
//    public let tot_likes: String
//    public let tot_view: Int
//    public let validity_date: String
    public let pdf_path: String
    public let published: String
    public let published_date: String
    public let url: String
    public let protectedpdf: String
    public let demo: String
    public let thumbnail: String

}

class PreviewBooksViewModel: ObservableObject{

    @Published var path = String()
    @Published var totatPages = Int()
    @Published var currentPage = 1
    
    @Published var pageUrl = String()
    func getBookData() {

        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }

        AuthenticationPreviewBookService().getBookData(token: token){ (result) in
            switch result {
                case .success(let results):
                    DispatchQueue.main.async {
                        self.path = results.book.pdf_path
                        self.totatPages = results.book.tot_pages
                        self.pageUrl = "\(results.book.pdf_path)/\(self.currentPage).pdf)"
                        print(self.pageUrl)
                        
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }

    }
}



class AuthenticationPreviewBookService {
    func getBookData(token: String, completion: @escaping (Result<PreviewBooksModel, NetworkError>) -> Void) {
            
        guard let url = URL(string: "https://alibrary.in/api/previewbook?id=4") else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(.noData))
                return
            }
            
            guard let response = try? JSONDecoder().decode(PreviewBooksModel.self, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            
            completion(.success(response))
            
        }.resume()
           
        }
    
}


struct Pdf: View{
    
    @State var currentPage: Int = 1
    @State var totalPage: Int = 1

    @StateObject var list = PreviewBooksViewModel()
    var body: some View{// print("\(self.path)/\(self.currentPage).pdf")
        VStack{
            PDFKitV(url: (((URL(string: "\(list.path)/\(list.currentPage).pdf)")) ?? URL(string: "https://storage.googleapis.com/pdffilesalib/pdf/protectedpdf/101_Essential_Tips_Dog_Care_11/11.pdf"))!))
        }.onAppear{
            list.getBookData()
        }
    }
}


struct PDFKitView: View {
   
    @State var currentPage: Int = 1
    @State var totalPage: Int = 1
    
    @StateObject var list = PreviewBooksViewModel()
    init(totalPage:Int) {
        self.totalPage = list.totatPages
//        self.list = list
    }
    
    var body: some View {
        VStack {
            
            Spacer()
            ZStack(alignment: .init(horizontal: .center, vertical: .center)) {
                PDFKitRepresentedView(urls: URL(string: "\(list.path)/\(currentPage).pdf")!)
                
                HStack(alignment: .center){
                    
                    Button(action: {
                        currentPage -= 1
                        
                        print(currentPage)
                    }, label: {Image("previous").resizable().frame(width: 25, height: 122, alignment: .leading)})
                    .disabled(currentPage == 0)
                    
                    
                    Spacer()
                    
                    
                    Button(action: { currentPage += 1
                        //                                       var urls = nextButton(currentPage)
                        
                        print(currentPage)
                    }, label: {Image("next").resizable().frame(width: 25, height: 122, alignment: .leading)})
//                    .disabled(currentPage == total-1)
                    
                }
                .frame(alignment: .leading )
                
            }
            
        }.onAppear{
            list.getBookData()
        }
        
    }
}





//struct ContentView3: View {
//    var url = URL(string: "https://storage.googleapis.com/pdffilesalib/pdf/protectedpdf/101_Essential_Tips_Dog_Care_11/1.pdf")!
//    let password = "alib_3"
//
//    var body: some View {
////        PDFView(url: url, password: password)
//        PDFKitV()
//    }
//}



import SwiftUI
import PDFKit

struct PDFKitV : UIViewRepresentable {
    
    var url: URL?
    var document: PDFDocument?
    init(url: URL){
        self.url = url
    }
    func makeUIView(context: Context) -> UIView {
        var pdfView = PDFView()

        if let url = url {
            pdfView.document = PDFDocument(url: url)
//            pdfView.document?.delegate = context.coordinator
            pdfView.document?.unlock(withPassword: "alib_4")
        }
        return pdfView
    }
    func updateUIView(_ uiView: UIView, context: Context) {
        // Empty
    }
}
