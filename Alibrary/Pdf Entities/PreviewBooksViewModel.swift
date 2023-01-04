//
//  PreviewBooksViewModel.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 29/03/23.
//

import Foundation


class PreviewBooksViewModel: ObservableObject{

    @Published var path = String()
    @Published var totatPages = Int()
    @Published var bookName = String()
    @Published var pdfs:Int = Int()
    @Published var currentPage = 1
    @Published var id = 1
    
    @Published var pageUrl = String()
    @Published var thumbnail = String()
    
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
                        self.id = results.book.id
                        self.bookName = results.book.title
                        self.totatPages = results.book.tot_pages
                        self.thumbnail = results.book.thumbnail
                        self.pageUrl = "\(results.book.pdf_path)/\(self.currentPage).pdf"
                        if self.totatPages % 2 == 0 {
                            self.pdfs = (self.totatPages + 2) / 2
                        } else{
                            self.pdfs = (self.totatPages + 1)/2
                        }
                        
                        print("\(self.path)")
                        print("\(self.pdfs)")
                        
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }

    }
}

