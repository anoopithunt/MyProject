//
//  IndustryDashboardView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 30/11/23.
//

import SwiftUI

struct IndustryDashboardView: View {
    @StateObject private var list = IndustryDashboardViewModel()
    @State var isDeplistShow: Bool = false
    @State var isNavigate: Bool = false
    private var columns = [GridItem(.flexible()), GridItem(.flexible())]
     var body: some View {
        NavigationView {
            ZStack{
                Image("u")
                    .resizable()
                    .ignoresSafeArea()
                
                VStack(spacing:5){
                    Image("Anoop")
                        .resizable()
                        .frame(height: 122)
                
//                                CustomNavBarView()
                
                ScrollView(showsIndicators: false){
                    LazyVGrid(columns: columns, spacing: 20) {
                        NavigationLink(destination: {
                            IndustryCenterView().navigationBarBackButtonHidden(true)
                        }, label: {
                            dashBoardTile(iconTileImage: "stack_gray", tileCount: "\(list.datas?.centers ?? 0)", mainTileImage: "school_library", tileName: "Center").overlay(alignment: .topTrailing){
                                
                                HStack(spacing: 6){
                                    Image("pdf_gray")
                                        .resizable()
                                        .frame(width: 25, height: 28)
                                    
                                    Text(String(list.datas?.departments ?? 0))
                                        .foregroundColor(.black)
                                        .font(.system(size: 22, weight: .regular))
                                }
                                .padding(.top)
                                .padding(.top,32)
                                .padding(.horizontal,6)
                                
                            }.padding(6)
                            
                        })
                        
                        
                        Button(action: {
                            isDeplistShow = true
                        }, label: {
                            dashBoardTile(iconTileImage: "stack_gray", tileCount: "\(list.datas?.totalstack ?? 0)", mainTileImage: "Stacks new", tileName: "Department").padding(4)
                        })
                        
                        Group{
                            
                            NavigationLink(destination: {
                                PublisherPrimeIssueBooksView().navigationBarBackButtonHidden(true)
                            }, label: {
                                dashBoardTile(iconTileImage: "purchased_gray", tileCount: "\(list.datas?.totelbooks ?? 0)", mainTileImage: "purchased_book", tileName: "Stacks")
                                    .padding(4)
                            })
                            
                            NavigationLink(destination: {
                                PublisherFreeIssueBooksView().navigationBarBackButtonHidden(true)
                                
                            }, label: {
                                
                                dashBoardTile(iconTileImage: "rupee_gray", tileCount: "\(list.datas?.centers ?? 0)", mainTileImage: "payment_hist", tileName: "Book")
                                    .padding(4)
                                
                            })
                            
                            NavigationLink(destination:
                                            PublisherPaidIssueBooksView()
                                .navigationTitle("")
                                .navigationBarHidden(true)
                                .navigationBarBackButtonHidden(true)){
                                    
                                    dashBoardTile(iconTileImage: "pdf_gray", tileCount: "s8", mainTileImage: "Subscription new", tileName: "Trainer")
                                        .padding(4)
                                    
                                }
                                .background(Color("default_"))
                                .cornerRadius(12)
                            
                            NavigationLink(destination:{
                                PublisherCreditFundsView()
                                    .navigationBarBackButtonHidden()
                                
                            }, label: {
                                dashBoardTile(iconTileImage: "coureses_gray", tileCount: "\(list.datas?.centers ?? 0)", mainTileImage: "course", tileName: "Trainee").padding(4)
                                
                            })
                            
                            NavigationLink(destination:{
                                PublisherBookRequestView()
                                    .navigationBarBackButtonHidden()
                                
                            }, label: {
                                dashBoardTile(iconTileImage: "test_correct_gray", tileCount: "\(0)", mainTileImage: "book_req", tileName: "Activies").padding(4)
                            })
                            
                            NavigationLink(destination: {
                                PublisherMyEarningView()
                                    .navigationBarBackButtonHidden(true)
                            }, label: {
                                dashBoardTile(iconTileImage: "coureses_gray", tileCount: "\(0)", mainTileImage: "home_work_color", tileName: "Payment History")
                                    .padding(4)
                                
                            })
                            
                        }
                        
                    }
                    
                }
            }.ignoresSafeArea().onAppear{
                list.getDashboardData()
            }
            
            if isDeplistShow == true {
                DepartmentCenterListView(isDepListOpen: $isDeplistShow, isNavigate: $isNavigate)
            }
            NavigationLink("", destination: IndustryDepartmentView().navigationBarBackButtonHidden(), isActive: $isNavigate)
        }
    }
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
    
    func dashBoardTile(iconTileImage: String?, tileCount: String,mainTileImage: String?, tileName: String) -> some View{
        VStack(spacing:6){
            HStack {
                Image(mainTileImage ?? "")
                    .resizable()
                    .frame(width: 95, height: 90, alignment: .leading)
                    .padding(.leading,5)
                    .padding(.bottom)
                    .padding(.top)
                
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
            
        }.ignoresSafeArea()
        .background(Color(hue: 1.0, saturation: 0.016, brightness: 0.83))
        .frame(width: .infinity, height: .infinity, alignment: .center)
        .cornerRadius(12)
        .shadow(color: Color.gray, radius: 5).overlay(alignment: .topTrailing){
            HStack{
                Image(iconTileImage ?? "")
                    .resizable()
                    .frame(width: 22, height: 25, alignment: .center)
                    .padding(.leading,35)
                Text(tileCount)
                    .bold()
                    .font(.custom("_", size: 23))
                    .foregroundColor(Color.black.opacity(0.8))
            }.padding()
        }
        
    }
    
}

struct IndustryDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        IndustryDashboardView()
//            .previewInterfaceOrientation(.landscapeLeft)
//        DepartmentCenterListView()
    }
}


// MARK: IndustryDashboardViewModel

class  IndustryDashboardViewModel: ObservableObject {
    @Published var datas:IndustryDashboardModel?
    func getDashboardData() {

//        let apiurl = APILoginUtility.studentExamTestApi
        guard let url = URL(string: "https://www.alibrary.in/api/industry/dashboard") else {
            // handle invalid URL error
            print("This is incorrect API URL...")
            return
        }
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
        let service = HTTPLoginUtility()

        service.getLoginData(from: url, model: IndustryDashboardModel.self, token: token){ (result) in
            switch result {
            case .success(let results):
                DispatchQueue.main.async {
                    self.datas = results.self
                    print(self.datas  as Any)
                }
            case .failure(let error):
                print(error.localizedDescription)

            }

        }

    }

}

 

// MARK: - IndustryDashboardModel
public struct IndustryDashboardModel: Decodable {
    public let centers: Int
    public let departments: Int
    public let totelbooks: Int
    public let totalstack: Int
    public let partner: IndustryPartner
    public let role: String
    public let rem_plan_days: String?
//    public let isPlanExpired: Int?
//    public let planname: String?
//    public let banners: [IndustryBanner]
//    public let data: Int
 
}

 
// MARK: - IndustryBanner
public struct IndustryBanner:Decodable {
    public let id: Int
    public let banner_for: String
    public let image_name: String
    public let publish_date_from: String
    public let publish_date_to: String
    public let web_url: String
    public let school_id: Int
    public let created_by: Int
    public let updated_by: Int
    public let deleted_at: String?
    public let created_at: String
    public let updated_at: String

 
}

// MARK: - IndustryPartner
public struct IndustryPartner: Decodable {
    public let id: Int
    public let partner_unique_id: String
    public let role_id: Int
    public let school_id: Int
    public let first_name: String
    public let full_name: String
    public let dob: String
    public let qr_code_url: String
    public let referal_code: String
    public let is_deleted: Int
    public let partner_role: IndustryPartnerRole
 
}

// MARK: - IndustryPartnerRole
public struct IndustryPartnerRole: Decodable {
    public let id: Int
    public let name: String
    public let guard_name: String
 
}


struct DepartmentCenterListView: View{
    @State var value = ""
    @State var center_id: Int?
    var placeholder = "Select center"
    @StateObject var list = IndustryCenterViewModel()
    @Binding var isDepListOpen: Bool
    @Binding var isNavigate: Bool
    var body: some View{
//        NavigationView{
            ZStack{
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                
                VStack(spacing:32){
                    HStack{
                        Image("ic_launcher").resizable().frame(width: 65, height: 65)
                            .cornerRadius(12)
                        Text("Select center").font(.system(size: 28, weight: .regular))
                            .foregroundColor(.white)
                        Spacer()
                    }.padding().background(Color.orange)
                    
                    
                    Menu {
                        
                        ForEach(list.datas ?? [], id: \.id){ client in
                            Button(action: {
                                self.value = client.full_name
                                self.center_id = client.id
                                print(self.center_id ?? "")
                            }, label: {
                                
                                Text(client.full_name)
                                    .foregroundColor(.black)
                            })
                            
                        }
                    } label: {
                        VStack(spacing: 5){
                            HStack{
                                Text(value.isEmpty ? placeholder : value)
                                    .foregroundColor(value.isEmpty ? .gray : .black).font(.system(size: 22))
                                Spacer()
                                Image(systemName: "play.fill").rotationEffect(Angle(degrees: 90))
                                    .foregroundColor(Color.gray)
                                    .font(Font.system(size: 12, weight: .light))
                            }
                            .padding(.horizontal)
                            Rectangle()
                                .fill(Color.black)
                                .frame(height: 2)
                        }.padding()
                    }
                    
                    HStack{
                        
                        Spacer()
                        Button(action: {
                            isDepListOpen = false
                        }, label: {
                            Text("Cancel")
                                .padding()
                                .padding(.horizontal)
                                .font(.system(size: 26))
                                .background(Color("default_"))
                                .foregroundColor(.white)
                                .cornerRadius(22)
                        })
                        NavigationLink(destination: {
                            
                        }, label: {
                            Button(action: {
                                isNavigate = true
                            }, label: {
                                Text("Ok")
                                    .padding()
                                    .padding(.horizontal)
                                    .font(.system(size: 26))
                                    .background(Color("default_"))
                                    .foregroundColor(.white)
                                    .cornerRadius(22)
                            })

                        })                    }.onAppear{
                        list.getCenterData()
                    }.padding()
                }.background(Color.white)
                    .cornerRadius(12)
                    .padding(6)
//            }
        }
    }
}
