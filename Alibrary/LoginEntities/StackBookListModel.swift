//
//  StackBookListModel.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 15/02/23.
//

import Foundation


// MARK: - Welcome
public struct StackBookListModel:Decodable {
    public let stackBook_details: StackBookDetails

}

// MARK: - StackBookDetails
public struct StackBookDetails:Decodable {
    public let current_page: Int
    public let data: [StackBookListDatum]
    public let total: Int

}

// MARK: - Datum
public struct StackBookListDatum:Decodable {
    public let id: Int
    public let stack_details: StackBookListDetails
    public let stack_book: StackBookList
    public let book_media: StackBookListMedia
    public let partner_stack: PartnerBookListStack

}

// MARK: - BookMedia
public struct StackBookListMedia:Decodable {
    public let id: Int
//    public let book_id: Int
    public let url: String
//    public let created_at: Int

}

// MARK: - PartnerStack
public struct PartnerBookListStack:Decodable {
    public let id: Int
    public let partner_detail: PartnerDetail

}

// MARK: - PartnerDetail
public struct PartnerDetail:Decodable {
    public let id: Int
    public let dob: String

}

// MARK: - StackBook
public struct StackBookList:Decodable {
    public let id: Int
    public let upload_type_id: Int
    public let name: String
    public let tot_pages: Int
    public let title: String
    public let author_name: String
    public let isbn_no: String
    public let size: String
    public let publish_date: String
    public let validity_date: String
    public let published: String

}

// MARK: - StackDetails
public struct StackBookListDetails:Decodable {
    public let id: Int
    public let name: String
    public let description: String

}

// MARK: - StackDetail

//public struct StackDetail:Decodable {
//    public let id: Int
//    public let name: String
//    public let description: String
//    public let copyStack: [Any?]
//
//}
