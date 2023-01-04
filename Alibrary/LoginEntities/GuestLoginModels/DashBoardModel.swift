//
//  DashBoardModel.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 20/01/23.
//

import Foundation
public struct DashBoardModel: Decodable {
    public let guestBooks: Int
    public let guestStacks: Int
    public let ownBooks: Int
    public let ownStacks: Int
    public let testCount: Int
    public let totalRC: Int
    public let courseCount: Int
    public let purchasedBooks: Int
    public let partnerBookRCs: Int
    public let bookRequestCount: Int
    public let rcFundCounts: Int
    public let rem_plan_days: String
    public let successPayCount: Int
    public let data: Int

}

