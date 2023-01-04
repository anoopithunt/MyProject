//
//  SearchBookModel.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 02/12/22.
//

import Foundation
public struct SearchBookModel: Decodable {
    public let bookDetails: SearchBookDetailsModel
    public let uploadTypes: [SearchBookUploadTypes]
}
public struct SearchBookUploadTypes: Decodable{
    public let id: Int
    public let name: String
    public let description: String
}



public struct SearchBookDetailsModel: Decodable {
    public let data: [SearchBookDatum]
    public let last_page: Int
}

// MARK: - Datum
public struct SearchBookDatum: Decodable {
    public let id: Int

    public let name: String
    public let tot_pages: Int
//    public let title: String
    public let author_name: String
    public let published: String
    public let publisherName: String
    public var totalLikes: Int
    public let url: String
//    public let book_media: SearchBookMedia
    
    
//    private enum CodingKeys: String, CodingKey {
//        case id, name, author_name, published, publisherName ,totalLikes, url, tot_pages
//    }
////
//    public init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.id = try container.decode(Int.self, forKey: .id)
//        self.name = try container.decode(String.self, forKey: .name)
//
//        self.totalLikes = try container.decode(Int.self, forKey: .totalLikes)
//        self.author_name = try container.decodeIfPresent(String.self, forKey: .author_name) ?? "-"
//
//        self.published = try container.decodeIfPresent(String.self, forKey: .published)!
//        self.publisherName = try container.decodeIfPresent(String.self, forKey: .publisherName)!
//        self.url = try container.decode(String.self, forKey: .url)
//        self.tot_pages = try container.decode(Int.self, forKey: .tot_pages)
//    }

}

// MARK: - BookMedia
public struct SearchBookMedia: Decodable {
    public let id: Int
    public let url: String

}
