//
//  StudentDashBoardView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 14/07/23.
//

import SwiftUI

struct StudentDashBoardView: View {
    @StateObject private var accountListVM = StudentAuthenticationListService()

    private var columns = [GridItem(.flexible()), GridItem(.flexible())]
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
                    LazyVGrid(columns: columns, spacing: 10) {
                        
        NavigationLink(destination: EmptyView()//SchoolLibraryView(pdfs: accountListVM.schoolStackCount, stacks: accountListVM.schoolBookCount)
//            .navigationTitle("")
//            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)){
                VStack(spacing: 6) {
                    HStack {
                        Spacer()
                        Image("stack_gray")
                            .resizable()
                            .frame(width: 20, height: 27)
                            .padding(.leading, 35)
                        Spacer()
                            .frame(width: 14)
                        Text("\(accountListVM.schoolStackCount)")
                            .bold()
                            .font(.custom("_", size: 23))
                            .foregroundColor(Color.black.opacity(0.8))
                    }
                    .foregroundColor(.black)
                    .padding(.horizontal)
                    .padding(.vertical, 6)
                    HStack(spacing: 7){
                        Image("school_library")
                            .resizable()
                            .frame(width: 80, height: 84)
                            .padding(.bottom)
                            .padding(.top, -25)
                        //                                            .padding(.horizontal,8)
                        Group{
                            Image("pdf_gray")
                                .resizable()
                                .frame(width: 20, height: 23)
                            
                            Text("\(accountListVM.schoolBookCount)").font(.system(size: 23, weight: .medium)).foregroundColor(Color.black.opacity(0.8))
                                .padding(.leading,4)
                        }.padding(.top,-35)
                    }.padding(.leading,12)
                    ZStack(alignment: .center) {
                        Rectangle()
                            .size(width: 442, height: 2)
                            .foregroundColor(.black)
                        Text("School Library")
                            .font(.custom("Title", size: 18))
                            .foregroundColor(.white)
                    }
                    .padding(.bottom, 6)
                    .background(Color.gray.opacity(0.9))
                    
                }
                .background(Color(hue: 1.0, saturation: 0.016, brightness: 0.83))
                .frame(width: UIScreen.main.bounds.width * 0.48, height: UIScreen.main.bounds.height * 0.18)
                .cornerRadius(12)
                .shadow(color: Color.gray, radius: 5)
                
            }
            .background(Color("default_"))
            .cornerRadius(12)
                        
                        dashBoardTiles(iconTileImage: "stack_gray", tileCount: "\(accountListVM.studentStackCount)", mainTileImage: "Stacks new", tileName: "Stack")
                        
                        
                        dashBoardTiles(iconTileImage: "rupee_gray", tileCount: "\(accountListVM.partnerRCCount)", mainTileImage: "payment_hist", tileName: "Read Credits(RC)")
                        Group{
                            dashBoardTiles(iconTileImage: "purchased_gray", tileCount: "\(accountListVM.studentPurchasedBookCount)", mainTileImage: "purchased_book", tileName: "Purchased Book")
//
                            dashBoardTiles(iconTileImage: "pdf_gray", tileCount: "\(accountListVM.successPayCount)", mainTileImage: "subscription", tileName: "Subscription")
                            
                            
                            NavigationLink(destination: EmptyView()//StudentCourseView()
                                .navigationTitle("")
                                .navigationBarHidden(true)
                                .navigationBarBackButtonHidden(true)){

                                    dashBoardTiles(iconTileImage: "coureses_gray", tileCount: "\(accountListVM.studentCoursesCount)", mainTileImage: "course", tileName: "Courses")
                                }.background(Color("default_"))
                                .cornerRadius(12)
                            
                            
                            dashBoardTiles(iconTileImage: "test_correct_gray", tileCount: "\(accountListVM.studentTestsCount)", mainTileImage: "test", tileName: "Exam/Test")
                            
                            NavigationLink(destination:
                                            EmptyView()//StudentAssignmentView()
                                .navigationTitle("")
                                .navigationBarHidden(true)
                                .navigationBarBackButtonHidden(true)){
                                    dashBoardTiles(iconTileImage: "homework_gray", tileCount: "\(accountListVM.studentHomeworkCount)", mainTileImage: "Book Assigned", tileName: "Assignment")
                                }.background(Color("default_"))
                                .cornerRadius(12)
//
                            dashBoardTiles(iconTileImage: "coureses_gray", tileCount: "\(accountListVM.studentBookCount)", mainTileImage: "book_req", tileName: "Live Session")
                            
                            
                            NavigationLink(destination:
                                            EmptyView()//StudentBookBundleView()
                                .navigationTitle("")
                                .navigationBarHidden(true)
                                .navigationBarBackButtonHidden(true)
                            ){
                                    dashBoardTiles(iconTileImage: "pdf_gray", tileCount: "\(accountListVM.studentPurchasedBookCount)", mainTileImage: "book_bundle_home_icon", tileName: "Book Bundle")
                                }.background(Color("default_"))
                                .cornerRadius(12)
                            
                            
                            dashBoardTiles(iconTileImage: "pdf_gray", tileCount: "\(accountListVM.studentBookCount)", mainTileImage: "book_req", tileName: "Book Request")
                            
                        }
                    }
                }
            }.onAppear{
//                accountListVM.getDashBoardData()
            }
            
//            VStack{
//                Spacer()
//                MagazineBannerView()
//
//            }
            
        }
        
    }
    
    func dashBoardTiles(iconTileImage: String?, tileCount: String,mainTileImage: String?, tileName: String) -> some View{
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
                    .font(.custom("Title", size: 18))
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

struct StudentDashBoardView_Previews: PreviewProvider {
    static var previews: some View {
        StudentDashBoardView()
    }
}
