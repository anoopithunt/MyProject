//
//  PublisherTotalBooksUploadModel.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 24/09/23.
//

import Foundation

// MARK: - PublisherTotalBooksUpload
public struct PublisherTotalBooksUploadModel: Decodable {
    public let role_name: String
    public let books: PublisherTotalUploadBooks
    public let fromDate: String
    public let toDate: String
    public let type: String
//    public let data: Int

     
}

// MARK: - Books
public struct PublisherTotalUploadBooks : Decodable{
    public let current_page: Int
    public let data: [PublisherTotalBooksUploadDatum]
//    public let first_page_url: String
//    public let from: Int
    public let last_page: Int
//    public let last_page_url: String
//    public let next_page_url: String
//    public let path: String
//    public let per_page: Int
    public let total: Int
 
}

// MARK: - PublisherTotalBooksUploadDatum
public struct PublisherTotalBooksUploadDatum : Decodable{
    public let id: Int
    public let upload_type_id: Int
    public let name: String
//    public let pdf_url: String
//    public let html_url: String
//    public let tot_pages: Int
//    public let title: String
//    public let author_name: String
//    public let isbn_no: String?
//    public let publish_date: String
//    public let is_publish: Int
//    public let is_free: Int
//    public let is_active: Int
//    public let is_forschool: Int
//    public let is_industry: Int
//    public let age_from: String?
//    public let validity_date: String
//    public let has_media: String?
//    public let partner_id: Int
//    public let categroy_id: Int
    public let category_name: String
//    public let sub_category_id: Int
    public let subcategory_name: String
//    public let publisherName: String
//    public let approvedBy: String
    public let published: String?
//    public let createdAt: String
    public let url: String?
//    public let book_media: PublisherTotalUploadBookMedia
//    public let book_category_link: PublisherTotalUploadBookCategoryLink
//    public let book_partner_link: PublisherTotalUploadBookPartnerLink
//    public let partner_name: PublisherTotalBooksUploadPartnerName
//    public let approve_status: PublisherTotalBooksUploadApproveStatus
//
}

// MARK: - PublisherTotalBooksUploadApproveStatus
public struct PublisherTotalBooksUploadApproveStatus: Decodable {
    public let id: Int
    public let partner_id: Int
    public let book_id: Int
    public let status: String
    public let reason: String
    public let approved_by: PublisherTotalBooksUploadApprovedBy
 
}

// MARK: - PublisherTotalBooksUploadApprovedBy
public struct PublisherTotalBooksUploadApprovedBy: Decodable {
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

// MARK: - BookCategoryLink
public struct PublisherTotalUploadBookCategoryLink: Decodable {
    public let id: Int
    public let book_id: Int
    public let category_id: Int
    public let sub_category_id: Int
    public let category: PublisherTotalBooksUploadCategory
    public let sub_category: PublisherTotalBooksUploadSubCategory

    
}

// MARK: - PublisherTotalBooksUploadCategory
public struct PublisherTotalBooksUploadCategory : Decodable{
    public let id: Int
    public let parent_cat_id: Int
    public let category_name: String
    public let description: String
    public let desc_by: String
    public let url: String
    public let banner: String

     
}

// MARK: - PublisherTotalBooksUploadSubCategory
public struct PublisherTotalBooksUploadSubCategory : Decodable{
    public let id: Int
    public let parent_cat_id: Int
    public let category_name: String
    public let description: String

    
}

// MARK: - PublisherTotalBooksUploadBookMedia
public struct PublisherTotalUploadBookMedia : Decodable{
    public let id: Int
    public let book_media_type_id: Int
    public let media_type_id: Int
    public let book_id: Int
    public let url: String

    
}

// MARK: - PublisherTotalUploadBookPartnerLink
public struct PublisherTotalUploadBookPartnerLink : Decodable{
    public let id: Int
    public let partner_id: Int
    public let book_id: Int
    public let purchase_type: Int
    public let is_active: Int

   
}

// MARK: - PublisherTotalBooksUploadPartnerName
public struct PublisherTotalBooksUploadPartnerName: Decodable {
    public let id: Int
    public let full_name: String
    public let dob: String
    public let qr_code_url: String
    public let referal_code: String
 
}
