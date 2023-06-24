//
//  StudentUserStackView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 14/06/23.
//

import SwiftUI

struct StudentUserStackView: View {
    
    @State var rotate: [Int] = [-10, 10, 0]
    //    @State var index: Int = -1
    @State var searchText: String = ""
    @StateObject var list = StudentUserStackViewModel()
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    @FocusState private var isTextFieldFocused: Bool
    var body: some View {
        NavHeaderClosure(title: "School Stacks"){
            ZStack{
                Image("u").resizable().ignoresSafeArea()
                VStack(spacing:10){
                    ScrollView{
                        
//                        TextField("search stacks", text: $searchText)
//                            .font(.title)
//                            .padding(4)
//                            .padding(.trailing,26)
//                            .foregroundColor(.gray)
//                            .cornerRadius(8)
//                            .focused($isTextFieldFocused)
//                            .showClearButton($searchText)
//                            .overlay(
//
//                                RoundedRectangle(cornerRadius: 8)
//                                    .stroke(Color.red, lineWidth: 0.6)
//                            )
//                            .frame(height: 55)
                        LazyVGrid(columns: columns, spacing: 10){
                            ForEach(list.datas, id:\.id){ item in
                                
                                VStack{
                                    NavigationLink(destination: {
                                        
//                                        GuestStackBookListView( id: item.id,title: "\(item.name)")
//                                            .navigationTitle("")
//
//                                            .navigationBarHidden(true)
//
//                                            .navigationBarBackButtonHidden(true)
                                        
                                    }, label: {
                                        ZStack(alignment: .center){
                                            ForEach(0..<min(item.stack_book_link.count, 3), id: \.self) { index in
                                                AsyncImage(url: URL(string: item.stack_book_link[index].book_url)){ img in
                                                    img.resizable()
                                                        .frame(width: 145, height: 175)
                                                        .rotationEffect(Angle(degrees: Double(rotate[index % rotate.count])))
                                                        .shadow(radius: 5)
                                                    
                                                }placeholder: {
                                                    Image("logo_gray")
                                                        .resizable()
                                                        .frame(width: 145, height: 155)
                                                    
                                                }
                                                
                                            }
                                            
                                        }
                                        
                                    })
//                                    VStack(alignment: .leading){
//
//                                        Text(item.name)
//                                            .foregroundColor(Color("default_"))
//
//                                        Text("By: \(item.createdBy)")
//                                            .foregroundColor(Color("maroon"))
//
//                                        HStack{
//                                            Text("\(item.stack_book_links_count)")
//
//                                                .foregroundColor(Color("default_"))
//
//                                            Image("stack_blue")
//                                                .resizable()
//                                                .frame(width: 18, height: 22)
//
//                                            Spacer()
//                                            Button(action: {
//
//                                            }, label: {
//                                                Text("Copy")
//                                                    .font(.system(size:18))
//
//                                                    .padding(.horizontal)
//                                                    .padding(.vertical,4)
//                                                    .foregroundColor(.white)
//                                                    .background(Color.cyan)
//                                                    .cornerRadius(12)
//                                                    .overlay(
//                                                        RoundedRectangle(cornerRadius: 15)
//                                                            .stroke(Color.white, lineWidth: 1.0)
//                                                            .shadow(radius:0.8)
//
//                                                    )
//
//                                            })
//
//                                        }
//
//                                    }.padding(2)
                                    
                                }.padding(20)
                                    .background(Color.white)
                                    .cornerRadius(12)
                                    .shadow(radius: 2).padding()
                                
                            }
//                            if list.currentPage < list.totalPage{
//                                ProgressView()
//                                    .frame(alignment: .center)
//                                    .onAppear{
//                                        list.currentPage = list.currentPage + 1
//                                        list.getUserStackBookData()
//
//                                    }
//
//                            }
//                            Spacer()
                        }
                    }
                }
                .refreshable(action: {
                    //Refresh Action for recall the API
                    
                })
            }.onAppear{
                list.getUserStackData()
            }
        }
    }
}

struct StudentUserStackView_Previews: PreviewProvider {
    static var previews: some View {
        StudentUserStackView()
    }
}
 
//MARK: StudentUserStackModel
 
public struct StudentUserStackModel:Decodable {
    public let schoolStack: StudentUserSchoolStack
    public let studentDetail: StudentUserStackStudentDetail
    public let userRole: String
    public let status: Int

     
}

  
// MARK: - StudentUserStackSchoolStack
public struct StudentUserSchoolStack:Decodable {
    public let current_page: Int
    public let data: [StudentUserStackDatum]
//    public let first_page_url: String
//    public let from: Int
    public let last_page: Int
//    public let last_page_url: String
//    public let path: String
//    public let per_page: Int
//    public let to: Int
//    public let total: Int

    
}

// MARK: - StudentUserStackDatum
public struct StudentUserStackDatum:Decodable {
    public let id: Int
//    public let partner_id: Int
//    public let bookcount: Int
//    public let stackBookCount: Int
//    public let stack_detail: StudentUserStackDetail
//    public let partner_detail: StudentUserStackPartnerDetail
    public let stack_book_link: [StudentUserStackBookLink]

    
}
 

// MARK: - StudentUserStackPartnerDetail
public struct StudentUserStackPartnerDetail:Decodable {
    public let id: Int
    public let partner_unique_id: String
    public let role_id: Int
    public let full_name: String
    public let qr_code_url: String
    public let is_active: Int
 
}


// MARK: - StudentUserStackBookLink
public struct StudentUserStackBookLink:Decodable {
    public let id: Int
//    public let stack_id: Int
    public let book_url: String
    public let book_media: StudentUserStackBookMedia

     
}

// MARK: - StudentUserStackBookMedia
public struct StudentUserStackBookMedia:Decodable {
    public let id: Int
    public let book_media_type_id: Int
    public let url: String

    
}

// MARK: - StudentUserStackDetail
public struct StudentUserStackDetail:Decodable {
    public let id: Int
    public let name: String
    public let description: String
 
}

// MARK: - StudentUserStackStudentDetail
public struct StudentUserStackStudentDetail:Decodable {
    public let id: Int
    public let admission_no: String?
    public let roll_no: String?
    public let role_id: Int
    public let school_id: Int
    public let school_class_link_id: Int
    public let full_name: String
    public let gender: String
    public let dob: String

    
}

 
//MARK: StudentUserStackViewModel


class  StudentUserStackViewModel: ObservableObject {
    @Published var datas  = [StudentUserStackDatum]()
    @State var currentPage = 1
    @State var totalPage = Int()
    func getUserStackData() {

        let apiurl = "\(APILoginUtility.studentStackApi)"
        guard let url = URL(string: apiurl) else {
            // handle invalid URL error
            return
        }
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
        let service = HTTPLoginUtility()

        service.getLoginData(from: url, model: StudentUserStackModel.self, token: token){ (result) in
            switch result {
            case .success(let results):
                DispatchQueue.main.async {
                    if !results.schoolStack.data.isEmpty {
                        self.datas = results.schoolStack.data
                    } else {
                        
                        print("This Empty")
                    }
                    self.totalPage = results.schoolStack.last_page
                    print(results)

                }
            case .failure(let error):
                print(error.localizedDescription)

            }

        }

    }

}
 

