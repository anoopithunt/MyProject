//
//  ApiUtils.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 15/12/22.
//

import Foundation
// Here All Without Login APi List

struct ApiUtils
{
    static let baseURL: String = "https://www.alibrary.in/api/"
    
    
    static let publisherApiurl = "https://alibrary.in/api/publisherList"
    static let userGuideApi = baseURL + "userGuideTopics" 
    
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
    
    static let studentPaymentHistoryApi: String? = baseURL + "student/payment-history" //1
    static let guestSubscribeApi: String? = baseURL + "guest/userrcbooks"
    
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
    static let publicProfileApi: String = baseURL + "student/publicProfile?"  //https://alibrary.in/api/previewbook?id=17
    
    static let studentLibraryApi: String = baseURL + "student/select-library" //https://www.alibrary.in/api/student/select-library
    static let guestLibraryApi: String = baseURL + "guest/selectLibrary" //https://www.alibrary.in/api/guest/selectLibrary
    static let guestBookRequestListApi: String = baseURL + "guest/show-linkbookrequest?id=" //https://www.alibrary.in/api/guest/selectLibrary
    
    // MARK: Student Login API
    static let studentDashBoardApi = baseURL + "student/dashboard"
    static let schoolLibraryApi = baseURL + "student/school-libraries" //https://alibrary.in/api/student/school-libraries
    static let studentUploadApi = baseURL + "student/school-pdfs" //https://alibrary.in/api/
    static let studentStackApi = baseURL + "student/school-stacks" //https://alibrary.in/api/
    static let studentCourseApi = baseURL + "student/getcourseSubjects" //https://www.alibrary.in/api/student/getcourseSubjects
    static let studentHomeworkApi = baseURL + "student/homeworkSubject" //https://alibrary.in/api/student/homeworkSubject
    static let studentTeachersListApi = baseURL + "teacher-lists" //https://www.alibrary.in/api/teacher-lists
    static let studentBookbundleApi = baseURL + "student/own-bundle" //https://www.alibrary.in/api/student/own-bundle
    static let studentStoriesApi = baseURL + "student/view-blogs" //https://www.alibrary.in/api/student/view-blogs
    
    
    
}

//// Clean code for Api
//enum HTTPMethods: String {
//    case get = "GET"
//    case post = "POST"
//}
//
//protocol EndPointType {
//    var path: String { get }
////    var baseURL: String { get }
//    var url: URL? { get }
////    var method: HTTPMethods { get }
////    var body: Encodable? { get }
////    var headers: [String: String]? { get }
//}
//
//enum EndPoint {
//    case rcHistory // Module - GET
//    case getBooksData
//    case userPlan
//    case userProfile
//    case loginDashboard
//    case purchagedbooks
//    case stacks
//    case dashboard
//}
//
//
//
//extension EndPoint: EndPointType {
//    var baseURL: String  {
//
//        return "https://alibrary.in/api/"
//
//    }
//
//
//    var path: String {
//
//        switch self {
//        case .rcHistory:
//            return "guest/rc-history"
//        case .getBooksData:
//            return ""
//        case .loginDashboard:
//            return "guest/guestDashboard"
//        case .userPlan:
//            return "userplans"
//        case .userProfile:
//            return "guest/userProfileGuest"
//        case .purchagedbooks:
//            return "guest/guest-purchased-books"
//        case .stacks:
//            return "student/student-stacks"
//        case .dashboard:
//            return "guest/guestDashboard"
//        }
//    }
//
//    var url: URL? {
//        return URL(string: "\(baseURL)\(path)")
//    }
//}





enum APIEndpoint {
    static let baseURL: String = "https://www.alibrary.in/api/"

    enum Guest {
        static let loginAuthurl = baseURL + "auth/login"
        
        static let loginDashboardApi: String? =      baseURL + "guest/guestDashboard"
        static let loginUserPlan: String? =          baseURL + "userplans"
        static let userProfileGuest: String? =       baseURL + "guest/userProfileGuest"
      
        static let guestPurchagedbooksApi: String? = baseURL + "guest/guest-purchased-books"
        static let guestRCtransactionApi: String? =  baseURL + "guest/rc-history"
     
       
        
        static let guestSubscribeApi: String? =      baseURL + "guest/userrcbooks"

        static let bookRequest: String = baseURL + "guest/user-book-requests?request_type="
       
        
        
        static let uploadListDashboard: String = baseURL + "guest/ownpdfs?page="
        
        
        static let uploadListDraft: String = baseURL + "guest/draft-pdf?page="
        
         static let uploadListDelete: String = baseURL + "guest/unpublish-pdf?is_publish=4&page="
        
        static let unpublish: String = baseURL + "guest/unpublish-pdf?is_publish="
        
        static let publish: String = baseURL + "guest/publish-pdf"
        
        static let reportedBookList: String = baseURL + "guest/book-reports"
        
        static let previewBook: String = baseURL + "previewbook"
        
        static let selectLibrary: String = baseURL + "guest/selectLibrary"
    }

    enum Student {
        
        static let publicProfile: String = baseURL + "student/publicProfile?id="
        static let userAccountSettingAPi: String? =  baseURL + "student/userAccSetting"
        
        static let library: String = baseURL + "student/select-library"
        
        static let studentStacksApi: String? =       baseURL + "student/student-stacks"
        
        static let studentStacksBookListApi: String? = baseURL + "student/stack-book-list?id=" //790
        
        static let studentPaymentHistoryApi: String? = baseURL + "student/payment-history" //1
        
        
    }
}


//MARK: -   With this implementation, you can access each API endpoint using the . operator, like so:

//let guestBookRequestAPI = APIEndpoint.Guest.bookRequest
//let publicProfileAPI = APIEndpoint.Student.publicProfile



struct APIEndpoints {
    static let baseURL: String = "https://www.alibrary.in/api/"
    
    static var guestUploadListDashboardURL: URLComponents {
        var components = URLComponents(string: baseURL)!
        components.path = "/guest/ownpdfs"
        components.queryItems = [
            URLQueryItem(name: "page", value: "1")
        ]
        return components
    }
    
    static var guestUploadListDraftURL: URLComponents {
        var components = URLComponents(string: baseURL)!
        components.path = "/guest/draft-pdf"
        components.queryItems = [
            URLQueryItem(name: "page", value: "1")
        ]
        return components
    }
    
    // Define other endpoints using the same approach
}
