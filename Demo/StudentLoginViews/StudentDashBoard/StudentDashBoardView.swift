//
//  StudentDashBoardView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 12/06/23.
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
                        
        NavigationLink(destination: SchoolLibraryView(pdfs: accountListVM.schoolStackCount, stacks: accountListVM.schoolBookCount)
            .navigationTitle("")
            .navigationBarHidden(true)
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
                        dashBoardTile(iconTileImage: "stack_gray", tileCount: "\(accountListVM.studentStackCount)", mainTileImage: "Stacks new", tileName: "Stack")
                        
                        
                        dashBoardTile(iconTileImage: "rupee_gray", tileCount: "\(accountListVM.partnerRCCount)", mainTileImage: "payment_hist", tileName: "Read Credits(RC)")
                        Group{
                            dashBoardTile(iconTileImage: "purchased_gray", tileCount: "\(accountListVM.studentPurchasedBookCount)", mainTileImage: "purchased_book", tileName: "Purchased Book")
                            
                            dashBoardTile(iconTileImage: "pdf_gray", tileCount: "\(accountListVM.successPayCount)", mainTileImage: "subscription", tileName: "Subscription")
                            
                            
                            NavigationLink(destination: StudentCourseView()
                                .navigationTitle("")
                                .navigationBarHidden(true)
                                .navigationBarBackButtonHidden(true)){
                                    
                                    dashBoardTile(iconTileImage: "coureses_gray", tileCount: "\(accountListVM.studentCoursesCount)", mainTileImage: "course", tileName: "Courses")
                                }.background(Color("default_"))
                                .cornerRadius(12)
                            
                            
                            dashBoardTile(iconTileImage: "test_correct_gray", tileCount: "\(accountListVM.studentTestsCount)", mainTileImage: "test", tileName: "Exam/Test")
                            
                            NavigationLink(destination: StudentAssignmentView()
                                .navigationTitle("")
                                .navigationBarHidden(true)
                                .navigationBarBackButtonHidden(true)){
                                    dashBoardTile(iconTileImage: "homework_gray", tileCount: "\(accountListVM.studentHomeworkCount)", mainTileImage: "Book Assigned", tileName: "Assignment")
                                }.background(Color("default_"))
                                .cornerRadius(12)
                            
                            dashBoardTile(iconTileImage: "coureses_gray", tileCount: "\(accountListVM.studentBookCount)", mainTileImage: "book_req", tileName: "Live Session")
                            
                            
                            NavigationLink(destination: StudentBookBundleView()
                                .navigationTitle("")
                                .navigationBarHidden(true)
                                .navigationBarBackButtonHidden(true)
                            ){
                                    dashBoardTile(iconTileImage: "pdf_gray", tileCount: "\(accountListVM.studentPurchasedBookCount)", mainTileImage: "book_bundle_home_icon", tileName: "Book Bundle")
                                }.background(Color("default_"))
                                .cornerRadius(12)
                            
                            
                            dashBoardTile(iconTileImage: "pdf_gray", tileCount: "\(accountListVM.studentBookCount)", mainTileImage: "book_req", tileName: "Book Request")
                            
                        }
                    }
                }
            }.onAppear{
                accountListVM.getDashBoardData()
            }
            
//            VStack{
//                Spacer()
//                MagazineBannerView()
//
//            }
            
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

class StudentAuthenticationListService: ObservableObject {
    @Published var schoolBookCount: Int = 0// = Int()
    @Published var successPayCount = Int()
    @Published var rem_plan_days = String()
    @Published public var schoolStackCount = Int()
    @Published  var studentBookCount = Int()
    @Published public var studentStackCount = Int()
    @Published public var studentCoursesCount = Int()
    @Published public var studentTestsCount = Int()
    @Published public var studentPurchasedBookCount = Int()
    @Published public var studentHomeworkCount = Int()
    @Published public var ownBundleCount = Int()
    @Published public var partnerRCCount = Int()
    @Published public var partBookRCCount = Int()
    @Published public var liveSessionCount = Int()
    @Published public var remPlanDays = String()
    @Published public var isPlanExpired = Int()
    @Published public var planname = String()
    //
    func getDashBoardData() {
        
        let apiurl = "\(APILoginUtility.studentDashBoardApi)"
        guard let url = URL(string: apiurl) else {
            // handle invalid URL error
            return
        }
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
        let service = HTTPLoginUtility()
        
        service.getLoginData(from: url, model: StudentDashBoardModel.self, token: token){ (result) in
            switch result {
            case .success(let results):
                DispatchQueue.main.async {
                    self.schoolBookCount =  results.schoolBookCount
                    self.schoolStackCount = results.schoolStackCount
                    self.studentStackCount = results.studentStackCount
                    self.studentCoursesCount = results.studentCoursesCount
                    self.studentPurchasedBookCount = results.studentPurchasedBookCount
                    self.studentTestsCount = results.studentTestsCount
                    self.studentHomeworkCount = results.studentHomeworkCount
                    self.liveSessionCount = results.liveSessionCount
                    self.partnerRCCount = results.partnerRCCount
                    self.rem_plan_days = results.rem_plan_days
                    print(results)
                    
                }
            case .failure(let error):
                print(error.localizedDescription)
                
            }
            
        }
        
    }
    
}

    
 




struct StudentDashBoardView_Previews: PreviewProvider {
    static var previews: some View {
        StudentLoginSidemenuView()
    }
}



struct StudentLoginSidemenuView: View {
    @StateObject private var loginVM = GetAuthenticationViewModel()
    @State var presentSideMenu = false
    @State var selectedSideMenuTab = 0
    @State private var selected: StudentSelectedScreen = .dashboard
    var body: some View {
        ZStack{
            NavigationView{
                    
                VStack(spacing: 0){
                        
                    headerView()
                        
                    switch selected {
                        
                    case .home:
                        HomeView()
                   
                    case .dashboard:
                            StudentDashBoardView()
                    case .profile:
                        ProfileView()
                    
                        }
                        
                        Spacer()
                    }
                }
//                SideMenu(isShowing: $presentSideMenu, content: AnyView(SideMenuView(selectedSideMenuTab: $selectedSideMenuTab, presentSideMenu: $presentSideMenu, selected: $selected)))
                
            
        }
    }
    
    
    
    func headerView() -> some View{
        HStack{
            Button(action: {
                
                self.presentSideMenu.toggle()
                
            }, label: {
                
                Image(systemName: "line.3.horizontal")
                    .foregroundColor(.white)
                    .font(.headline)
                
            })
            NavigationLink(destination: EmptyView() // SearchBooksCollectionView()
                .navigationTitle("")
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)){
                    
                    Button(action: {
                        
                    }, label: {
                        
                        
                        //Action On Search Books Button
                        
                        
                        ZStack {
                            
                            HStack {
                                
                                if #available(iOS 16.0, *) {
                                    Image(systemName: "magnifyingglass").foregroundColor(.gray).fontWeight(.heavy)
                                } else {
                                    // Fallback on earlier versions
                                    
                                    Image(systemName: "magnifyingglass").foregroundColor(.gray).font(.body).frame(width: 30,height: 30)
                                }
                                Text("search books..").foregroundColor(.gray)
                                Spacer()
                                
                            }.frame(width: UIScreen.main.bounds.width*0.6)
                                .padding(.leading, 7)
                        }
                        .frame(height: 40)
                        .background()
                        .cornerRadius(8)
                    })
                }
            Spacer()
            
            //
            
            Button(action: {
                
            }, label: {
                NavigationLink(destination: EmptyView()) {
                    Image("qr_c").resizable()
                        .frame(width: 30, height: 30)
                }
                
                
            })
            
            Menu {
                Button(action: {
                    
                }, label: {
                    Text("Buy Read Creadit(RC)").foregroundColor(.black).font(.system(size: 23,weight: .bold))
                })
                Button(action: {
                    
                }, label: {
                    Text("User Guide").foregroundColor(.black).font(.system(size: 23,weight: .bold))
                })
                
                Button(action: {
                    loginVM.logout()
                }, label: {
                    Text("Log Out").foregroundColor(.black).font(.system(size: 23,weight: .bold))
                })
                
                
            } label: {
                Image(systemName: "ellipsis")
                    .foregroundColor(.white)
                    .font(.system(size: 33))
                    .rotationEffect(.degrees(-90))
                    .padding()
            }
            
            
        }.padding()
            .frame( width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height*0.06)
            .font(.headline)
            .background(Color.orange)
    }
    
    
}

 


// MARK: Student Model
 
public struct StudentDashBoardModel:Decodable {
    public let schoolBookCount: Int
    public let schoolStackCount: Int
    public let studentBookCount: Int
    public let studentStackCount: Int
    public let studentCoursesCount: Int
    public let studentTestsCount: Int
    public let studentPurchasedBookCount: Int
    public let studentHomeworkCount: Int
    public let ownBundleCount: Int
    public let partnerRCCount: Int
    public let partBookRCCount: Int
    public let liveSessionCount: Int
    public let rem_plan_days: String
    public let isPlanExpired: Int
    public let planname: String
    public let successPayCount: Int
 
}


enum StudentSelectedScreen {
    case home
//    case explorecategory
//    case plan
//    case donation
    case dashboard
    case profile
//    case account
//    case collection
//    case rctrans
//    case magazine
//    case publisher
//    case library
//    case reported_book
//    case invite_earn
//    case stories
//    case user_request
    //    case about
    //    case contact
    //    case privacy
    //    case terms
    //    case adolscence
    //    case dmca
    //    case copyright
    //    case subscribe
    
}
