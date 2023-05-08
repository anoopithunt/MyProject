//
//  PunlisherList.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 26/07/22.
//

import SwiftUI
//import SwiftyJSON
//import SDWebImageSwiftUI

struct PublisherList: View {
    @ObservedObject var list = PublisherViewModel(_httpUtility: HttpUtility1())

    var layout: [GridItem] = [GridItem(.flexible(), spacing: nil, alignment: nil), GridItem(.flexible(), spacing: nil, alignment: nil) ]
    var body: some View {
//        VStack{
            ScrollView{
                LazyVGrid(columns: layout, spacing: 20) {
                    ForEach(list.datas, id: \.id) { item in
                        
                        Text(item.full_name ?? "-")
//                        HStack(spacing: 15){
//                            PublisherView(full_name: item.full_name, totalBookViews: item.totalBookViews ?? 0, totalfollowers: item.totalfollowers, totalBooks: item.totalBooks)
//                                .padding(.horizontal,11)
//                            //  .frame(width: 205, height: 345)
//                                .cornerRadius(32)
//                                .padding(.vertical,7)
//                        }
                    }


                }.onAppear{
                    list.getData()
                }

//            }
//            Spacer()
        }
    }
}

struct PublisherList_Previews: PreviewProvider {
    static var previews: some View{
        PublisherList()
    }
}


//                    ForEach(fetching.datatotal, id: \.id) { i in
//                        HStack(spacing: 15){
//                            PublisherView(full_name: i.full_name, totalBookViews: i.totalBookViews, totalfollowers: i.totalfollowers, totalBooks: i.totalBooks)
//                                .padding(.horizontal,11)
//                            //                                        .frame(width: 205, height: 345)
//                                .cornerRadius(32)
//                                .padding(.vertical,7)
//                        }
//                    }
