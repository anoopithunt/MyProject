//
//  PrimeBooksModel.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 16/09/22.
//

import Foundation
public struct BooksModel: Decodable {
    let bookDetails: BookDetails
    let bookSearch: String?
//    let uploadTypeID: Int?
    let stackID: String
    let data: Int
   
    enum CodingKeys: String, CodingKey {
        case bookDetails, bookSearch
//        case uploadTypeID = "upload_type_id"
        case stackID = "stack_id"
        case data
    }
}

public struct BookDetails: Decodable {
    let currentPage: Int
    let data: [Datum]
    let firstPageURL: String
    let from, lastPage: Int
    let lastPageURL, nextPageURL, path: String
    let perPage: Int
    let prevPageURL: String?
    let to, total: Int
    
    enum CodingKeys: String, CodingKey {
        case data, from, path, to, total
        case currentPage = "current_page"
        case firstPageURL = "first_page_url"
        case lastPage = "last_page"
        case lastPageURL = "last_page_url"
        case nextPageURL = "next_page_url"
        case perPage = "per_page"
        case prevPageURL = "prev_page_url"
    }
    
//    public init(from decoder: Decoder) throws {
//                    let values = try decoder.container(keyedBy: CodingKeys.self)
//                    self.data = try values.decodeIfPresent([Datum].self, forKey: .data)!
//                    self.currentPage = try values.decodeIfPresent(Int.self, forKey: .currentPage)!
//                    self.firstPageURL = try values.decodeIfPresent(String.self, forKey: .firstPageURL)!
//                    self.from = try values.decodeIfPresent(Int.self, forKey: .from)!
//                    self.lastPage = try values.decodeIfPresent(Int.self, forKey: .lastPage)!
//                    self.lastPageURL = try values.decodeIfPresent(String.self, forKey: .lastPageURL)!
//                    self.nextPageURL = try values.decodeIfPresent(String.self, forKey: .nextPageURL)!
//                    self.path = try values.decodeIfPresent(String.self, forKey: .path)!
//                    self.prevPageURL = try values.decodeIfPresent(String.self, forKey: .prevPageURL)!
//                    self.to = try values.decodeIfPresent(Int.self, forKey: .to)!
//                    self.total = try values.decodeIfPresent(Int.self, forKey: .total)!
//       }
}

public struct Datum : Hashable, Identifiable, Decodable  {
    public let id = UUID() // <-- could be Int
    public let title: String
    public let published: String
    public let url: String

    enum CodingKeys: String, CodingKey {
        case title, published, url
    }
    
    public init(from decoder: Decoder) throws {
           let values = try decoder.container(keyedBy: CodingKeys.self)
           self.title = try values.decodeIfPresent(String.self, forKey: .title)!
            self.published = try values.decodeIfPresent(String.self, forKey: .published)!
           self.url = try values.decodeIfPresent(String.self, forKey: .url)!
       }
    
    
}
