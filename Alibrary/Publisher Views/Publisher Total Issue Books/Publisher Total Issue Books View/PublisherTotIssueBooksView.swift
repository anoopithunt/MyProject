//
//  PublisherTotIssueBooksView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 24/09/23.
//

import SwiftUI

struct PublisherTotIssueBooksView: View {
    
    @StateObject var list = PublisherIssueBookViewModel()
    private var rows = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        
        NavHeaderClosure(title: "Total Issues"){
            ZStack {
                Image("u")
                    .resizable()
                    .ignoresSafeArea()
                ScrollView(showsIndicators: false){
                    LazyVGrid(columns: rows){
                        ForEach(list.datas, id: \.id){ item in
                            VStack(alignment: .leading, spacing: 1){
                                AsyncImage(url: URL(string: item.url)){
                                    img in
                                    img.resizable()
                                        .frame( height: 235)
                                        .cornerRadius(12)
                                }placeholder: {
                                    Image("logo_gray").resizable()
                                        .frame( height: 235)
                                        .cornerRadius(12)
                                }
                                Text(item.title)
                                    .font(.system(size: 18, weight: .regular))
                                    .lineLimit(1)
                                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]){
                                    
                                    Text(item.category_name)
                                        .font(.system(size: 14, weight: .regular))
                                        .foregroundColor(.red).lineLimit(1).frame(alignment: .leading)
                                    
                                    Text(item.subcategory_name)
                                        .font(.system(size: 14, weight: .regular))
                                        .foregroundColor(Color("default_"))
                                        .lineLimit(1).frame(alignment: .leading)
                                    //
                                    Text("For School")
                                        .font(.system(size: 16, weight: .regular))
                                        .foregroundColor(.brown).lineLimit(1)
                                        .frame(alignment: .leading)
                                    
                                    Text(item.is_forschool == 1 ? "YES" :  "NO")
                                        .font(.system(size: 14, weight: .regular))
                                        .foregroundColor(Color("default_"))
                                    
                                    
                                    Text("Created on:")
                                        .font(.system(size: 14, weight: .regular))
                                        .foregroundColor(.brown).lineLimit(1)
                                        .frame(alignment: .leading)
                                    
                                    Text(item.publish_date)
                                        .font(.system(size: 14, weight: .regular))
                                        .foregroundColor(Color("default_"))
                                        .lineLimit(1)
                                        .frame(alignment: .leading)
                                    
                                    Text("Verify By:")
                                        .font(.system(size: 14, weight: .regular))
                                        .foregroundColor(.brown).lineLimit(1)
                                        .frame(alignment: .leading)
                                    
                                    Text(item.approvedBy)
                                        .font(.system(size: 14, weight: .regular))
                                        .foregroundColor(Color("default_"))
                                        .lineLimit(1)
                                        .frame(alignment: .leading)
                                    
                                    
                                }
                                
                                
                                HStack{
                                    
                                    Text("Status:\(item.approvedBy)")
                                        .font(.system(size: 14, weight: .regular))
                                        .foregroundColor(Color("default_")).lineLimit(1)
                                    Spacer()
                                    Button(action: {
                                        
                                    }, label: {
                                        Image("delete_gray")
                                            .resizable()
                                            .frame(width: 15, height: 20)
                                    })
                                }.padding(.horizontal,4)
                                
                            }
                            .padding(12)
                            .background(Color.white)
                            .cornerRadius(12).shadow(color: .gray, radius: 8)
                            
                        }
                        
                        if list.currentPage  < list.totalPage {
                            CircularProgressView()
                                .onAppear{
                                    list.currentPage += 1
                                    list.getDashboardData(currentPage: list.currentPage)
                                    
                                }
                            
                        }
                    }
                }
            }
        }.overlay(alignment: .topTrailing){
            Button(action: {
                
            }, label: {
                Image("cloud_screen")
                    .resizable()
                    .frame(width: 35, height: 35)
                    .padding()
            })
        }.onAppear{
            list.getDashboardData(currentPage: list.currentPage)
            
        }
    }
}

struct PublisherTotIssueBooksView_Previews: PreviewProvider {
    static var previews: some View {
        PublisherTotIssueBooksView()
    }
}
