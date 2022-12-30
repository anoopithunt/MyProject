//
//  ApiUtils.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 15/12/22.
//

import Foundation
// Here All Without Login APi List

struct ApiUtils
{
    static let publisherApiurl = "https://alibrary.in/api/publisherList"
    
    static let loginDashboardApi: String? = "https://www.alibrary.in/api/guest/guestDashboard"
    
    static let searchBooksCollectionApiurl: String? = "https://alibrary.in/api/book-search?page="

}

// Here All Login APi List

struct APILoginUtility
{
    static let loginAuthurl = "https://www.alibrary.in/api/auth/login"
   
    static let loginDashboardApi: String? = "https://www.alibrary.in/api/guest/guestDashboard"
   
    static let loginUserPlan: String? = "https://www.alibrary.in/api/userplans"
    static let userProfileGuest: String? = "https://www.alibrary.in/api/guest/userProfileGuest"
    static let userAccountSettingAPi: String? = "https://www.alibrary.in/api/student/userAccSetting"
    static let guestPurchagedbooksApi: String? = "https://www.alibrary.in/api/guest/guest-purchased-books"
    
    //static let guestStracksApi: String? = "https://alibrary.in/api/student/student-stacks"
    static let guestRCtransactionApi: String? = "https://alibrary.in/api/guest/rc-history"
    static let studentStacksApi: String? = "https://alibrary.in/api/student/student-stacks"
}

// Clean code for Api 
enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
}

protocol EndPointType {
    var path: String { get }
//    var baseURL: String { get }
    var url: URL? { get }
//    var method: HTTPMethods { get }
//    var body: Encodable? { get }
//    var headers: [String: String]? { get }
}

enum EndPoint {
    case rcHistory // Module - GET
    case getBooksData
    case userPlan
    case userProfile
    case loginDashboard
    case purchagedbooks
    case stacks
    case dashboard
}



extension EndPoint: EndPointType {
    var baseURL: String  {
        
        return "https://alibrary.in/api/"
        
    }
    
    
    var path: String {
        
        switch self {
        case .rcHistory:
            return "guest/rc-history"
        case .getBooksData:
            return ""
        case .loginDashboard:
            return "guest/guestDashboard"
        case .userPlan:
            return "userplans"
        case .userProfile:
            return "guest/userProfileGuest"
        case .purchagedbooks:
            return "guest/guest-purchased-books"
        case .stacks:
            return "student/student-stacks"
        case .dashboard:
            return "guest/guestDashboard"
        }
    }
    
    var url: URL? {
        return URL(string: "\(baseURL)\(path)")
    }
}
