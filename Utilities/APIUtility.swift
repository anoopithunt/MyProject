//
//  APIUtility.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 19/12/22.
//

import Foundation
struct ApiUtils
{
    static let loginAuthurl = "https://www.alibrary.in/api/auth/login"
    
    static let homePageApi = "https://www.alibrary.in/api/web-home"
    
    static let publisherApiurl = "https://alibrary.in/api/publisherList"
    
    
//    static let loginDashboardApi: String? = "https://www.alibrary.in/api/guest/guestDashboard"
    
    static let searchBooksCollectionApiurl: String? = "https://alibrary.in/api/book-search?page="
    

}


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
    static let studentStacksBookListApi: String? = baseURL + "student/stack-book-list?id=" //790
    
    static let studentPaymentHistoryApi: String? = "https://www.alibrary.in/api/student/payment-history?&page=1" //1
    static let guestUploadListDashboardApi: String? = "https://alibrary.in/api/guest/ownpdfs?page="
    static let guestUploadListDeleteApi: String? = baseURL + "guest/unpublish-pdf?is_publish=4&page="
    static let guestUnPublishedListDeleteApi: String? = "https://alibrary.in/api/guest/unpublish-pdf?is_publish=2"
    static let guestUnPublishedListApi: String = "https://alibrary.in/api/guest/unpublish-pdf?is_publish="
    static let guestUnPublishedApi: String = baseURL + "guest/unpublish-pdf?is_publish="
    static let guestPublishedApi: String = baseURL + "guest/publish-pdf"
    static let guestReportedBookListApi: String = baseURL + "guest/book-reports"
    static let preViewBooksApi: String = baseURL + "previewbook"  //https://alibrary.in/api/previewbook?id=17
    static let guestLibraryApi: String = baseURL + "guest/selectLibrary" //https://www.alibrary.in/api/guest/selectLibrary
    
}
