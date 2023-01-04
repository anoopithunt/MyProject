//
//  ShowBookDetailsModel.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 16/11/22.
//

import Foundation

public struct ShowBookDetailsModel: Decodable {
    public let bookDetails: ShowBookDetailsData
    public let relatedBooks: [RelatedBooks]

}

// MARK: - BookDetails
public struct ShowBookDetailsData: Decodable {
    public let id: Int
    public let name: String
    public let tot_pages: Int 
    public let title: String
    public let long_desc: String
    public let author_name: String
    public let category_name: String
    public let subcategory_name: String
    public let published: String
    public let isbn_no: String
    public let book_media:ShowBookDetailMedia

}



public struct ShowBookDetailMedia:Decodable,Hashable {
    public var id: Int
    public let book_id: Int
    public let bookurl: String
    enum CodingKeys: String, CodingKey{
        case id
        case book_id
        case bookurl = "url"
    }

}

public struct RelatedBooks: Decodable{
    public var id: Int
    public let  book_media: RelatedBooksMedia

}

public struct RelatedBooksMedia: Decodable, Hashable{
    public var id: Int
    public var url: String
}
