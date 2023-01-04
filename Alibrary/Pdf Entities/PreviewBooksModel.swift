//
//  PreviewBooksModel.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 29/03/23.
//

import Foundation


 //MARK: - PreviewBooksModel
public struct PreviewBooksModel: Decodable {
    public let book: PreviewModel

}

// MARK: - Book
public struct PreviewModel: Decodable {
    public let id: Int
    public let name: String
    public let tot_pages: Int
    public let title: String
    public let author_name: String
    public let tot_likes: String?
    public let tot_view: Int?
    public let validity_date: String
    public let pdf_path: String
    public let published: String
    public let published_date: String
    public let url: String
    public let protectedpdf: String
    public let demo: String
    public let thumbnail: String

}

enum SheetItem: Identifiable {
     
    case addStack
    case publisher
    var id: Self {
            self
        }
}
