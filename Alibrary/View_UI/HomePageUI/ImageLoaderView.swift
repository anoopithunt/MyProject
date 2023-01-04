//
//  ImageLoaderView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 06/07/22.
//

import SwiftUI

struct ImageLoaderView: View {
    
    var body: some View {
//        ScrollView(.horizontal){
        AsyncImage(url: URL(string: "https://www.alibrary.in/public/storage/images/banner/3_31-12-2021-18-28_2.jpg")) { image in
            image.resizable()
                .padding(.vertical)
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: 156, alignment: .center)
        } placeholder: {
            Color.gray.opacity(0.3)
           // ProgressView(Color.secondary)
        }
//        }
       
    }
}

struct ImageLoaderView_Previews: PreviewProvider {
    static var previews: some View {
        ImageLoaderView()
    }
}

