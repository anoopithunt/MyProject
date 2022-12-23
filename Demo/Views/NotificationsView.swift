//
//  NotificationsView.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 09/12/22.
//

import SwiftUI
import PagerTabStripView

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
    var body: some View {
        VStack{
        PagerTabStripView() {
            
            NotificationTestView()
                .frame(width: UIScreen.main.bounds.width)
                .pagerTabItem {

                    VStack {
                       
                         Text("ACTIVITIES")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color("orange"))
                       
                }
               
           
         
            ActivitiesView()
                .frame(width: UIScreen.main.bounds.width)
                    .pagerTabItem {
                        VStack {
                           
                             Text("TEST")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: 234, maxHeight: .infinity)
                        .background(Color("orange"))
                    }
           
            
        }
        .pagerTabStripViewStyle(.barButton(placedInToolbar: false, tabItemSpacing: 0, tabItemHeight: 70,indicatorViewHeight: 2.5, indicatorView: {
            Color.black
        })).padding(-4)
  
        .foregroundColor(.white)
            
        }
    }
}




struct ActivitiesView: View{
    var body: some View{
        ZStack{
            Image("u").resizable()
            VStack{
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
                Text("1").font(.system(size: 28, weight: .heavy)).foregroundColor(.gray).padding().padding(.top,25)
                Spacer()
            }
        }
    }
}
