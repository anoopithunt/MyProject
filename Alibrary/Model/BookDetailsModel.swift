//
//  BookDetailsModel.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 14/09/22.
//

import Foundation



public struct BookDetailCorouselModel:Decodable {
    public let bookDetails: [BookDetailModel]

}



public struct BookDetailModel: Decodable {
    public let id: Int
    public let title: String
    public let url: String
    public let category_name: String
    public let subcategory_name: String

  

}
