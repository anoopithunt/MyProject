//
//  PunlisherList.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 26/07/22.
//

import SwiftUI
import SwiftyJSON
//import SDWebImageSwiftUI

struct PublisherList: View {
        
    @ObservedObject var fetching = ApiServices()

    var layout: [GridItem] = [
           GridItem(.flexible(), spacing: nil, alignment: nil),
           GridItem(.flexible(), spacing: nil, alignment: nil)
       ]
    var body: some View {
       
           
                    ScrollView{
                        LazyVGrid(columns: layout, spacing: 20) {
                            ForEach(fetching.datatotal, id: \.id) { i in
                             
                            
                    
                                HStack(spacing: 15){
                                 
                                    PublisherView(full_name: i.full_name, totalBookViews: i.totalBookViews, totalfollowers: i.totalfollowers, totalBooks: i.totalBooks)
                                   
                                    .padding(.horizontal,11)
//                                        .frame(width: 205, height: 345)
                                        .cornerRadius(32)
                                .padding(.vertical,7)
                            }
                            }
    }

                    }
      Spacer()
                    .padding(.horizontal,22)
    }
}

struct PublisherList_Previews: PreviewProvider {
    static var previews: some View{
        PublisherList()
    }
}
