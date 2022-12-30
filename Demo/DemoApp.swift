//
//  DemoApp.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 05/08/22.
//

import SwiftUI
import FirebaseCore


//class AppDelegate: NSObject, UIApplicationDelegate {
//  func application(_ application: UIApplication,
//                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//      
//    FirebaseApp.configure()
//
//    return true
//  }
//}

@main
struct DemoApp: App {
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    var body: some Scene {
        WindowGroup {
          
            LoginPageView()
//            PurchagedBooksView()
//            ContentView()
            
        }
    }
}

