//
//  BookSuggestionModel.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 22/10/23.
//

import Foundation


// MARK: - BookSuggestionModel
public struct BookSuggestionModel:Decodable {
//    public let userbookrequest: Userbookrequest
    public let books:  SuggestionBooks
//    public let role: String
//    public let bookSearch: String
//    public let is_accepted: Int
 
}

 
// MARK: -  SuggestionBooks
public struct  SuggestionBooks :Decodable{
    public let current_page: Int
    public let data: [BookSuggestionDatum]
    public let last_page: Int
//    public let to: Int
//    public let total: Int
    
    
}

// MARK: - BookSuggestionDatum
public struct BookSuggestionDatum : Decodable {
    public let id: Int
    public let title: String
    public let book_url: String
    public let published: String
    public let uploaded_by: String
//    public let category_name: String
//    public let subcategory_name: String

}

// MARK: - Userbookrequest
public struct Userbookrequest: Decodable {
    public let id: Int
    public let partner_id: Int
    public let description: String
    public let partner_name: String
    public let partner_logo: String
    public let category_name: String
    public let sub_category_id: Int
    public let subcategory_name: String
    public let end_date: String
    public let for_book: Int
 
}
