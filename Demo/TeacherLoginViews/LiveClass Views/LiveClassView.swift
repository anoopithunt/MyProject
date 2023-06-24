//
//  LiveClassView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 08/11/23.
//

import SwiftUI

struct LiveClassView: View {
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM-dd-yyyy"
        formatter.locale = Locale.current
        return formatter
    }()
    
    @StateObject var list = LiveClassViewModel()
    
    var days: [Int: String] = [ 1: "Mon",2: "Tue",3: "Wed",4: "Thu",5: "Fri",6: "Sat",7: "Sun" ]
    
    @State var class_id:Int
    @State var sec_id:Int
    
    var body: some View {
        NavHeaderClosure(title:"Live Classes"){
            ZStack{
                Image("u")
                    .resizable()
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack{
                            ForEach(days.sorted(by: { $0.key < $1.key }), id: \.key) { id, day in
                                Button(action: {
                                    list.day = id
                                    list.getLiveClassData()
                                    
                                }, label: {
                                    Text("\(day)")
                                        .foregroundColor(.white)
                                        .font(.system(size: 22, weight: .medium))
                                        .padding(.horizontal)
                                        .padding(.vertical, 6)
                                        .background(Color("default_"))
                                        .cornerRadius(14)
                                    
                                })
                                
                            }
                            
                        }
                    }
                    ScrollView{
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]){
                            
                            ForEach(Array(list.datas.enumerated()), id: \.1.id) { (index, item) in
                            NavigationLink(destination: {
                                LiveClassDetailView(subject: "\(item.subject_name ?? "")")
                                    .navigationBarBackButtonHidden()
                            }, label: {
                                VStack{
                                    HStack{
                                        Text(dateFormatter.string(from: Date()))
                                            .font(.system(size: 18))
                                            .padding(.vertical)
                                        
                                        Spacer()
                                    }
                                    .padding(.horizontal)
                                    
                                    
                                    VStack(alignment: .center,spacing: 12){
                                        AsyncImage(url: URL(string: item.teacher_logo)){
                                            img in
                                            img
                                                .resizable()
                                                .frame(width: 95, height: 95)
                                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                                .padding(6)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 75)
                                                        .stroke(Color.white, lineWidth: 3)
                                                )
                                            
                                        } placeholder: {
                                            Image("logo_gray")
                                                 .resizable()
                                                .frame(width: 75, height: 75)
                                        }
                                        Text(item.subject_name ?? "")
                                            .font(.system(size: 20,weight: .bold))
                                        
                                        Text(item.teacher_name)
                                            .font(.system(size: 20,weight: .regular))
                                        
                                    }.padding()
                                    
                                    HStack{
                                        Text(item.from_time + "   to")
                                        
                                        Spacer()
                                        
                                        Text(item.to_time)
                                        
                                    }
                                    .padding(6)
                                    .background(Color.gray)
                                    .lineLimit(1)
                                    .foregroundColor(.black)
                                    
                                }
                                .padding(.bottom)
                                .background(Color(hex: colorlist[index % colorlist.count]))
                                .cornerRadius(12)
                                .foregroundColor(.white)
                            })
                                
                            }
                            
                        }
                    }.padding(.top, 4)
                    
                }
            }.onAppear{
                list.getLiveClassData()
                
            }
        }
        
    }
    
}

struct LiveClassView_Previews: PreviewProvider {
    static var previews: some View {
        LiveClassView(class_id: 59, sec_id: 30)
    }
}
 


// MARK: - LiveClassViewModel
 
class  LiveClassViewModel: ObservableObject {
    @Published var datas = [DaySession]()
    @Published var id = String()
    @Published var day = 3
    @Published var class_id: Int  = 59// Int()
    @Published var sec_id: Int = 30 // Int()
  
    func getLiveClassData() {
        
        //        let apiurl = APILoginUtility.studentExamTestApi
        guard let url = URL(string: "https://alibrary.in/api/student/get-tt-livesessions?class_id=\(self.class_id)&section_id=\(self.sec_id)&day=\(self.day)") else {
            // handle invalid URL error
            print("This is incorrect API URL...")
            return
        }
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
        let service = HTTPLoginUtility()
        
        service.getLoginData(from: url, model: LiveSessionModel.self, token: token){ (result) in
            switch result {
            case .success(let results):
                DispatchQueue.main.async {
//                    if !(results.daySession?.isEmpty ?? false){
                        self.datas = results.daySession ?? []
//                    } else{
//                        print("There is no Live Class for today for this class")
//                    }
                    print(self.datas.first as Any)
                     
                }
            case .failure(let error):
                print(error.localizedDescription)

            }

        }

    }

}
 


// MARK: - LiveSessionModel
public struct LiveSessionModel: Decodable {
    public let daySession: [DaySession]?
//    public let data: Int

    
}

// MARK: - DaySession
public struct DaySession:Decodable {
    public let id: Int
//    public let period_no: Int
    public let from_time: String
    public let to_time: String
//    public let subject_id: Int
//    public let teacher_id: Int
    public let teacher_name: String
    public let teacher_logo: String
    public let subject_name: String?
//    public let subject_logo: String?
//    public let is_live: NSNull
//    public let teacher_detail: TeacherDetail
//    public let subject_detail: SubjectDetail
 
}


 

// MARK: - SubjectDetail
public struct SubjectDetail:Decodable {
    public let id: Int
    public let subject: String
//    public let description: String
//    public let school_id: Int
//    public let is_template: Int
//    public let cover_page: String
//    public let banner: String
 
}

// MARK: - TeacherDetail
public struct TeacherDetail:Decodable {
    public let id: Int
//    public let role_id: Int
//    public let school_id: Int
//    public let school_class_link_id: Int
    public let full_name: String
//    public let father_name: String
//    public let gender: String
//    public let dob: String
//    public let qr_code_url: String
    
}
