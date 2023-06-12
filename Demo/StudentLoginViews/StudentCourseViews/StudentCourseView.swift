//
//  StudentCourseView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 15/06/23.
//

import SwiftUI

struct StudentCourseView: View {
    @StateObject var list = StudentCourseViewModel()
    @StateObject var profile = UserProfileViewModel()
    
    private var columns = [GridItem(.flexible()), GridItem(.flexible())]
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack{
            Image("u").resizable()
            Color.blue.opacity(0.4).ignoresSafeArea()
            
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
                    Text("Online Courses").font(.system(size: 22,weight: .bold))
               
                    Spacer()
                    Button(action: {
                        
                    }, label: {
                        
                        Text("Teachers").foregroundColor(.black).font(.system(size: 22,weight: .bold)).padding() .overlay(RoundedRectangle(cornerRadius: 11)
                            .stroke(Color.cgBlue, lineWidth:2))
                    })
                     
                    
                }.padding(.horizontal)
                
                Text(profile.class + " " + profile.section).padding(.leading)
                ScrollView(showsIndicators: false){
                    LazyVGrid(columns: columns, spacing: 10) {
                        
                        ForEach(list.datas, id: \.id){ item in
                            AsyncImage(url: URL(string: item.subject_detail.cover_page)){
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
                    AsyncImage(url: URL(string: profile.school_logo)){ image in
                        image.resizable().frame(width: 90, height: 90).cornerRadius(111).overlay(RoundedRectangle(cornerRadius: 111)
                            .stroke(Color.white, lineWidth: 3))
                        
                    }placeholder: {
                        Image("logo_gray").resizable().frame(width: 90, height: 90).cornerRadius(111).overlay(RoundedRectangle(cornerRadius: 111)
                            .stroke(Color.white, lineWidth: 2))
                    }
                    
                    Spacer()
                }
            
                Spacer()
            }.padding(.leading)
        }.onAppear{
            list.getCourseData()
        }
        
    }
}

struct StudentCourseView_Previews: PreviewProvider {
    static var previews: some View {
        StudentCourseView()
    }
}



//MARK: StudentCourseViewModel

class  StudentCourseViewModel: ObservableObject {
    @Published var datas  = [StudentCourseSubject]()

    func getCourseData() {

        let apiurl = "\(APILoginUtility.studentCourseApi)"
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

        service.getLoginData(from: url, model: StudentCourseModel.self, token: token){ (result) in
            switch result {
            case .success(let results):
                DispatchQueue.main.async {
                    self.datas = results.courseSubjects
                    print(results)

                }
            case .failure(let error):
                print(error.localizedDescription)

            }

        }

    }

}
 
 

// MARK: - StudentCourseModel
public struct StudentCourseModel:Decodable {
    public let courseSubjects: [StudentCourseSubject]
    
}
 

// MARK: - StudentCourseCourseSubject
public struct StudentCourseSubject:Decodable {
    public let id: Int
    public let school_id: Int
    public let name: String
    public let description: String
    public let class_id: Int
    public let subject_id: Int
    public let created_by: Int
    public let subject_detail: StudentCourseSubjectDetail
 
}

// MARK: - StudentCourseSubjectDetail
public struct StudentCourseSubjectDetail: Decodable {
    public let id: Int
    public let subject: String
    public let description: String
    public let school_id: Int
    public let is_template: Int?
    public let cover_page: String
    public let banner: String?
 
}
 
