//
//  NotificationsView.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 09/12/22.
//

import SwiftUI
//import PagerTabStripView

struct NotificationsView: View {
    var body: some View {
        VStack(spacing:0){
            HStack(spacing:35){
                Button(action: {
                    
                }, label: {
                    Image(systemName: "arrow.backward").foregroundColor(.white).font(.system(size: 22, weight: .heavy)).padding(.leading)
                })
                
             
                Text("**Notifications**").foregroundColor(.white).font(.system(size: 26, weight: .medium))
                
                Spacer()
            }.frame(height: 85).background(Color("orange"))
            
            NotificationTabView()
        }
    }
}

    

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}


struct NotificationTabView: View {
    
    @State var currentTab: Int = 0
    var body: some View {
        VStack{
//        PagerTabStripView() {
//
//            NotificationTestView()
//                .frame(width: UIScreen.main.bounds.width)
//                .pagerTabItem {
//
//                    VStack {
//
//                         Text("ACTIVITIES")
//                            .font(.system(size: 24, weight: .bold))
//                            .foregroundColor(.white)
//                    }
//                    .frame(maxWidth: .infinity, maxHeight: .infinity)
//                    .background(Color("orange"))
//
//                }
//
//
//
//            ActivitiesView()
//                .frame(width: UIScreen.main.bounds.width)
//                    .pagerTabItem {
//                        VStack {
//
//                             Text("TEST")
//                                .font(.system(size: 24, weight: .bold))
//                                .foregroundColor(.white)
//                        }
//                        .frame(maxWidth: 234, maxHeight: .infinity)
//                        .background(Color("orange"))
//                    }
//
//
//        }
//        .pagerTabStripViewStyle(.barButton(placedInToolbar: false, tabItemSpacing: 0, tabItemHeight: 70,indicatorViewHeight: 2.5, indicatorView: {
//            Color.black
//        })).padding(-4)
  
//        .foregroundColor(.white)
            
            
            
            ZStack(alignment: .top) {
                TabView(selection: self.$currentTab) {
                    NotificationTestView().tag(0)
                    ActivitiesView().tag(1)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .edgesIgnoringSafeArea(.bottom)
                
                NotificationTabBarView(currentTab: self.$currentTab)
            }
            
            
//            
        }
    }
}




struct ActivitiesView: View{
    var body: some View{
        ZStack{
            Image("u").resizable()
            VStack(alignment: .leading){
                Spacer().frame(height: 80)
                Text("No Notification of Test").font(.system(size: 28, weight: .heavy)).foregroundColor(.gray).padding().padding(.top,25)
                Spacer()
            }
        }
    }
}

struct NotificationTestView: View{
    var body: some View{
        ZStack{
            Image("u").resizable()
            VStack{
                Spacer().frame(height:80)
                Text("1").font(.system(size: 28, weight: .heavy)).foregroundColor(.gray).padding().padding(.top,25)
                Spacer()
            }
        }
    }
}




struct NotificationTabBarView: View {
    @Binding var currentTab: Int
    @Namespace var namespace
    
    var tabBarOptions: [String] = ["ACTIVITIES","TEST"]
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(Array(zip(self.tabBarOptions.indices,
                                      self.tabBarOptions)),
                            id: \.0,
                            content: {
                        index, name in
                        TabBarItem(currentTab: self.$currentTab,
                                   namespace: namespace.self,
                                   tabBarItemName: name,
                                   tab: index)
                        
                    })
                }.padding(.leading,5)
                .background(Color("orange")).frame(width: UIScreen.main.bounds.width)
                
            }
            .background(Color.white)
        .frame(height: 80)
          
            Spacer()
        }
        .edgesIgnoringSafeArea(.all)
    }
}
