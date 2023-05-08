//
//  PublisherAnalyticsView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 24/09/23.
//

import SwiftUI
import Charts

struct PublisherAnalyticsView: View {
    
    @StateObject private var list = PublisherDashboardViewModel()
    @Environment(\.dismiss) private var dismiss
  
    var body: some View {
        NavigationView{
            VStack(alignment:.leading){
                HStack(spacing: 12){
                    Button(action: {
                        dismiss()
                    }, label: {
                        
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color.gray)
                            .font(.system(size: 22, weight: .bold))
                        
                    })
                    
                    
                    Text("All Analytics")
                        .foregroundColor(.gray)
                        .font(.system(size: 22, weight: .bold))
                    Spacer()
                }.padding(8)
                
                ScrollView(showsIndicators: false){
                    HStack{
                        
                        Text("Monthly Total Book Upload")
                            .foregroundColor(.gray)
                            .font(.system(size: 22, weight: .bold))
                        Button(action: {
                            
                        }, label: {
                            NavigationLink(destination: {
                                PublisherTotalBooksUploadView()
                                    .navigationBarBackButtonHidden(true)
                            }, label: {
                                Text("View")
                                    .padding(.horizontal)
                                    .padding(.vertical,6)
                                    .font(.system(size: 22, weight: .heavy))
                                    .foregroundColor(.white)
                                    .background(Color.teal)
                                    .cornerRadius(18)
                                    .overlay(RoundedRectangle(cornerRadius: 32)
                                        .stroke(Color.white, lineWidth: 4))
                            })
                            
                        })
                    }
                    if #available(iOS 16.0, *) {
                        ScrollView{
                            ScrollView(.horizontal,showsIndicators: false){
                                Chart {
                                    
                                    ForEach((list.months.indices), id: \.self)
                                    { index in
                                        
                                        BarMark(x: .value("Days", list.months[index]), y: .value("Steps", list.totalUploads[index]), stacking: .unstacked)
                                        //                                .annotation(position: .trailing) {
                                        //                                    Image("soft")
                                        //                                        .resizable()
                                        //                                        .frame(25)
                                        //                                }
                                    }
                                }.padding().frame(width: 824,height: 225)
                            }
                        }
                    } else {
                        //                     Fallback on earlier versions
                    }
                    
                    HStack{
                        Text("Monthly Total Book Read")
                            .foregroundColor(.gray)
                            .font(.system(size: 22, weight: .bold))
                        Button(action: {
                            
                        }, label: {
                            Text("View")
                                .padding(.horizontal)
                                .padding(.vertical,6)
                                .font(.system(size: 22, weight: .heavy))
                                .foregroundColor(.white)
                                .background(Color.teal)
                                .cornerRadius(18)
                                .overlay(RoundedRectangle(cornerRadius: 32)
                                    .stroke(Color.white, lineWidth: 4))
                        })
                    }
                    if #available(iOS 16.0, *) {
                        
                        ScrollView{
                            ScrollView(.horizontal,showsIndicators: false){
                                Chart {
                                    
                                    ForEach((list.months.indices), id: \.self)
                                    { index in
                                        
                                        BarMark(x: .value("Days", list.months[index]), y: .value("Steps", list.totreadbooks[index]), stacking: .unstacked)
                                        
                                    }
                                }.padding().frame(width: 624,height: 225)
                            }
                        }
                        
                        
                    } else {
                        // Fallback on earlier versions
                    }
                    HStack{
                        Text("Monthly Total Magazine Upload")
                            .foregroundColor(.gray)
                            .font(.system(size: 22, weight: .bold))
                        Spacer()
                        Button(action: {
                            
                        }, label: {
                            Text("View")
                                .padding(.horizontal)
                                .padding(.vertical,6)
                                .font(.system(size: 22, weight: .heavy))
                                .foregroundColor(.white)
                                .background(Color.teal)
                                .cornerRadius(18)
                                .overlay(RoundedRectangle(cornerRadius: 32)
                                    .stroke(Color.white, lineWidth: 4))
                        })
                        //                    Spacer()
                    }
                    if #available(iOS 16.0, *) {
                        
                        ScrollView{
                            ScrollView(.horizontal,showsIndicators: false){
                                Chart {
                                    ForEach((list.months.indices), id: \.self){ index in
                                        BarMark(x: .value("Days", list.months[index]), y: .value("Steps", list.uploadTotMags[index]), stacking: .unstacked)
                                        
                                    }
                                }.padding().frame(width: 624,height: 225)
                            }
                        }
                        
                    } else {
                        // Fallback on earlier versions
                    }
                    
                    HStack{
                        Text("Monthly Read Credit Earned")
                            .foregroundColor(.gray)
                            .font(.system(size: 22, weight: .bold))
                        Button(action: {
                            
                        }, label: {
                            Text("View")
                                .padding(.horizontal)
                                .padding(.vertical,6)
                                .font(.system(size: 22, weight: .heavy))
                                .foregroundColor(.white)
                                .background(Color.teal)
                                .cornerRadius(18)
                                .overlay(RoundedRectangle(cornerRadius: 32)
                                    .stroke(Color.white, lineWidth: 4))
                        })
                    }
                    if #available(iOS 16.0, *) {
                        
                        
                        ScrollView{
                            ScrollView(.horizontal,showsIndicators: false){
                                Chart {
                                    ForEach((list.months.indices), id: \.self){ index in
                                        BarMark(x: .value("Days", list.months[index]), y: .value("Steps", list.finalRCCounts[index]), stacking: .unstacked)
                                        
                                    }
                                }.padding().frame(width: 624,height: 225)
                            }
                        }
                        
                    } else {
                        // Fallback on earlier versions
                    }
                    
                    HStack{
                        Text("Monthly Book Sell")
                            .foregroundColor(.gray)
                            .font(.system(size: 22, weight: .bold))
                        Spacer()
                        Button(action: {
                            
                        }, label: {
                            Text("View")
                                .padding(.horizontal)
                                .padding(.vertical,6)
                                .font(.system(size: 22, weight: .heavy))
                                .foregroundColor(.white)
                                .background(Color.teal)
                                .cornerRadius(18)
                                .overlay(RoundedRectangle(cornerRadius: 32)
                                    .stroke(Color.white, lineWidth: 4))
                        })
                        
                        
                    }.padding(.horizontal)
                    if #available(iOS 16.0, *) {
                        
                        //                    Chart {
                        //
                        //                        ForEach((list.months.indices), id: \.self) { index in
                        //
                        //                            BarMark(x: .value("Days", list.months[index]), y: .value("Steps", list.purchBookCounts[index]))
                        //                        }
                        //                    }.frame(height: 225)
                        
                        
                        
                        ScrollView{
                            ScrollView(.horizontal,showsIndicators: false){
                                Chart {
                                    ForEach((list.months.indices), id: \.self){
                                        index in
                                        BarMark(x: .value("Days", list.months[index]), y: .value("Steps", list.purchBookCounts[index]), stacking: .unstacked)
                                        
                                    }
                                }.padding().frame(width: 624,height: 225)
                            }
                        }
                    } else {
                        // Fallback on earlier versions
                    }
                    
                }
            }
        }.onAppear{
            list.getDashboardData()
            
        }
    }
}

 
struct PublisherAnalyticsView_Previews: PreviewProvider {
    static var previews: some View {
        PublisherAnalyticsView()
    }
}
