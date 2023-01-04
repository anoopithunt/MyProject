//
//  PublisherBannersView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 19/09/22.
//

import SwiftUI


struct PublisherBannersView: View {
    @StateObject var bannerObject = PublisherBannerVM()
    var body: some View{

            ScrollView(.horizontal,showsIndicators: false){
                HStack {
                        ForEach(bannerObject.datas) { item in
                            AsyncImage(url: item.url) { image in
                                image
                                    .resizable().padding(4)
                                    .frame(width: UIScreen.main.bounds.width, height: 100)
                            } placeholder: {
                                Image("logo_gray").resizable().padding(1)
                                    .frame(width: UIScreen.main.bounds.width, height: 100)
                            }
                        }
           
                    
                }
                
                
            }
            .padding(8)
            
//        }
    }
}

struct PublisherBannersView_Previews: PreviewProvider {
    static var previews: some View {
        PublisherBannersView()
    }
}
