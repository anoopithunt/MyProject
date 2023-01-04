//
//  GuestStackBookListModel.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 19/04/23.
//

import Foundation



// MARK: - GuestStackBookListModel
public struct GuestStackBookListModel:Decodable {
//    public let stack_detail: GuestStackBookListStackDetail
    public let stackBook_details: GuestStackBookListStackBookDetails
//    public let success: String
//    public let data: Int

}

// MARK: - StackBookDetails
public struct GuestStackBookListStackBookDetails:Decodable  {
    public let current_page: Int
    public let data: [GuestStackBookListDatum]
//    public let to: Int
    public let total: Int

}

// MARK: - GuestStackBookListDatum
public struct GuestStackBookListDatum :Decodable {
    public let id: Int
//    public let stack_id: Int
//    public let book_id: Int
    public let createdBy: String?
//    public let stack_details: GuestStackBookListStackDetails
    public let stack_book: GuestStackBookListStackBook
    public let book_media: GuestStackBookListBookMedia
//    public let partner_stack: GuestStackBookListPartnerStack

   
}

// MARK: - GuestStackBookListBookMedia
public struct GuestStackBookListBookMedia:Decodable  {
    public let id: Int
//    public let book_media_type_id: Int
//    public let media_type_id: Int
    public let book_id: Int
    public let url: String
//    public let created_by: Int

}

// MARK: - GuestStackBookListPartnerStack
public struct GuestStackBookListPartnerStack :Decodable {
    public let id: Int
    public let partner_id: Int
    public let stack_id: Int
    public let is_active: Int
    public let partner_detail: GuestStackBookListPartnerDetail

}

// MARK: - GuestStackBookListPartnerDetail
public struct GuestStackBookListPartnerDetail:Decodable  {
    public let id: Int
    public let partner_unique_id: String
    public let first_name: String
    public let last_name: String
    public let full_name: String
    public let gender: String
    public let dob: String

}

// MARK: - GuestStackBookListStackBook
public struct GuestStackBookListStackBook:Decodable  {
    public let id: Int
//    public let upload_type_id: Int
    public let name: String?
//    public let pdf_url: String
//    public let html_url: String
//    public let tot_pages: Int
    public let title: String
//    public let long_desc: String
//    public let meta_keyword: String
    public let author_name: String?
//    public let isbn_no: String
//    public let size: String
//    public let publish_date: String
//    public let is_deleted: Int
//    public let ownership: String
//    public let validity_date: String
    public let published: String?

}

// MARK: - GuestStackBookListStackDetails
public struct GuestStackBookListStackDetails:Decodable  {
    public let id: Int
    public let name: String
    public let description: String

}

// MARK: - GuestStackBookListStackDetail
public struct GuestStackBookListStackDetail :Decodable {
    public let id: Int
    public let name: String
    public let description: String
//    public let copyStack: [Any?]
 
}
