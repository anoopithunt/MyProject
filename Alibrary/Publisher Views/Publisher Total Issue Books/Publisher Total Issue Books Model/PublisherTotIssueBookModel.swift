//
//  PublisherTotIssueBookModel.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 24/09/23.
//

import Foundation

// MARK: - PublisherTotIssueBookModel
public struct PublisherTotIssueBookModel: Decodable {
    public let bookDetails: PublisherTotIssueBookDetails
//    public let bookType: String
//    public let search: String
//    public let data: Int

    
}

// MARK: - PublisherTotIssueBookDetails
public struct PublisherTotIssueBookDetails: Decodable {
    public let current_page: Int
    public let data: [PublisherTotIssueBookDatum]
    public let last_page: Int
//    public let lastPageurl: String
//    public let nextPageurl: String
//    public let path: String
//    public let perPage: Int
    public let to: Int?
    public let total: Int

    
}

// MARK: - PublisherTotIssueBookDatum
public struct PublisherTotIssueBookDatum : Decodable{
    public let id: Int
//    public let upload_type_id: Int
//    public let name: String
//    public let pdf_url: String
//    public let tot_pages: Int
    public let title: String
//    public let long_desc: String
//    public let meta_keyword: String
//    public let author_name: String
//    public let isbn_no: String?
//    public let size: String?
//    public let tot_like: Int?
//    public let tot_view: Int?
    public let publish_date: String
//    public let validity_date: String
    
    public let is_forschool: Int
//    public let created_at: String
//    public let partner_id: Int
//    public let categroy_id: Int
    public let category_name: String
    public let sub_category_id: Int
    public let subcategory_name: String
//    public let publisherName: String
    public let approvedBy: String
//    public let published: String
    public let url: String
//    public let book_partner_link: PublisherTotIssueBookPartnerLink
//    public let book_category_link: PublisherTotIssueBookCategoryLink?
//    public let partner_name: PublisherTotIssueBookPartnerName
//    public let approve_status: PublisherTotIssueBookApproveStatus?
//    public let book_media: PublisherTotIssueBookMedia

     
}

// MARK: - PublisherTotIssueBookApproveStatus
public struct PublisherTotIssueBookApproveStatus: Decodable {
    public let id: Int
    public let partner_id: Int
    public let book_id: Int
    public let status: String
    public let reason: String
    public let created_by: Int
    public let approved_by: PublisherTotIssueBookApprovedBy
 
}

// MARK: - PublisherTotIssueBookApprovedBy
public struct PublisherTotIssueBookApprovedBy: Decodable {
    public let id: Int
    public let partner_unique_id: String
    public let partner_library_id: String
    public let user_id: Int
    public let first_name: String
    public let last_name: String
    public let full_name: String
    public let gender: String
    public let referal_code: String

    
}

// MARK: - PublisherTotIssueBookCategoryLink
public struct PublisherTotIssueBookCategoryLink: Decodable {
    public let id: Int
    public let book_id: Int
    public let category_id: Int
    public let sub_category_id: Int
    public let created_by: Int
    public let category: PublisherTotIssueBookCategory
    public let sub_category: PublisherTotIssueBookSubCategory
 
}

// MARK: - PublisherTotIssueBookCategory
public struct PublisherTotIssueBookCategory: Decodable {
    public let id: Int
    public let parent_cat_id: Int
    public let category_name: String
    public let description: String
    public let desc_by: String
    public let url: String
    public let banner: String
 
}

// MARK: - PublisherTotIssueBookSubCategory
public struct PublisherTotIssueBookSubCategory: Decodable {
    public let id: Int
    public let parent_cat_id: Int
    public let category_name: String
    public let description: String?
 
}

// MARK: - PublisherTotIssueBookMedia
public struct PublisherTotIssueBookMedia: Decodable {
    public let id: Int
    public let book_media_type_id: Int
    public let media_type_id: Int
    public let url: String

    
}

// MARK: - PublisherTotIssueBookPartnerLink
public struct PublisherTotIssueBookPartnerLink: Decodable {
    public let id: Int
    public let partner_id: Int
    public let book_id: Int
 
}

// MARK: - PublisherTotIssueBookPartnerName
public struct PublisherTotIssueBookPartnerName: Decodable {
    public let id: Int
    public let partner_unique_id: String
    public let full_name: String
    public let dob: String
    public let qr_code_url: String
    
}
