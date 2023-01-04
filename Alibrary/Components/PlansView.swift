//
//  PlansView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 08/11/22.
//

import SwiftUI
//import PagerTabStripView

struct PlansView: View {
    @State var currentTab: Int = 0
        var body: some View {
            VStack {
                
                ZStack(alignment: .top) {
                    TabView(selection: self.$currentTab) {
                      SchoolsPlansView().tag(0)
                        GuestPlanView().tag(1)
                        PublisherPlansView().tag(2)
                        ReadCreditsView().tag(3)
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .edgesIgnoringSafeArea(.bottom)
                    
                    TabBarView(currentTab: self.$currentTab)
                }
//                Spacer()
            }
            
        }
}

struct PlansView_Previews: PreviewProvider {
    static var previews: some View {
        PlansView()
    }
}




struct TabBarView: View {
    @Binding var currentTab: Int
    @Namespace var namespace
    
    var tabBarOptions: [String] = ["School\n Plan", "Guest Plans", "Publisher\nPlans","Read Credit(RC)"]
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
//        .edgesIgnoringSafeArea(.all)
    }
}



struct TabBarItem: View {
    @Binding var currentTab: Int
    let namespace: Namespace.ID
    
    var tabBarItemName: String
    var tab: Int
    
    var body: some View {
      
            Button {
                self.currentTab = tab
            } label: {
                VStack {
                    Spacer()
                    Text(tabBarItemName)
                        .foregroundColor(currentTab == tab ? .white : .gray)
                    if currentTab == tab {
                        Color.black
                            .frame(height: 3)
                            .matchedGeometryEffect(id: "underline",
                                                   in: namespace,
                                                   properties: .frame)
                    } else {
                        Color.clear.frame(height: 2)
                    }
                }
                .animation(.spring(), value: self.currentTab)
            }
            .buttonStyle(.plain)
       
        
    }
}

struct View1: View {
    var body: some View {
        Color.orange
            .opacity(0.5)
            .edgesIgnoringSafeArea(.all)
    }
}

struct View2: View {
    var body: some View {
        Color.red
            .opacity(0.2)
//            .edgesIgnoringSafeArea(.all)
    }
}
struct View3: View {
    var body: some View {
        Color.green
            .opacity(0.2)
//            .edgesIgnoringSafeArea(.all)
    }
}

import Foundation

public struct SchoolPlanModel {
 
    public let schoolPlans: SchoolPlans

   
}

public struct SchoolPlans {
    public let thead: [[[String]]]
    public let tbody: [[[Tbody]]]

   
}

public enum Tbody {
    case integer(Int)
    case string(String)
}









struct SchoolPlansView: View {
        
        var body: some View {
            VStack {
                Text("Fetching the data...")
             
            }

        }
    }
