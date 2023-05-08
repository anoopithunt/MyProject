//
//  PublisherMyEarningView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 24/09/23.
//

import SwiftUI


struct PublisherMyEarningView: View {
    @StateObject var list = PublisherMyEarningViewModel()
    var body: some View {
        NavHeaderClosure(title: "My Earnings"){
            ZStack{
                Image("u")
                    .resizable()
                    .ignoresSafeArea()
                VStack{
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]){
                        
                        NavigationLink(destination: {
                            PublisherRCEarningsView().navigationBarBackButtonHidden(true)
                            
                            
                        }, label: {
                            dashBoardTile(iconTileImage: "rupee_gray", tileCount: "\(list.totCountRC)", mainTileImage: "rcf_ti", tileName: "RC Earnings")
                        })
                        .padding()
                        NavigationLink(destination: {
                            
                            
                        }, label: {
                            dashBoardTile(iconTileImage: "rupee_gray", tileCount: "\(list.totalPublisehrEarned)", mainTileImage: "book_req", tileName: "Book Earnings")
                        })
                        NavigationLink(destination: {
                            
                            
                        }, label: {
                            
                            dashBoardTile(iconTileImage: "rupee_gray", tileCount: "\(list.totalEarned)", mainTileImage: "book_req", tileName: "Total Earnings")
                        })
                        
                        
                        
                    }
                    Spacer()
                    
                }
                
                
            }.onAppear{
                list.getEarningData()
            }
//        }.overlay(alignment: .topTrailing){
//            Text("\(list.totCountRC)RC")
//                .foregroundColor(.white).font(.system(size: 26,weight: .bold)).padding(.top).padding(.trailing)
        }
    }
    
    
    func dashBoardTile(iconTileImage: String?, tileCount: String,mainTileImage: String?, tileName: String) -> some View{
        VStack(spacing:6){
            HStack {
                Spacer()
                Image(iconTileImage ?? "")
                    .resizable()
                    .frame(width: 22, height: 22, alignment: .center)
                    .padding(.leading,35)
                //                Spacer()
                //                    .frame(width: 14)
                Text(tileCount)
                    .bold()
                    .font(.custom("_", size: 23))
                    .foregroundColor(Color.black.opacity(0.8))
                
            }
            .foregroundColor(.black)
            .padding(.horizontal)
            .padding(.vertical,6)
            HStack {
                Image(mainTileImage ?? "")
                    .resizable()
                    .frame(width: 90, height: 84, alignment: .leading)
                    .padding(.leading,5)
                    .padding(.bottom)
                    .padding(.top,-25)
                
                Spacer()
                
            }.padding(.horizontal)
            ZStack(alignment: .center){
                Rectangle()
                    .size( width: 442, height: 2)
                    .foregroundColor(.black)
                Text(tileName)
                    .font(.system(size: 22, weight: .medium))
                    .foregroundColor(.white)
                
            }.padding(.bottom,6)
                .background(Color.gray.opacity(0.9))
            
        }
        .background(Color(hue: 1.0, saturation: 0.016, brightness: 0.83))
        .frame(width: UIScreen.main.bounds.width*0.48, height: UIScreen.main.bounds.height*0.18, alignment: .center)
        .cornerRadius(12)
        .shadow(color: Color.gray, radius: 5)
        
    }
}


struct PublisherMyEarningView_Previews: PreviewProvider {
    static var previews: some View {
        PublisherMyEarningView()
    }
}
