//
//  StudentExamTestView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 08/07/23.
//

import SwiftUI

struct StudentExamTestView: View {
    
    @StateObject var list = StudentExamTestViewModel()
    @StateObject var profile = UserProfileViewModel()
    
    private var columns = [GridItem(.flexible()), GridItem(.flexible())]
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationView{
            ZStack{
                Image("u").resizable()
                Color.red.opacity(0.4).ignoresSafeArea()
                
                VStack(alignment:.leading){
                    
                    AsyncImage(url: URL(string: "\(profile.mainImage)")){
                        img in
                        img.resizable()
                            .frame( height: 215, alignment: .center)
                    }placeholder: {
                        Image("logo_gray")
                            .resizable()
                            .frame( height: 215, alignment: .center)
                    }.onAppear{
                        profile.getProfileData()
                    }
                    HStack{
                        Text("Exam/Test").font(.system(size: 22,weight: .bold))
                        
                        Spacer()
                        
                    }.padding(.horizontal)
                    
                    Text(profile.class + " " + profile.section).padding(.leading)
                    
                    ScrollView(showsIndicators: false){
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(list.datas, id: \.id){ item in
                                AsyncImage(url: URL(string: item.subject_detail.cover_page)){
                                    img in
                                    NavigationLink(destination: {
                                        CourseLectureView(subjectId: item.subject_id, subject: item.subject_detail.subject).navigationBarBackButtonHidden(true)
                                    }, label: {
                                        img.resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 130, height: 130)
                                            .cornerRadius(115)
                                            .overlay(RoundedRectangle(cornerRadius: 115)
                                                .stroke(Color.gray, lineWidth: 3))
                                    })
                                    
                                }placeholder: {
                                    Image("logo_gray").resizable()
                                        .frame( width:185,height: 185, alignment: .center)
                                }
                                
                            }
                        }.padding(6)
                        Spacer()
                    }
                }
                VStack{
                    HStack{
                        Button(action: {
                            dismiss()
                        }, label: {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                                .font(.system(size: 32,weight: .bold))
                            
                        })
                        
                        Spacer()
                        
                    }
                    HStack{
                        AsyncImage(url: URL(string: profile.school_logo)){
                            image in
                            
                            image.resizable()
                                .frame(width: 90, height: 90)
                                .cornerRadius(111)
                                .padding(4)
                                .overlay(RoundedRectangle(cornerRadius: 111)
                                .stroke(Color.white, lineWidth: 3))
                            
                        }placeholder: {
                            Image("logo_gray").resizable()
                                .frame(width: 90, height: 90)
                                .cornerRadius(111)
                                .overlay(RoundedRectangle(cornerRadius: 111)
                                .stroke(Color.white, lineWidth: 2))
                        }
                        
                        Spacer()
                    }
                    
                    Spacer()
                }.padding(.leading)
            }
        }.onAppear{
            list.getExamTestData()
        }
        
    }
}

struct StudentExamTestView_Previews: PreviewProvider {
    static var previews: some View {
        StudentExamTestView()
    }
} 
 
// MARK: - StudentExamTestModel
public struct StudentExamTestModel: Decodable {
    public let subjects: [StudentExamTestSubject]

    
}

// MARK: - StudentExamTestSubject
public struct StudentExamTestSubject:Decodable {
    public let id: Int
    public let school_id: Int
    public let class_id: Int
    public let section_id: Int
    public let subject_id: Int
    public let subject_detail: StudentExamTestSubjectDetail
}

// MARK: - StudentExamTestSubjectDetail
public struct StudentExamTestSubjectDetail:Decodable {
    public let id: Int
    public let subject: String
    public let description: String
    public let school_id: Int
    public let cover_page: String
    public let banner: String?
}

// MARK: - StudentExamTestViewModel

class  StudentExamTestViewModel: ObservableObject {
    @Published var datas  = [StudentExamTestSubject]()
    
    func getExamTestData() {

        let apiurl = APILoginUtility.studentExamTestApi
        guard let url = URL(string: apiurl) else {
            // handle invalid URL error
            print("This is incorrect API URL...")
            return
        }
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
        let service = HTTPLoginUtility()

        service.getLoginData(from: url, model: StudentExamTestModel.self, token: token){ (result) in
            switch result {
            case .success(let results):
                DispatchQueue.main.async {
                    self.datas = results.subjects
                    
                    print(results)

                }
            case .failure(let error):
                print(error.localizedDescription)

            }

        }

    }

}
 


