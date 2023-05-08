//
//  StudentAuthenticationListService.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 14/07/23.
//

import Foundation
class StudentAuthenticationListService: ObservableObject {
    @Published var schoolBookCount: Int = 0// = Int()
    @Published var successPayCount = Int()
    @Published var rem_plan_days = String()
    @Published public var schoolStackCount = Int()
    @Published  var studentBookCount = Int()
    @Published public var studentStackCount = Int()
    @Published public var studentCoursesCount = Int()
    @Published public var studentTestsCount = Int()
    @Published public var studentPurchasedBookCount = Int()
    @Published public var studentHomeworkCount = Int()
    @Published public var ownBundleCount = Int()
    @Published public var partnerRCCount = Int()
    @Published public var partBookRCCount = Int()
    @Published public var liveSessionCount = Int()
    @Published public var remPlanDays = String()
    @Published public var isPlanExpired = Int()
    @Published public var planname = String()
    //
    func getDashBoardData() {
        
        let apiurl = "\(APILoginUtility.studentDashBoardApi)"
        guard let url = URL(string: apiurl) else {
            // handle invalid URL error
            return
        }
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
        let service = HTTPLoginUtility()
        
        service.getLoginData(from: url, model: StudentDashBoardModel.self, token: token){ (result) in
            switch result {
            case .success(let results):
                DispatchQueue.main.async {
                    self.schoolBookCount =  results.schoolBookCount
                    self.schoolStackCount = results.schoolStackCount
                    self.studentStackCount = results.studentStackCount
                    self.studentCoursesCount = results.studentCoursesCount
                    self.studentPurchasedBookCount = results.studentPurchasedBookCount
                    self.studentTestsCount = results.studentTestsCount
                    self.studentHomeworkCount = results.studentHomeworkCount
                    self.liveSessionCount = results.liveSessionCount
                    self.partnerRCCount = results.partnerRCCount
                    self.rem_plan_days = results.rem_plan_days
                    print(results)
                    
                }
            case .failure(let error):
                print(error.localizedDescription)
                
            }
            
        }
        
    }
    
}
