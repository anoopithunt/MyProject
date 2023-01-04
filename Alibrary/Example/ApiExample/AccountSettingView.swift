//
//  AccountSettingView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 08/09/22.
//

import SwiftUI
//import PagerTabStripView

struct AccountSettingView: View {
    var body: some View {
        MyPagerView()
    }
}

struct AccountSettingView_Previews: PreviewProvider {
    static var previews: some View {
        AccountSettingView()
    }
}


struct MyPagerView: View {
    @State private var selectedTab = 0
    let views: [AnyView] = [AnyView( SearchBarView() ), AnyView(LoginPageView()), AnyView(SwipeView())]
    let tabItems = ["ACCOUNT", "PROFILE", "PASSWORD"]
    
    var body: some View {
        VStack{
//        PagerTabStripView() {
//           SearchBarView()   //firstTab view
//                .frame(width: UIScreen.main.bounds.width)
//                .pagerTabItem {
//                    TitleNavBarItem(title: "ACCOUNT", systomIcon: "character.bubble.fill")
//
//                }
//
//          LoginPageView()    //SecondTab View
//                .frame(width: UIScreen.main.bounds.width)
//                .pagerTabItem {
//                    TitleNavBarItem(title: "PROFILE", systomIcon: "person.circle.fill")
//                }
//
//              SwipeView()    //ThirdTab View
//                .frame(width: UIScreen.main.bounds.width)
//                    .pagerTabItem {
//                        TitleNavBarItem(title: "PASSWORD", systomIcon: "lock.fill")
//                    }
//
//        }.pagerTabStripViewStyle(.init(tabItemSpacing: 0, tabItemHeight: 80, indicatorBarHeight: 3, indicatorBarColor: .black))
//
//        .pagerTabStripViewStyle(.barButton(indicatorBarHeight: 4, indicatorBarColor: .black, tabItemSpacing: 0, tabItemHeight: 90))
      
                NavigationView{

                        PagerTabStripView(views: views, tabItemNames: tabItems)
                    }
            
        }
    }
}

struct TitleNavBarItem: View {
    let title: String
    let systomIcon: String
    var body: some View {
        VStack {
            Image(systemName: systomIcon)
             .foregroundColor( .white)
             .font(.title)
    
             Text( title)
                .font(.system(size: 22))
                .bold()
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.orange)
    }
}
