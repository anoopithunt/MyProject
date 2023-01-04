//
//  HomePublisherModel.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 24/09/22.
//

import Foundation
public struct HomePublisherModel: Decodable {
    public var userslists: [UsersList]
}

public struct UsersList:Decodable, Hashable {
        public var id: Int
       public var fullName: String
       public var totalBooks: Int?
       public var fullAddress: String?
       public var logoUrl: String
       
       private enum CodingKeys: String, CodingKey {
           case id, totalBooks
           case fullName = "full_name"
           case fullAddress = "full_address"
           case logoUrl = "logo_url"
       }
    
}
