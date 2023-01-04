//
//  HomePublisherView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 24/09/22.
//

import SwiftUI
private var colors:[Color] = [.gray, .red, .green, .orange, .purple]
struct HomePublisherView: View {
    @State var totalBookViews = "707k"
    @State var totalBooks = "23"
    @State var address = "Pratapgarh"
    @State var fullName = "Alibrary Publication Prayagraj"
    @State var url = "https://alibrary.in/storage/images/partner/logo/Gyan_logo_181220210443_5.png"
    @State var bgColor = "default"
    var body: some View{
        VStack{
            HStack{
                Image(systemName: "eye").font(.system(size: 15))
                Text(totalBookViews).font(.system(size: 15))
                Spacer()
                Image("pdf_white").resizable().frame(width: 20, height: 22)
                Text(totalBooks).font(.system(size: 15))
            }
            .foregroundColor(.white)
            .padding()

            AsyncImage(url: URL(string: url)){ image in
                    
                    image
                    .resizable()
                    .frame( height: 96)
                    .scaledToFill()
                    .clipShape(Circle())
                    .padding(8)
                    .overlay(Circle().stroke(Color.white, lineWidth: 3))
                
            }placeholder: {
                Image("logo_gray").resizable().frame( height: 96, alignment:.center)
                    .scaledToFill()
                    .clipShape(Circle())
                    .padding(.all,8)
                    .overlay(Circle().stroke(Color.white, lineWidth: 3))
            }
                
            Spacer()
            Text(fullName).font(.system(size: 21))
                .frame(width: 160)
                .padding(.horizontal).lineLimit(1).fixedSize()
            Text(address).font(.title3)
        }.foregroundColor(.white)
            .padding(.bottom)
            .frame(width: 175, height: 235)
            .background(Color(.purple)).opacity(0.7)
            .cornerRadius(8)
    }
}

struct HomePublisherView_Previews: PreviewProvider {
    static var previews: some View {
//        HomePublisherView()
        HomePublisher()
    }
}



struct HomePublisher: View {
    @ObservedObject var list = HomePublisherVM()
    
    var body: some View{
        ScrollView(.horizontal,showsIndicators: false){
            HStack{
                ForEach(list.datas, id: \.id){ item in
                    
                    HomePublisherView(totalBookViews: "707k", totalBooks: "\(item.totalBooks ?? 0)", address: item.fullAddress ?? "-", fullName: item.fullName,url: item.logoUrl)
                }
                
                
            }
        }
    }
}
