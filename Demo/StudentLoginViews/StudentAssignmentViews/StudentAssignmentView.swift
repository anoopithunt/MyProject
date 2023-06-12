//
//  StudentAssignmentView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 16/06/23.
//

import SwiftUI

struct StudentAssignmentView: View {
    @StateObject var list = StudentHomeworkViewModel()
    @StateObject var profile = UserProfileViewModel()
    
    private var columns = [GridItem(.flexible()), GridItem(.flexible())]
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack{
            Image("u").resizable()
            Color("green").opacity(0.4).ignoresSafeArea()
            
            VStack(alignment:.leading){
                  
                    AsyncImage(url: URL(string: "\(profile.mainImage)")){
                        img in
                        img.resizable()
                            .frame( height: 235, alignment: .center)
                    }placeholder: {
                        Image("logo_gray")
                            .resizable()
                            .frame( height: 235, alignment: .center)
                    }.onAppear{
                        profile.getProfileData()
                    }
              
                Text("Home Work").font(.system(size: 22,weight: .bold)).padding(.leading)
                    Spacer()
                   
                Text(profile.class + " " + profile.section).padding(.leading)
                    .font(.system(size: 20,weight: .medium))
                
                ScrollView(showsIndicators: false){
                    LazyVGrid(columns: columns, spacing: 10) {
                        
                        ForEach(list.datas, id: \.id){ item in
                            AsyncImage(url: URL(string: item.subjectImage)){
                                img in
                                img.resizable().frame( height: 145, alignment: .center)
                            }placeholder: {
                                Image("logo_gray")
                                    .resizable()
                                    .frame( height: 145, alignment: .center)
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
                        Image(systemName: "chevron.left").foregroundColor(.white).font(.system(size: 32,weight: .bold))
                    })
                  
                    Spacer()
                }
                HStack{
                    Spacer()
                    AsyncImage(url: URL(string: profile.school_logo)){ image in
                        image.resizable().frame(width: 120, height: 120).cornerRadius(111).overlay(RoundedRectangle(cornerRadius: 111)
                            .stroke(Color.white, lineWidth: 3))
                        
                    }placeholder: {
                        Image("logo_gray").resizable().frame(width: 120, height: 120).cornerRadius(111).overlay(RoundedRectangle(cornerRadius: 111)
                            .stroke(Color.white, lineWidth: 3))
                    }
                    
                    Spacer()
                }
            
                Spacer()
            }.padding(.leading)
        }.onAppear{
            list.getHomeworkData()
        }
        
    }
}

struct StudentAssignmentView_Previews: PreviewProvider {
    static var previews: some View {
        StudentAssignmentView()
    }
}
class  StudentHomeworkViewModel: ObservableObject {
    @Published var datas  = [StudentHomeworkSubject]()

    func getHomeworkData() {

        let apiurl = "\(APILoginUtility.studentHomeworkApi)"
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

        service.getLoginData(from: url, model: StudentHomeworkModel.self, token: token){ (result) in
            switch result {
            case .success(let results):
                DispatchQueue.main.async {
                    self.datas = results.homeworkSubjects
                    print(results)

                }
            case .failure(let error):
                print(error.localizedDescription)

            }

        }

    }

}
 
     

//MARK: StudentHomeworkModel


public struct StudentHomeworkModel: Decodable {
    public let homeworkSubjects: [StudentHomeworkSubject]
//    public let data: Int
 
}

// MARK: - StudentHomeworkSubject
public struct StudentHomeworkSubject: Decodable {
    public let id: Int
    public let partner_id: Int
    public let school_id: Int
    public let school_class_link_id: Int
    public let class_id: Int
    public let section_id: Int
    public let subject_id: Int
    public let school_class_subject_link_id: Int
    public let subjectName: String
    public let subjectImage: String
    public let subject_detail: StudentHomeworkSubjectDetail
 
}

// MARK: - StudentHomeworkSubjectDetail
public struct StudentHomeworkSubjectDetail: Decodable {
    public let id: Int
    public let subject: String
    public let description: String
    public let school_id: Int
    public let is_template: Int?
    public let cover_page: String?
    public let banner: String?

   
}

