//
//  GuestUserStackModel.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 19/04/23.
//

import Foundation


// MARK: - GuestUserStackModel

public struct GuestUserStackModel:Decodable {
    public let stacks: GuestUserStackStacks
//    public let partner: GuestUserStackPartner
//    public let data: Int

}

// MARK: - Partner
public struct GuestUserStackPartner:Decodable {
    public let id: Int
    public let partner_unique_id: String
//    public let user_id: Int
    public let dob: String
    public let qr_code_url: String
    public let referal_code: String
    public let partner_role: GuestUserStackPartnerRole

}

// MARK: - PartnerRole
public struct GuestUserStackPartnerRole:Decodable {
    public let id: Int
    public let name: String
    public let guard_name: String

}

// MARK: - Stacks
public struct GuestUserStackStacks:Decodable {
    public let current_page: Int
    public let data: [GuestUserStackDatum]
    public let total: Int

}

// MARK: - Datum
public struct GuestUserStackDatum:Decodable {
    public let id: Int
    public let name: String
    public let description: String
    public let stack_book_links_count: Int
    public let stack_book_links: [GuestUserStackStackBookLink]
    public let bookcount: Int
    public let createdBy: String

}

// MARK: - StackBookLink
public struct GuestUserStackStackBookLink:Decodable {
    public let id: Int
    public let stack_id: Int
    public let book_id: Int
    public let url: String
//    public let stack_book: GuestUserStackStackBook

}

// MARK: - StackBook
public struct GuestUserStackStackBook:Decodable {
    public let id: Int
    public let upload_type_id: Int
    public let name: String
    public let pdf_url: String
    public let html_url: String
    public let title: String
    public let author_name: String
    public let isbn_no: String
    public let size: String
    public let tot_likes: String
    public let tot_view: Int
    public let publish_date: String
//    public let validity_date: String
    public let book_partner_link: GuestUserStackBookPartnerLink
    public let book_media: GuestUserStackBookMedia

}

// MARK: - BookMedia
public struct GuestUserStackBookMedia:Decodable {
    public let id: Int
    public let book_media_type_id: Int
    public let media_type_id: Int
    public let book_id: Int
    public let url: String

}

// MARK: - BookPartnerLink
public struct GuestUserStackBookPartnerLink:Decodable {
    public let id: Int
    public let partner_id: Int
    public let book_id: Int

}

