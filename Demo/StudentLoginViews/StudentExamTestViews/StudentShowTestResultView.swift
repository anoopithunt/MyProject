//
//  StudentShowTestResultView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 25/07/23.
 
import SwiftUI
import RichText
 
struct StudentShowTestResultView: View {
    @StateObject var list = StudentSubjectTestViewModel()
    @State var btn: Bool = false
    var body: some View {
        NavHeaderClosure(title: "Show Results") {
            ZStack {
                Image("u")
                    .resizable()
                    .ignoresSafeArea()
                ScrollView{
                    if let questions = list.datas?.questions {
                        
                        ForEach(questions, id: \.id) { item in
                            Button(action: {
                                
                            }, label: {
                                VStack(alignment: .leading){
                                    RichText(html: item.question_text)
                                        .colorScheme(.auto)
                                        .fontType(.system)
                                        .foregroundColor(light: Color.black, dark: Color.primary) .multilineTextAlignment(.leading)
                                    
                                    ForEach(item.question_options, id: \.id) {
                                        option in
                                        HStack{
                                            Image(systemName:option.correct == 0 ?  "circle" : "smallcircle.filled.circle")
                                                .foregroundColor(option.correct == 0 ?.black : .gray)
                                                .font(.system(size: 22,weight: .heavy))
                                            
                                            Text(option.option)
                                        }.foregroundColor(.black)
                                            .font(.system(size: 22))
                                    }
                                    Text(item.status).font(.system(size: 22,weight: .bold)).foregroundColor(.green)
                                }
                                .padding(12)
                                .background(Color.white)
                                .cornerRadius(12)
                            })
                            .shadow(color: .green, radius: 0.2)
                            .padding()
                        }
                    }
                }
                .onAppear{
                    list.getSubjectTestData(subjectId: 74)
                }
            }
        }
    }
    
}

 
struct StudentShowTestResultView_Previews: PreviewProvider {
    static var previews: some View {
        StudentShowTestResultView()
    }
}
 
// MARK: - SubjectTestModel
public struct SubjectTestModel:Decodable {
    public let questions: [QuestionElement]
//    public let partner: SubjectTestPartner
//    public let loginRole: SubjectTestLoginRole
//    public let obtain: Int
//    public let currentDate: String
//    public let data: Int
 
}

// MARK: - SubjectTestLoginRole
public struct SubjectTestLoginRole:Decodable {
    public let id: Int
    public let school_class_link_id: Int
    public let first_name: String
    public let last_name: String
    public let full_name: String
    public let father_name: String
    public let gender: String
    public let dob: String
    public let partner_role: SubjectTestPartnerRole

    
}

// MARK: - SubjectTestPartnerRole
public struct SubjectTestPartnerRole:Decodable {
    public let id: Int
    public let name: String
    public let guard_name: String
    public let created_by: Int
 
}

// MARK: - SubjectTestPartner
public struct SubjectTestPartner: Decodable {
    public let id: Int
    public let partner_unique_id: String
    public let partner_library_id: String
    public let user_id: Int
    public let school_class_link_id: Int
    public let first_name: String
    public let last_name: String
    public let full_name: String
    public let father_name: String
    public let gender: String
    public let dob: String
    public let qr_code_url: String
    public let referal_code: String
    public let partner_role: SubjectTestPartnerRole

    
}

// MARK: - QuestionElement
public struct QuestionElement: Decodable {
    public let id: Int
    public let test_id: Int
    public let question_type_id: Int
//    public let image: String
    public let question_text: String
//    public let explanation_image: String
    public let status: String
//    public let question_type: SubjectTestQuestionType
    public let question_options: [SubjectTestQuestionOption]
//    public let test_detail: SubjectTestDetail
//    public let test_answers: [Any?]
}

// MARK: - SubjectTestQuestionOption
public struct SubjectTestQuestionOption: Decodable {
    public let id: Int
    public let question_id: Int
    public let option: String
    public let correct: Int?
    public let question: SubjectTestQuestions
 
}

// MARK: - QuestionOptionQuestion
public struct SubjectTestQuestions: Decodable {
    public let id: Int
    public let test_id: Int?
    public let question_type_id: Int?
    public let question_text: String
    public let is_attempted: Int?
 
}

// MARK: - SubjectTestQuestionType
public struct SubjectTestQuestionType: Decodable {
    public let id: Int
    public let type: String
    public let description: String
 
}

// MARK: - SubjectTestDetail
public struct SubjectTestDetail: Decodable {
    public let id: Int
    public let name: String
    public let description: String
    public let start_date: String
    public let end_date: String
 
}



// MARK: - StudentSubjectTestViewModel
// MARK: - https://alibrary.in/api/student/showResult?test_id=69


class  StudentSubjectTestViewModel: ObservableObject {
    @Published var datas:SubjectTestModel? //  = [SubjectTestModel]()
    
    func getSubjectTestData(subjectId: Int) {

//        let apiurl = APILoginUtility.studentExamTestApi
        guard let url = URL(string: "https://alibrary.in/api/student/showResult?test_id=\(subjectId)") else {
            // handle invalid URL error
            print("This is incorrect API URL...")
            return
        }
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
        let service = HTTPLoginUtility()

        service.getLoginData(from: url, model: SubjectTestModel.self, token: token){ (result) in
            switch result {
            case .success(let results):
                DispatchQueue.main.async {
                    self.datas = results.self
                    print(results)
                }
            case .failure(let error):
                print(error.localizedDescription)

            }

        }

    }

}
