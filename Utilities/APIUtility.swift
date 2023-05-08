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
    
    // MARK: Student Login Api
    
    static let studentDashBoardApi = baseURL + "student/dashboard"
    static let schoolLibraryApi = baseURL + "student/school-libraries" //https://alibrary.in/api/student/school-libraries
    static let studentUploadApi = baseURL + "student/school-pdfs" //https://alibrary.in/api/
    static let studentStackApi = baseURL + "student/school-stacks" //https://alibrary.in/api/
    static let studentCourseApi = baseURL + "student/getcourseSubjects" //https://www.alibrary.in/api/student/getcourseSubjects
    static let studentHomeworkApi = baseURL + "student/homeworkSubject" //https://alibrary.in/api/student/homeworkSubject
    static let studentTeachersListApi = baseURL + "teacher-lists" //https://www.alibrary.in/api/teacher-lists
    static let studentBookbundleApi = baseURL + "student/own-bundle" //https://www.alibrary.in/api/student/own-bundle
    static let studentBookbundleDetailApi = baseURL + "student/bundle-book-list?id=" //https://alibrary.in/api/student/bundle-book-list?id=554
    static let studentStoriesApi = baseURL + "student/view-blogs" //https://www.alibrary.in/api/student/view-blogs
    static let studentExamTestApi = baseURL + "student/getsubjects" //https://alibrary.in/api/student/getsubjects
    
    
    
    
    // MARK: Publisher Login API
    
    
    static let publisherDashboardApi = baseURL + "publisher/dashboard"//https://www.alibrary.in/api/publisher/dashboard
    static let publisherMyEarningApi = baseURL + "publisher/my-earnings"
            //https://www.alibrary.in/api/publisher/my-earnings
    static let publisherIssueBooksApi = baseURL + "publisher/publisher-book"
            //"https://alibrary.in/api/publisher/publisher-book?book_type=\(self.bookType)&page=\(self.currentPage)"
   static let publisherRCEarningApi = baseURL + "publisher/mRC-earned"
            //""https://alibrary.in/api/publisher/mRC-earned?month=\(self.sel_month)&year=\(self.sel_year)&page=\(self.currentPage)""
    static let bookRequestApi = baseURL + "guest/view-bookrequest"
            //""https://alibrary.in/api/publisher/mRC-earned?month=\(self.sel_month)&year=\(self.sel_year)&page=\(self.currentPage)""
    
}
