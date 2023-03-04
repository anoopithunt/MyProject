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
    static let baseURL: String = "https://www.alibrary.in/api/"
    
    
    static let loginAuthurl = "https://www.alibrary.in/api/auth/login"
    
    static let loginDashboardApi: String? = "https://www.alibrary.in/api/guest/guestDashboard"
    
    static let loginUserPlan: String? = "https://www.alibrary.in/api/userplans"
    static let userProfileGuest: String? = "https://www.alibrary.in/api/guest/userProfileGuest"
    static let userAccountSettingAPi: String? = "https://www.alibrary.in/api/student/userAccSetting"
    static let guestPurchagedbooksApi: String? = "https://www.alibrary.in/api/guest/guest-purchased-books"
    static let guestRCtransactionApi: String? = "https://alibrary.in/api/guest/rc-history"
    static let studentStacksApi: String? = "https://alibrary.in/api/student/student-stacks"
    static let studentStacksBookListApi: String? = "https://alibrary.in/api/student/stack-book-list?id=" //790
    
    static let studentPaymentHistoryApi: String? = "https://www.alibrary.in/api/student/payment-history" //1
    static let guestSubscribeApi: String? = "https://www.alibrary.in/api/guest/userrcbooks"

    static let guestBookRequestApi: String = baseURL +   "guest/user-book-requests?request_type="//0&category_id=&sub_category_id="
//    static let guestBookRequestSelfApi: String? = "https://www.alibrary.in/api/guest/user-book-requests?request_type=1&category_id=&sub_category_id="
//    static let guestBookRequestOthersApi: String? = "https://www.alibrary.in/api/guest/user-book-requests?request_type=2&category_id=&sub_category_id="
   //Upload List 
    static let guestUploadListDashboardApi: String? = "https://alibrary.in/api/guest/ownpdfs?page="
    static let guestUploadListDraftApi: String? = baseURL + "guest/draft-pdf?page="
//    static let guestUploadListDraftApi: String? = "https://alibrary.in/api/guest/draft-pdf?page="
    static let guestUploadListDeleteApi: String? = baseURL + "guest/unpublish-pdf?is_publish=4&page="
    static let guestUnPublishedListDeleteApi: String? = "https://alibrary.in/api/guest/unpublish-pdf?is_publish=2"
    static let guestUnPublishedListApi: String = "https://alibrary.in/api/guest/unpublish-pdf?is_publish="
    static let guestUnPublishedApi: String = baseURL + "guest/unpublish-pdf?is_publish="
    static let guestPublishedApi: String = baseURL + "guest/publish-pdf"
    static let guestReportedBookListApi: String = baseURL + "guest/book-reports"
    static let preViewBooksApi: String = baseURL + "previewbook"  //https://alibrary.in/api/previewbook?id=17
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
