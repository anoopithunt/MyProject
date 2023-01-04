//
//  MainBannerView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 24/09/22.
//

import SwiftUI

struct MainBannerView: View {
    
    @StateObject var list = MainBannersVM()
    var body: some View {
        
        ScrollView(.horizontal,showsIndicators: false){
            HStack(spacing: 0){
                ForEach(list.datas, id: \.id){ item in
                    
                    AsyncImage(url: URL(string: item.url)){ image in
                        image.resizable().frame(width: UIScreen.main.bounds.width, height: 200)
                    }placeholder: {
                        Color.black.frame(width: UIScreen.main.bounds.width, height: 200)
                    }
                }.padding(.vertical,2)
            }
        }
       
        
    }
}

struct MainBannerView_Previews: PreviewProvider {
    static var previews: some View {
        MainBannerView()
    }
}
