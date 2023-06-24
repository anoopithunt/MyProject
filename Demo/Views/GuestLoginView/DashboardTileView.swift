//
//  DashboardTileView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 05/12/22.
//

import SwiftUI

struct DashboardTileView: View {
    let tileName: String
    let tileCount: String
   @State var  iconTileImage: String?
    let mainTileImage: String
    
    var body: some View {
        VStack(spacing:6){
            HStack {
                Spacer()
                Image(iconTileImage ?? "")
                    .resizable()
                    .frame(width: 20, height: 27, alignment: .center)
                    .padding(.leading,35)
                Spacer()
                    .frame(width: 14)
                Text(tileCount)
                    .bold()
                    .font(.custom("_", size: 23))
                    .foregroundColor(Color.black.opacity(0.8))
                
            }
            .foregroundColor(.black)
            .padding(.horizontal)
            .padding(.vertical,6)
            HStack {
            Image(mainTileImage)
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
                    .font(.custom("Title", size: 18))
                    .foregroundColor(.white)
                
            }.padding(.bottom,6)
            .background(Color.gray.opacity(0.9))
            
        }
        .background(Color(hue: 1.0, saturation: 0.016, brightness: 0.83))
        .frame(width: UIScreen.main.bounds.width*0.43, height: UIScreen.main.bounds.height*0.18, alignment: .center)
        .cornerRadius(12)
        .shadow(color: Color.gray, radius: 5)
        
    }
}


struct DashboardView: View {
    @StateObject private var accountListVM = AuthenticationListService()


    var body: some View {
        
//        NavigationView {
        ZStack{
            Image("u")
                .resizable()
            VStack(spacing:0){
                Color.white.frame(height: 0.1)
                    
                HStack{
                    Text(accountListVM.rem_plan_days)
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                    Spacer()
                    
                }
                .padding(.leading)
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
                            ReadCreditView().navigationTitle("")
                                .navigationBarHidden(true)
                                .navigationBarBackButtonHidden(true)
                        }, label: {
                            DashboardTileView(tileName: "Read Credits(RC)" , tileCount: "\(accountListVM.totalRC)", iconTileImage: "payment_gray", mainTileImage: "read_credit_new")
                        })
                     
                        
                        Spacer()
                            .frame(width:20)
                        NavigationLink(destination: {
                            SubscribeView()
                                .navigationTitle("")
                                .navigationBarHidden(true)
                                .navigationBarBackButtonHidden(true)
                        }, label: {
                            DashboardTileView(tileName: "Subscription" , tileCount: "\(accountListVM.successPayCount)", iconTileImage: "pdf_gray", mainTileImage: "subscription")
                        })
                        
                        
                    }
                    Spacer().frame(height: 22)
                    HStack {
                        NavigationLink(destination: PurchagedBooksView()
                            .navigationTitle("")
                            .navigationBarHidden(true)
                            .navigationBarBackButtonHidden(true)){
                                
                                DashboardTileView(tileName: "Purchased Book" , tileCount: "\(accountListVM.purchasedBooks)", iconTileImage: "purchased_gray", mainTileImage: "purchased_book")
                            }
                        Spacer()
                            .frame(width:20)
                        
                        NavigationLink(destination: PaymentHistoryView()
                            .navigationTitle("")
                            .navigationBarHidden(true)
                            .navigationBarBackButtonHidden(true)){
                                DashboardTileView(tileName: "Pay" , tileCount: "\(accountListVM.successPayCount)",iconTileImage: "", mainTileImage: "payment_hist")
                                
                            }
                    }
                    Spacer().frame(height: 22)
                            HStack {
                                
                                NavigationLink(destination: ReadCreditView()
                                    .navigationTitle("")
                                    .navigationBarHidden(true)
                                    .navigationBarBackButtonHidden(true)){
                                        
                                        DashboardTileView(tileName: "Read Credit Funds" , tileCount: "\(accountListVM.rcFundCounts)", iconTileImage: "test_correct_gray", mainTileImage: "rcf_ti")
                                    }
                                Spacer()
                                    .frame(width:20)
                                NavigationLink(destination: {
                                    BookRequestView()
                                        .navigationTitle("")
                                        .navigationBarHidden(true)
                                        .navigationBarBackButtonHidden(true)
                                }, label: {
                                    DashboardTileView(tileName: "Book Request" , tileCount: "\(accountListVM.bookRequestCount)", iconTileImage: "test_correct_gray", mainTileImage: "book_req")
                                    
                                })
                            }
                                    Spacer().frame(height: 22)
                }
                        
            }.onAppear{
                accountListVM.getDashBoardData()
            }
                VStack{
                    Spacer()
                    MagazineBannerView()
                }
                
        } 
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            DashboardView()

        }
    }
}




public struct DashBoardModel: Decodable {
    public let guestBooks: Int
    public let guestStacks: Int
    public let ownBooks: Int
    public let ownStacks: Int
    public let testCount: Int
    public let totalRC: Int
    public let courseCount: Int
    public let purchasedBooks: Int
    public let partnerBookRCs: Int
    public let bookRequestCount: Int
    public let rcFundCounts: Int
    public let rem_plan_days: String
    public let successPayCount: Int
    public let data: Int

}

