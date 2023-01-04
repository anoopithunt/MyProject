//
//  MagazineBannerView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 16/09/22.
//

import SwiftUI


struct MagazineBannerView: View{
    @ObservedObject var list = MagazineBannerVM()
    var body: some View{
        
        VStack{
            ImageAutoSlider(imageUrls: list.images, autoScrollInterval:2, animationDuration: 0.8).frame(height: 122)
        
        }

    }
}

struct MagazineBannerView_Previews: PreviewProvider {
    static var previews: some View {
        MagazineBannerView()
    }
}
