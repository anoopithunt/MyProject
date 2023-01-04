//
//  UploadListDashboardModel.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 15/03/23.
//

import Foundation

// MARK: - UploadListDashboardModel
public struct UploadListDashboardModel:Decodable {
    public let publishPDFs: Int
    public let unPublishPDFs: Int
    public let draftPdfs: Int
    public let deletePdfs: Int
    public let partner: UploadListDashboardPartner
    public let data: Int

}

// MARK: - UploadListDashboardPartner

public struct UploadListDashboardPartner:Decodable {
    public let id: Int
    public let first_name: String?
    public let last_name: String?
    public let full_name: String?
    public let gender: String?
    public let dob: String?

}
