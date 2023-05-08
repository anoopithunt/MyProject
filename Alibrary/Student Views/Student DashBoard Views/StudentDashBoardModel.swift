//
//  StudentDashBoardModel.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 14/07/23.
//

import Foundation

// MARK: Student Model
 
public struct StudentDashBoardModel:Decodable {
    public let schoolBookCount: Int
    public let schoolStackCount: Int
    public let studentBookCount: Int
    public let studentStackCount: Int
    public let studentCoursesCount: Int
    public let studentTestsCount: Int
    public let studentPurchasedBookCount: Int
    public let studentHomeworkCount: Int
    public let ownBundleCount: Int
    public let partnerRCCount: Int
    public let partBookRCCount: Int
    public let liveSessionCount: Int
    public let rem_plan_days: String
    public let isPlanExpired: Int
    public let planname: String
    public let successPayCount: Int
 
}

