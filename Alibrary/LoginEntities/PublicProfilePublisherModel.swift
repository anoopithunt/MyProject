//
//  PublicProfilePublisherModel.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 03/04/23.
//

import Foundation



// MARK: - PublicProfilePublisher
public struct PublicProfilePublisher :Decodable{
    public let userDetails: PublicProfilePublisherDetails
    public let books: PublicProfilePublisherBooks
//    public let stackDetails: [Any?]
    public let uploadType: [PublicProfilePublisherUploadType]
//    public let teachCount: String
//    public let stuCount: String
    public let followers: Int?  //Followers
//    public let loginUser: PublicProfilePublisherLoginUser
////    public let bookSearch: NSNull
//    public let type: String
//    public let data: Int

}

// MARK: - PublicProfilePublisherBooks
public struct PublicProfilePublisherBooks:Decodable {
    public let current_page: Int
    public let data: [PublicProfilePublisherDatum]
//    public let first_page_url: String
//    public let from: Int
    public let last_page: Int?
//    public let last_page_url: String
//    public let next_page_url: String
//    public let path: String
//    public let per_page: Int
//    public let prev_page_url: String?
//    public let to: Int
    public let total: Int?

    
}

// MARK: - PublicProfilePublisherDatum
public struct PublicProfilePublisherDatum:Decodable {
    public let id: Int
//    public let upload_type_id: Int
//    public let name: String
//    public let pdf_url: String
//    public let html_url: String
//    public let tot_pages: Int
//
    public let title: String
//    public let long_desc: String
//    public let meta_keyword: String
//    public let author_name: String
//    public let isbn_no: String
    public let is_free: Int?
    public let tot_likes: String?
    public let tot_view: Int?
    public let publish_date: String
    public let validity_date: String
    public let published: String
    public let book_media: PublicProfilePublisherBookMedia
//    public let book_partner_link: PublicProfilePublisherBookPartnerLink
 
}

// MARK: - PublicProfilePublisherBookMedia
public struct PublicProfilePublisherBookMedia:Decodable {
    public let id: Int
    public let url: String
    public let created_by: Int
}

// MARK: - PublicProfilePublisherBookPartnerLink
public struct PublicProfilePublisherBookPartnerLink:Decodable {
    public let id: Int
    public let partner_id: Int
    public let book_id: Int

}

// MARK: - PublicProfilePublisherLoginUser
public struct PublicProfilePublisherLoginUser:Decodable {
    public let id: Int
    public let partner_unique_id: String
    public let user_id: Int
    public let first_name: String
    public let last_name: String
    public let full_name: String
    public let dob: String
    public let qr_code_url: String
    public let referal_code: String
    public let partner_role: PublicProfilePublisherPartnerRole

}

// MARK: - PublicProfilePublisherPartnerRole
public struct PublicProfilePublisherPartnerRole:Decodable {
    public let id: Int
    public let name: String
    public let guard_name: String

}

// MARK: - PublicProfilePublisherUploadType
public struct PublicProfilePublisherUploadType:Decodable {
    public let id: Int
    public let name: String
    public let description: String

}

// MARK: - PublicProfilePublisherDetails
public struct PublicProfilePublisherDetails:Decodable {
    public let id: Int
    public let partner_unique_id: String
    public let full_name: String
    public let qr_code_url: String
    public let partner_media: [PublicProfilePublisherPartnerMedia]
    public let address_link: PublicProfilePublisherAddressLink
    public let partner_role: PublicProfilePublisherPartnerRole
    public let user_data: PublicProfilePublisherUserData
//    public let partnerFollow: NSNull

}

// MARK: - PublicProfilePublisherAddressLink
public struct PublicProfilePublisherAddressLink:Decodable {
    public let id: Int
    public let partner_id: Int
    public let address_id: Int
//    public let createdBy: Int
    public let address: PublicProfilePublisherAddress

}

// MARK: - PublicProfilePublisherAddress
public struct PublicProfilePublisherAddress:Decodable {
    public let id: Int
    public let mobile_1: String
    public let email_id: String

}

// MARK: - PublicProfilePublisherPartnerMedia
public struct PublicProfilePublisherPartnerMedia:Decodable {
    public let id: Int
    public let partner_media_type_id: Int
    public let media_type_id: Int
    public let partner_id: Int
    public let url: String
    public let partnerMediatype: String
    public let partner_media_type: PublicProfilePublisherPartnerMediaType

}

// MARK: - PublicProfilePublisherPartnerMediaType
public struct PublicProfilePublisherPartnerMediaType:Decodable {
    public let id: Int
    public let type: String
    public let description: String
    public let is_active: Int

}

// MARK: - PublicProfilePublisherUserData
public struct PublicProfilePublisherUserData:Decodable {
    public let id: Int
    public let name: String
    public let username: String
    public let email: String

}


