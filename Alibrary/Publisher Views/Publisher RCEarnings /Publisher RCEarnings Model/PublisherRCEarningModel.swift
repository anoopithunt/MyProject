//
//  PublisherRCEarningModel.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 24/09/23.
//

import Foundation

// MARK: - PublisherRCEarningModel
public struct PublisherRCEarningModel: Decodable {
   public let months: [String: String]
   public let years: [Int]
   public let currentmonth: String
   public let currentyear: String
//    public let totCountRC: Int
//    public let totRCValue: Int
   public let rcbooks: PublisherRCEarningBooks
  
}

// MARK: - PublisherRCEarningBooks
public struct PublisherRCEarningBooks:Decodable {
   public let current_page: Int
   public let data: [PublisherRCEarningDatum]
//    public let first_page_url: String
//    public let from: Int
   public let last_page: Int
//    public let to: Int
//    public let total: Int

   
}

// MARK: - PublisherRCEarningDatum
public struct PublisherRCEarningDatum: Decodable {
   public let id: Int
//    public let object_type: String
//    public let object_id: Int
//    public let rc_count: Int
//    public let type: String
//    public let source: String
//    public let description: String
   public let tot_rccount: Int
   public let tot_rcvalue: Int
   public let book_url: String
   public let book_name: String

}
