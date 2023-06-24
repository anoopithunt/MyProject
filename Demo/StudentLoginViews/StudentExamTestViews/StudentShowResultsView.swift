//
//  StudentShowResultsView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 14/07/23.
//

import SwiftUI

struct StudentShowResultsView: View {
    @StateObject var list = StudentShowResultsViewModel()
    
    var body: some View {
        NavHeaderClosure(title: "Show results"){
            ZStack{
                Image("u").resizable() 
                HStack(alignment: .firstTextBaseline) {
                    
                    ScrollView{
                        ForEach(list.datas.reversed(), id: \.id){ item in
                            VStack(alignment: .leading){
                                Text(item.name).font(.system(size: 32, weight: .bold)).foregroundColor(Color("orange"))
                                Text(item.description).font(.system(size: 32, weight: .bold))
                                Rectangle().fill(Color.gray).frame(height:1)
                                HStack{
                                    Spacer()
                                    Text(item.status).font(.system(size: 22,weight: .bold))
                                        .padding(12)
//                                        .strokeRoundedRectangle(8, .gray, lineWidth: 1)
                                        .padding(4)
                                }
                            }.padding()
                                .background(Color.white)
                                .cornerRadius(12)
                                .padding()
                                .shadow(radius:2)
                        }
                    }
                    Spacer()
                    
                }
                
            }.onAppear{
                list.getCourseLectureData(subjectId: 95)
            }
            
        }
       
    }
}

struct StudentShowResultsView_Previews: PreviewProvider {
    static var previews: some View {
        StudentShowResultsView()
    }
}


  
 
// MARK: - StudentShowResultsModel


// MARK: - https://alibrary.in/api/student/getsubjecttests?subject_id=95


public struct StudentShowResultsModel: Decodable {
    public let subjectName: String
    public let subjectImage: String
    public let tests: [StudentShowResultsTest]
    public let partner: StudentShowResultsPartner
//    public let currentDate: String
//    public let data: Int

    
}


// MARK: - StudentShowResultsPartner
public struct StudentShowResultsPartner: Decodable {
    public let id: Int
    public let user_id: Int
    public let admission_no: String?
    public let full_name: String
    public let father_name: String
    public let gender: String
    public let dob: String
    public let referal_code: String?
    public let partner_role: StudentShowResultsPartnerRole
 
}

// MARK: - StudentShowResultsPartnerRole
public struct StudentShowResultsPartnerRole: Decodable {
    public let id: Int
    public let name: String
    public let guard_name: String

    
}

// MARK: - StudentShowResultsTest
public struct StudentShowResultsTest: Decodable {
    public let id: Int
    public let name: String
    public let description: String
    public let start_date: String
    public let end_date: String
//    public let taketest: [String?]
    public let bookimage: String
    public let status: String
    public let subject: StudentShowResultsSubject
//    public let book: NSNull
//    public let test_answers: [Any?]

     
}

// MARK: - StudentShowResultsSubject
public struct StudentShowResultsSubject: Decodable {
    public let id: Int
    public let subject: String
    public let description: String
    public let cover_page: String
    public let banner: String
 
}

// MARK: - StudentShowResultsViewModel
class  StudentShowResultsViewModel: ObservableObject {
    @Published var datas  = [StudentShowResultsTest]()
    
    func getCourseLectureData(subjectId: Int) {

//        let apiurl = APILoginUtility.studentExamTestApi
        guard let url = URL(string: "https://alibrary.in/api/student/getsubjecttests?subject_id=\(subjectId)") else {
            // handle invalid URL error
            print("This is incorrect API URL...")
            return
        }
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
        let service = HTTPLoginUtility()

        service.getLoginData(from: url, model: StudentShowResultsModel.self, token: token){ (result) in
            switch result {
            case .success(let results):
                DispatchQueue.main.async {
                    self.datas = results.tests
                    print(results)

                }
            case .failure(let error):
                print(error.localizedDescription)

            }

        }

    }

}
