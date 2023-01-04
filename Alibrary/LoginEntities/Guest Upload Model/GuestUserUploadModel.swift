//
//  GuestUserUploadModel.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 19/04/23.
//

import Foundation


// MARK: - GuestUserUploadModel
public struct GuestUserUploadModel:Decodable {
    public let bookDetails: GuestUserUploadBookDetails
//    public let filter_type: String
//    public let partner_detail: GuestUserUploadPartnerDetail
//    public let status: Int

}

// MARK: - GuestUserUploadBookDetails
public struct GuestUserUploadBookDetails:Decodable {
    public let current_page: Int
    public let data: [GuestUserUploadDatum]
//    public let path: String
    public let total: Int

}

// MARK: - GuestUserUploadDatum
public struct GuestUserUploadDatum:Decodable {
    public let id: Int
//    public let upload_type_id: Int
    public let name: String
//    public let tot_pages: Int
    public let title: String
//    public let long_desc: String
//    public let meta_keyword: String
    public let author_name: String
//    public let isbn_no: String
//    public let validity_date: String
//    public let category_name: String
//    public let subcategory_name: String
    public let published: String
    public let book_media: GuestUserUploadBookMedia
    public let partner_name: GuestUserUploadPartnerName
    public let book_category_link: GuestUserUploadBookCategoryLink
    public let book_partner_link: GuestUserUploadBookPartnerLink

}

// MARK: - GuestUserUploadBookCategoryLink
public struct GuestUserUploadBookCategoryLink:Decodable {
    public let id: Int
    public let book_id: Int
    public let category_id: Int
    public let sub_category_id: Int
    public let category: GuestUserUploadCategory
    public let sub_category: GuestUserUploadSubCategory

}

// MARK: - GuestUserUploadCategory
public struct GuestUserUploadCategory :Decodable{
    public let id: Int
    public let parent_cat_id: Int
    public let category_name: String
    public let description: String
    public let desc_by: String

}

// MARK: - GuestUserUploadSubCategory
public struct GuestUserUploadSubCategory:Decodable {
    public let id: Int
    public let parent_cat_id: Int
    public let category_name: String

}

// MARK: - GuestUserUploadBookMedia
public struct GuestUserUploadBookMedia:Decodable {
    public let id: Int
    public let book_media_type_id: Int
    public let media_type_id: Int
    public let book_id: Int
    public let url: String

   
}

// MARK: - GuestUserUploadBookPartnerLink
public struct GuestUserUploadBookPartnerLink:Decodable {
    public let id: Int
    public let partner_id: Int
//    public let book_id: Int
    public let purchase_type: Int
    public let is_active: Int

}

// MARK: - GuestUserUploadPartnerName
public struct GuestUserUploadPartnerName :Decodable{
    public let id: Int
    public let partner_unique_id: String
    public let first_name: String?
    public let last_name: String?
    public let full_name: String?
    public let gender: String?
    public let dob: String?
    public let is_active: Int
    public let is_deleted: Int
    public let created_by: Int

}

// MARK: - GuestUserUploadPartnerDetail
public struct GuestUserUploadPartnerDetail:Decodable {
    public let id: Int
    public let partner_unique_id: String
    public let user_id: Int
    public let full_name: String
    public let dob: String
    public let qr_code_url: String
//    public let is_active: Int
    public let is_deleted: Int
    public let partner_role: GuestUserUploadPartnerRole

}

// MARK: - GuestUserUploadPartnerRole
public struct GuestUserUploadPartnerRole :Decodable{
    public let id: Int
    public let name: String
    public let guard_name: String
    
}
