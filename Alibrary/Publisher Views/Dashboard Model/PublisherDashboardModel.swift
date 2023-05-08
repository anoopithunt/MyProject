//
//  PublisherDashboardModel.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 24/09/23.
//

import Foundation


// MARK: - PublisherDashboardModel
public struct PublisherDashboardModel: Decodable {
    public let allBookCount: Int
    public let primeBookCount: Int
    public let freeBookCount: Int
    public let paidBookCount: Int
//    public let allStack: [Any?]
    public let allSoldBooksCount: Int
    public let months: [String]
    public let purchBookCounts: [Int]
    public let totreadbooks: [Double]
    public let finalRCCounts: [Double]
    public let totalUploads: [Int]
    public let uploadTotMags: [Double]
    public let rcFundCounts: Int
    public let bookRequestCounts: Int
    public let rem_plan_days: String
    public let isPlanExpired: Int
    public let planname: String
    public let data: Int

    
}
