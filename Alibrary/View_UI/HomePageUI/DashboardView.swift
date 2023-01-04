//
//  DashboardView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 15/07/22.
//

import SwiftUI

struct DashboardView: View {
    @StateObject private var accountListVM = AuthenticationListService()


    var body: some View {
        
        NavigationView {
            ZStack{
                VStack{
                    Color.white.frame(height: 0.1)
                    
                    HStack{
                        Text(accountListVM.rem_plan_days)
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                            Spacer()
                        }.padding(.leading)
                        .frame(width: UIScreen.main.bounds.width,height: 35)
                        .background(Color.cyan)//
//                        CustomNavBarView()
                        ScrollView(showsIndicators: false){
                    HStack {
                        NavigationLink(destination: StacksView()
                            .navigationTitle("")
                            .navigationBarHidden(true)
                            .navigationBarBackButtonHidden(true)){
                                DashboardTileView(tileName: "Stack" , tileCount: "\(accountListVM.ownStacks)", iconTileImage: "stack_gray", mainTileImage: "stack_prime")
                                
                            }
                        Spacer()
                            .frame(width:20)
                        
                        NavigationLink(destination: GuestUploadListView()
                            .navigationTitle("")
                            .navigationBarHidden(true)
                            .navigationBarBackButtonHidden(true)){
                                DashboardTileView(tileName: "Upload Pdf" , tileCount: "\(accountListVM.partnerBookRCs)", iconTileImage: "pdf_gray", mainTileImage: "upload_pdf")
                            }
                    }
                    Spacer().frame(height: 22)
                    
                    HStack {
                        
                        
                        NavigationLink(destination: {
//                            ReadCreditView()
                            EmptyView()
                            .navigationTitle("")
                                .navigationBarHidden(true)
                                .navigationBarBackButtonHidden(true)
                        }, label: {
                            DashboardTileView(tileName: "Read Credits(RC)" , tileCount: "\(accountListVM.totalRC)", iconTileImage: "payment_gray", mainTileImage: "read_credit_new")
                        })
                     
                        
                        Spacer()
                            .frame(width:20)
                        NavigationLink(destination: {
//                            SubscribeView()
                            EmptyView()
                                .navigationTitle("")
                                .navigationBarHidden(true)
                                .navigationBarBackButtonHidden(true)
                        }, label: {
                            DashboardTileView(tileName: "Subscription" , tileCount: "\(accountListVM.successPayCount)", iconTileImage: "pdf_gray", mainTileImage: "subscription")
                        })
                        
                        
                    }
                    Spacer().frame(height: 22)
                    HStack {
                        NavigationLink(destination:
//                                        PurchagedBooksView()
                                       EmptyView() .navigationTitle("")
                            .navigationBarHidden(true)
                            .navigationBarBackButtonHidden(true)){
                                
                                DashboardTileView(tileName: "Purchased Book" , tileCount: "\(accountListVM.purchasedBooks)", iconTileImage: "purchased_gray", mainTileImage: "purchased_book")
                            }
                        Spacer()
                            .frame(width:20)
                        
                        NavigationLink(destination:
//                                        PaymentHistoryView()
                                       EmptyView().navigationTitle("")
                            .navigationBarHidden(true)
                            .navigationBarBackButtonHidden(true)){
                                DashboardTileView(tileName: "Pay" , tileCount: "\(accountListVM.successPayCount)",iconTileImage: "", mainTileImage: "payment_hist")
                                
                            }
                    }
                    Spacer().frame(height: 22)
                            HStack {
                                
                                NavigationLink(destination:
//                                                ReadCreditView()
                                               EmptyView() .navigationTitle("")
                                    .navigationBarHidden(true)
                                    .navigationBarBackButtonHidden(true)){
                                        
                                        DashboardTileView(tileName: "Read Credit Funds" , tileCount: "\(accountListVM.rcFundCounts)", iconTileImage: "test_correct_gray", mainTileImage: "rcf_ti")
                                    }
                                Spacer()
                                    .frame(width:20)
                                NavigationLink(destination: {
//                                    BookRequestView()
                                    EmptyView()  .navigationTitle("")
                                        .navigationBarHidden(true)
                                        .navigationBarBackButtonHidden(true)
                                }, label: {
                                    DashboardTileView(tileName: "Book Request" , tileCount: "\(accountListVM.bookRequestCount)", iconTileImage: "test_correct_gray", mainTileImage: "book_req")
                                    
                                })
                            }
                    //                Spacer().frame(height: 22)
                }
                .background(Image("u"))
                        Spacer()
                        MagazineBannerView()
                        
            }.onAppear{
                accountListVM.getDashBoardData()
            }
//                }
                
                
        }
    }
        
    }
}


struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            DashboardView()
            Spacer()
        }
    }
}
