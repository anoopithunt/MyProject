//
//  TeacherDashBoardView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 27/10/23.
//

import SwiftUI

struct TeacherDashBoardView: View {
    @StateObject private var list = TeacherDashboardViewModel()
    
    private var columns = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        NavigationView {
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
                                SchoolLibraryView(pdfs: list.schoolBookCount, stacks: list.schoolStackCount)
                                    .navigationBarBackButtonHidden(true)
                            }, label: {
                                dashBoardTile(iconTileImage: "stack_gray", tileCount: "\(list.schoolStackCount)", mainTileImage: "school_library", tileName: "School Library").overlay(alignment: .topTrailing){
                                    HStack{
                                        Image("pdf_gray").resizable()
                                            .frame(width: 25, height: 30)
                                        
                                        Text("\(list.schoolBookCount)")
                                            .foregroundColor(.gray)
                                            .font(.system(size: 22,weight: .bold))
                                    }.padding(.top, 26).padding()
                                }
                            })
                            
                            NavigationLink(destination: {
                                StacksView()
                                    .navigationBarBackButtonHidden(true)
                                
                            }, label: {
                                dashBoardTile(iconTileImage: "stack_gray", tileCount: "\(list.ownStackCount)", mainTileImage: "Stacks new", tileName: "Stack")
                            })
                            
                            Group{
                                NavigationLink(destination: {
                                    StudentUserUploadView()
                                        .navigationBarBackButtonHidden(true)
                                }, label: {
                                    dashBoardTile(iconTileImage: "pdf_gray", tileCount: "\(list.schoolStackCount)", mainTileImage: "upload_pdf", tileName: "Upload Pdf")
                                })
                                NavigationLink(destination: {
                                    ReadCreditView()
                                        .navigationBarBackButtonHidden(true)
                                }, label: {
                                    
                                    dashBoardTile(iconTileImage: "rupee_gray", tileCount: "\(list.partnerRCCount)", mainTileImage: "rcf_ti", tileName: "Read Credits(RC)")
                                })
                                
                                NavigationLink(destination:
                                                PurchagedBooksView()
                                    .navigationTitle("")
                                    .navigationBarHidden(true)
                                    .navigationBarBackButtonHidden(true))
                                {
                                    
                                    dashBoardTile(iconTileImage: "pdf_gray", tileCount: "\(list.PurchasedBookCount)", mainTileImage: "purchased_book", tileName: "Purchased Book")
                                }.background(Color("default_"))
                                    .cornerRadius(12)
                                NavigationLink(destination:{
                                    SubscribeView()
                                        .navigationBarBackButtonHidden()
                                    
                                }, label: {
                                    
                                    dashBoardTile(iconTileImage: "purchased_gray", tileCount: "\(list.schoolStackCount)", mainTileImage: "Subscription new", tileName: "Subscription")
                                })
                                
                                NavigationLink(destination:{
                                    TeacherClassListView(isClass: false)
                                        .navigationBarBackButtonHidden()
                                    
                                }, label: {
                                    dashBoardTile(iconTileImage: "coureses_gray", tileCount: "\(list.schoolStackCount)", mainTileImage: "course", tileName: "Courses")
                                })
                                
                                NavigationLink(destination: {
                                    StudentExamTestView()
                                        .navigationBarBackButtonHidden(true)
                                }, label: {
                                    
                                    dashBoardTile(iconTileImage: "test_correct_gray", tileCount: "\(list.coursesCount)", mainTileImage: "test", tileName: "Exam/Test")
                                })
                                
                                NavigationLink(destination: {
                                    TeacherClassListView(isClass: true)
                                        .navigationBarBackButtonHidden(true)
                                }, label: {
                                    
                                    dashBoardTile(iconTileImage: "homework_gray", tileCount: "\(0)", mainTileImage: "home_work_color", tileName: "Assignment")
                                })
                                
                                NavigationLink(destination: {
                                    //                                PublisherMyEarningView()
                                    //                                    .navigationBarBackButtonHidden(true)
                                }, label: {
                                    
                                    dashBoardTile(iconTileImage: "pdf_gray", tileCount: "\(0)", mainTileImage: "Live session student Website", tileName: "Live Session")
                                })
                                NavigationLink(destination: {
                                    PublisherBookRequestView()
                                        .navigationBarBackButtonHidden(true)
                                }, label: {
                                    
                                    dashBoardTile(iconTileImage: "pdf_gray", tileCount: "\(0)", mainTileImage: "Book Request new", tileName: "Book Request")
                                })
                                NavigationLink(destination: {
                                    //                                PublisherMyEarningView()
                                    //                                    .navigationBarBackButtonHidden(true)
                                }, label: {
                                    
                                    dashBoardTile(iconTileImage: "pdf_gray", tileCount: "\(0)", mainTileImage: "Book Assigned", tileName: "Assigned Book")
                                })
                                
                            }
                            
                        }
                        
                    }
                }.onAppear{
                    list.getDashboardData()
                }
                
            }
            
        }
        
        
    }
    
    func dashBoardTile(iconTileImage: String?, tileCount: String,mainTileImage: String?, tileName: String) -> some View{
        VStack(spacing:6){
            HStack {
                Spacer()
                Image(iconTileImage ?? "")
                    .resizable()
                    .frame(width: 21, height: 23, alignment: .center)
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

struct TeacherDashBoardView_Previews: PreviewProvider {
    static var previews: some View {
        TeacherDashBoardView()
    }
}
  
// MARK: - TeacherDashBoardModel
public struct TeacherDashBoardModel: Decodable {
    public let schoolBookCount: Int
    public let schoolStackCount: Int
    public let ownBookCount: Int
    public let ownStackCount: Int
    public let coursesCount: Int
    public let testsCount: Int
    public let PurchasedBookCount: Int
    public let partBookRCCount: Int
    public let partnerRCCount: Int
    public let assignedBooksCount: Int
    public let rem_plan_days: String
    public let isPlanExpired: Int
    public let planname: String
    public let successPayCount: Int

     
}

//

struct TeacherView: View {
    var screenWidth = UIScreen.main.bounds.width
    @State var xOffset: CGFloat = 0
    @State var currentXOffset: CGFloat = 0
    @Environment(\.colorScheme) var scheme
    
    var body: some View {
        GeometryReader { reader in
            HStack(spacing: 0) {
                TeacherMenuView()
                    .frame(width: screenWidth * 0.8)
                
                ZStack {
                     Image("soft").resizable().ignoresSafeArea()
                        .foregroundColor(Color(UIColor.systemBackground))
//                        .overlay(Text("Placeholder"))
                        .frame(width: screenWidth)
//                    Image("soft").resizable().ignoresSafeArea()
                    
                    (scheme == .light ? Color.black : Color.white).opacity(0.3)
                        .opacity(xOffset == 0 ? 0.7 : 0)
                        .ignoresSafeArea()
                }
            }
            .onAppear {
                xOffset = -screenWidth * 0.8 // hides the menu
                currentXOffset = xOffset
            }
            .offset(x: xOffset)
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        if value.translation.width > 0 && xOffset != 0 { // left to right
                            withAnimation {
                                xOffset = currentXOffset + value.translation.width
                            }
                        } else if value.translation.width < 0 && xOffset != -screenWidth * 0.8 {
                            withAnimation {
                                xOffset = currentXOffset + value.translation.width
                            }
                        }
                    })
                    .onEnded({ value in
                        if value.translation.width > 0 { // left to right
                            withAnimation {
                                xOffset = 0
                            }
                        } else {
                            withAnimation {
                                xOffset = -screenWidth * 0.8
                            }
                        }
                        currentXOffset = xOffset
                    })
            )
        }
    }
}

struct MenuItem: Identifiable {
    let id = UUID().uuidString
    let image: String
    let name: String
}




struct TeacherMenuView: View {
    var followerCount = 1
    let menuItems = [
        MenuItem(image: "Anoop", name: "profile"),
        MenuItem(image: "soft", name: "lists"),
        MenuItem(image: "Anoop", name: "topics"),
        MenuItem(image: "Anoop", name: "bookmarks"),
        MenuItem(image: "soft", name: "moments"),
        MenuItem(image: "Anoop", name: "monetization")
    ]
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    Image("Anoop")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                    
                    Spacer()
                    
                    Button(action: {}, label: {
                        Image(systemName: "ellipsis.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color.blue)
                    })
                }
                
                Text("Raphael")
                    .font(.system(size: 17, weight: .bold))
                
                Text("@imanoopm")
                    .foregroundColor(.gray)
                
                HStack {
                    Text("780")
                        .fontWeight(.bold)
                    
                    Text("following")
                    
                    Text("\(followerCount)")
                        .fontWeight(.bold)
                        .padding(.leading)
                    
                    Text("follower-count \(followerCount)", tableName: "Plurals")
                }
                .padding(.top)
            }
            .padding(.horizontal)
            
            ScrollView(.vertical, showsIndicators: false, content: {
                VStack(spacing: 0) {
                    ForEach(menuItems) { item in
                        Button(action: {}, label: {
                            HStack(spacing: 20) {
                                Image(item.image).resizable()
                                    .frame(width: 40, height: 40)
                                Text(LocalizedStringKey(item.name))
                                    .foregroundColor(.primary)
                                
                                Spacer()
                            }
                            .padding()
                        })
                    }
                    
                    Divider()
                        .padding(.vertical)
                    
                    VStack(spacing: 30) {
                        Button(action: {}, label: {
                            HStack {
                                Text("settings and privacy")
                                
                                Spacer()
                            }
                        })
                        
                        Button(action: {}, label: {
                            HStack {
                                Text("help center") // if it doesn't work try cleaning the project
                                
                                Spacer()
                            }
                        })
                    }
                    .foregroundColor(Color.primary)
                    .padding(.horizontal, 25)
                    
                    Spacer()
                }
            })
            
            HStack {
                Button(action: {}, label: {
                    Image(systemName: "lightbulb")
                })
                
                Spacer()
                
                Button(action: {}, label: {
                    Image(systemName: "qrcode")
                    
                })
            }
            .foregroundColor(Color.blue)
            .font(.system(size: 21))
            .padding()
        }
        .background(Color(UIColor.systemBackground))
    }
}



class  TeacherDashboardViewModel: ObservableObject {
    @Published var datas:TeacherDashBoardModel?
    
    @Published var schoolBookCount = Int()
    @Published var schoolStackCount = Int()
    @Published var ownBookCount = Int()
    @Published var ownStackCount = Int()
    @Published var coursesCount = Int()
    @Published var testsCount = Int()
    @Published var PurchasedBookCount = Int()
    @Published var partnerRCCount = Int()
    @Published var partBookRCCount = Int()
    @Published var assignedBooksCount = Int()
    @Published var rem_plan_days = String()
    @Published var isPlanExpired = Int()
    @Published var planname = String()
    @Published var successPayCount = Int()
    
    func getDashboardData() {

//        let apiurl = APILoginUtility.studentExamTestApi
        guard let url = URL(string: "https://www.alibrary.in/api/teacher/dashboard") else {
            // handle invalid URL error
            print("This is incorrect API URL...")
            return
        }
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
        let service = HTTPLoginUtility()

        service.getLoginData(from: url, model: TeacherDashBoardModel.self, token: token){ (result) in
            switch result {
            case .success(let results):
                DispatchQueue.main.async {
                    self.datas = results.self
                    self.schoolBookCount = results.schoolBookCount
                    self.schoolStackCount = results.schoolStackCount
                    self.ownBookCount = results.ownBookCount
                    self.ownStackCount = results.ownStackCount
                    self.coursesCount = results.coursesCount
                    self.testsCount = results.testsCount
                    self.PurchasedBookCount = results.PurchasedBookCount
                    self.partBookRCCount = results.partBookRCCount
                    self.partnerRCCount = results.partnerRCCount
                    self.assignedBooksCount = results.assignedBooksCount
                    self.rem_plan_days = results.rem_plan_days
                    self.successPayCount = results.successPayCount
                    print(self.rem_plan_days)
                }
            case .failure(let error):
                print(error.localizedDescription)

            }

        }

    }

}
