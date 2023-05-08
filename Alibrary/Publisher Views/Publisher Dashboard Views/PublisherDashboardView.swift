//
//  PublisherDashboardView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 24/09/23.
//

import SwiftUI


struct PublisherDashboardView: View {
    @StateObject private var list = PublisherDashboardViewModel()
    
    private var columns = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
//        NavigationView {
        ZStack{
            Image("u")
                .resizable()
            VStack(spacing:0){
                Color.white.frame(height: 0.1)
                
                HStack{
                    Text(list.datas?.rem_plan_days ?? "")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                    Spacer()
                    if(list.datas?.isPlanExpired == 1){
                        Button(action: {
                            
                        }, label: {
                            Text("Renew")
                                .padding(4)
                                .font(.system(size: 22, weight: .heavy))
                                .foregroundColor(.white)
                                .background(Color.red)
                                .cornerRadius(18)
                                .overlay(RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.white, lineWidth: 2))
                        })
                       
                            
                    }
                }
                .padding(.horizontal)
                .frame(width: UIScreen.main.bounds.width,height: 45)
                .background(list.datas?.isPlanExpired == 1 ? Color.red :  Color.cyan)
                
                //                CustomNavBarView()
                
                ScrollView(showsIndicators: false){
                    LazyVGrid(columns: columns, spacing: 10) {
                        
                        NavigationLink(destination: {
                            PublisherAnalyticsView().navigationBarBackButtonHidden(true)
                        }, label: {
                            dashBoardTile(iconTileImage: "payment_gray", tileCount: "\(5)", mainTileImage: "croud_funding", tileName: "Analytics")
                        })
                        
                       
                        NavigationLink(destination: {
                            PublisherTotIssueBooksView().navigationBarBackButtonHidden(true)
                        }, label: {
                            dashBoardTile(iconTileImage: "pdf_gray", tileCount: "\(list.datas?.allBookCount ?? 0)", mainTileImage: "upload_pdf", tileName: "Total Issues")
                        })
                        
                        
                       
                        Group{
                            NavigationLink(destination: {
                                PublisherPrimeIssueBooksView().navigationBarBackButtonHidden(true)
                            }, label: {
                                dashBoardTile(iconTileImage: "pdf_gray", tileCount: "\(list.datas?.primeBookCount ?? 0)", mainTileImage: "upload_pdf", tileName: "Prime Issues")
                            })
                            NavigationLink(destination: {
                                PublisherFreeIssueBooksView().navigationBarBackButtonHidden(true)
                            }, label: {
                                
                                dashBoardTile(iconTileImage: "pdf_gray", tileCount: "\(list.datas?.freeBookCount ?? 0)", mainTileImage: "upload_pdf", tileName: "Free Issues")
                            })
                            
                            
                            NavigationLink(destination:
                                            PublisherPaidIssueBooksView()
                                .navigationTitle("")
                                .navigationBarHidden(true)
                                .navigationBarBackButtonHidden(true)){
                                    
                                    dashBoardTile(iconTileImage: "pdf_gray", tileCount: "\(list.datas?.paidBookCount ?? 0)", mainTileImage: "upload_pdf", tileName: "Paid Issues")
                                }.background(Color("default_"))
                                .cornerRadius(12)
                            NavigationLink(destination:{
//                                StudentExamTestView()
//                                .navigationBarBackButtonHidden()
                                
                            }, label: {
                                
                                dashBoardTile(iconTileImage: "rupee_gray", tileCount: "\(list.datas?.rcFundCounts ?? 0)", mainTileImage: "rcf_ti", tileName: "Read Credit Funds")
                            })
                            
                            dashBoardTile(iconTileImage: "test_correct_gray", tileCount: "\(list.datas?.bookRequestCounts ?? 0)", mainTileImage: "book_req", tileName: "Book Request")
                            NavigationLink(destination: {
                                PublisherMyEarningView()
                                    .navigationBarBackButtonHidden(true)
                            }, label: {
                                
                                dashBoardTile(iconTileImage: "rupee_gray", tileCount: "\(0)", mainTileImage: "croud_funding", tileName: "My Earnings")
                            })
                            
                        }
                        
                    }
                    
                }
            }.onAppear{
                list.getDashboardData()
            }
            
//        }
    }
        
    }
    
    func dashBoardTile(iconTileImage: String?, tileCount: String,mainTileImage: String?, tileName: String) -> some View{
        VStack(spacing:6){
            HStack {
                Spacer()
                Image(iconTileImage ?? "")
                    .resizable()
                    .frame(width: 20, height: 27, alignment: .center)
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
struct PublisherDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        PublisherDashboardView()
    }
}
