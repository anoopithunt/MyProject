//
//  PublisherMyEarningModel.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 24/09/23.
//

import Foundation


//MARK: PublisherMyEarningModel

public struct PublisherMyEarningModel: Decodable {
    public let totalbookcount: Int
    public let totalPublisehrEarned: Int
    public let totCountRC: Int
    public let totalRCEarn: Int
    public let totalEarned: Int
//    public let partner: PublisherMyEarningPartner
}


// MARK: - PublisherMyEarningPartner
public struct PublisherMyEarningPartner: Decodable {
    public let id: Int
    public let partner_unique_id: String
    public let role_id: Int
    public let full_name: String
    public let dob: String
    public let qr_code_url: String
    public let partner_role: PublisherMyEarningPartnerRole
 
}

// MARK: - PublisherMyEarningPartnerRole
public struct PublisherMyEarningPartnerRole: Decodable {
    public let id: Int
    public let name: String
    public let guard_name: String
 
}


