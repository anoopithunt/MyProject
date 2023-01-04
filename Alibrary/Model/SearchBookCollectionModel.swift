//
//  SearchBookCollectionModel.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 22/12/22.
//

import Foundation
public struct SearchBookCollectionModel:Decodable {
    public let bookDetails: SearchBookCollectionBookDetails
    public var uploadTypes: [SearchBookUploadType]
}

public struct SearchBookCollectionBookDetails:Decodable {
    public let data: [SearchBookCollectionData]
    public let last_page: Int
    public let per_page: Int
    public var last_page_url: String
}

public struct SearchBookCollectionData:Decodable {
        public let id: Int
        public let upload_type_id: Int
        public let name: String
        public let title: String
        public let author_name: String
        public let tot_view: Int
        public let published: String
        public let categroy_id: Int
        public let category_name: String
        public let totalLikes: Int
        public let url: String
        public let publisherName: String
        public let upload_type: PrimeBookUploadType

}

public struct PrimeBookUploadType:Decodable {
    public let id: Int
    public let name: String
    public let description: String

  
}

public struct SearchBookUploadType:Decodable{
  var  id: Int
    var name: String
    var description: String
}
