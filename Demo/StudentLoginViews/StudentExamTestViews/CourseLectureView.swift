//
//  CourseLectureView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 10/07/23.
//

import SwiftUI

struct CourseLectureView: View {
    @State var subjectId: Int
    @State var subject: String?
    @StateObject var list = StudentCourseLecturesViewModel()
    var body: some View {
        NavHeaderClosure(title: subject ?? ""){
            ZStack{
                Image("u").resizable()
                VStack(alignment: .leading){
                    ScrollView(showsIndicators: false){ 
                        ZStack{
                            AsyncImage(url: URL(string: list.details?.banner_url ?? "" )){
                                img in
                                img.resizable().frame(height: 125)
                            }placeholder: {
                                Color.gray
//                                Image("logo_gray").resizable()
                                    .frame(height: 125)
                            }
                            VStack{
                                Text("\(list.details?.subject ?? "")" + " Classes" )
                                    .foregroundColor(.white)
                                    .font(.system(size: 32, weight: .heavy))
                                
                            }
                        }
                        HStack{
                            VStack(alignment: .leading){
                                Text(list.details?.subject ?? "").font(.system(size: 26,weight: .bold))
                                Text(list.school_details?.full_name ?? "").font(.system(size: 22,weight: .medium))
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                        }.padding(.leading)
                        HStack{
                            AsyncImage(url: URL(string: list.details?.coverpage_url ?? "")){
                                img in img.resizable()
                                    .frame(width: 70, height: 70)
                                    .cornerRadius(65)
                                    .padding(6)
                                    .overlay(RoundedRectangle(cornerRadius: 75)
                                        .stroke(Color.gray, lineWidth: 3))
                            } placeholder: {
                                Image("logo_gray")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .cornerRadius(65)
                                    .padding(6)
                                    .overlay(RoundedRectangle(cornerRadius: 75)
                                        .stroke(Color.gray, lineWidth: 3))
                            }
                            Text("\(list.datas.count) Students")
                            Spacer()
                        }.padding()
                        ForEach(list.datas, id: \.id){item in
                           
                                HStack{
                                    NavigationLink(destination: {
                                        LectureVideoView()
//                                            .navigationBarBackButtonHidden()
                                        
                                    }, label: {
                                    ZStack{
                                        Color.black
                                        Image("logo_gray")
                                            .resizable()
                                            .frame(width:123, height:112)
                                        
                                    }.frame(width:150, height:120)
                                    })
                                        .cornerRadius(12)
                                        .overlay(alignment:  .bottomTrailing){
                                            
                                            Text("00:00")
                                                .foregroundColor(.white)
                                                .font(.system(size: 22, weight: .regular))
                                                .padding(.trailing,4)
                                            
                                        }.padding(4)
                                
                                VStack(alignment: .leading){
                                    Text(item.name ?? "")
                                        .foregroundColor(Color.black)
                                    Text(item.description ?? "")
                                        .foregroundColor(Color.black)
                                    Spacer()
                                    
                                    Text("\(item.tot_views ?? 0) views: \(item.published)")
                                        .foregroundColor(Color.black)
                                    
                                    HStack{
                                        Spacer()
                                        
                                    }.padding(.horizontal)//.padding(.bottom)
                                }
                            }.overlay(alignment: .topTrailing){
                                Menu {
                                    
                                    Button(action: {
                                        
                                    }, label: {
                                        Text("Notes").foregroundColor(.black).font(.system(size: 23,weight: .bold))
                                    })
                                    
                                    Button(action: {
                                        
                                    }, label: {
                                        HStack{
                                            Image(systemName: "eye")
                                            
                                            Text("Quiz").foregroundColor(.black).font(.system(size: 23,weight: .bold))
                                            
                                        }
                                    })
                                    
                                    
                                } label: {
                                    
                                    Image(systemName: "ellipsis")
                                        .rotationEffect(Angle(degrees: 90)).padding()
                                }
                            }.background(Color.white)
                       
                            Rectangle().fill(Color.gray).frame(height:1)
                            
                        }
                        
                    }
                    
                }.onAppear{
                    list.getCourseLectureData(subjectId: subjectId)
                    
                }
            }
        }
    }
}

struct CourseLectureView_Previews: PreviewProvider {
    static var previews: some View {
        CourseLectureView(subjectId: 137, subject: "English")
    }
}

  
// MARK: - CourseLecturesModel
public struct CourseLecturesModel: Decodable {
    public let courseLectures: CourseLectures
//    public let lectureCount: Int
    public let schoolDetail: CourseLecturesSchoolDetail
    public let subject: CourseLecturesSubject
 
}

// MARK: - CourseLectures
public struct CourseLectures: Decodable {
    public let current_page: Int
    public let data: [CourseLecturesDatum]
//    public let first_page_url: String
//    public let from: Int
    public let last_page: Int
//    public let last_page_url: String
//    public let path: String
//    public let per_page: Int
//    public let to: Int
//    public let total: Int

   
}

// MARK: - CourseLecturesDatum
public struct CourseLecturesDatum: Decodable {
    public let id: Int
//    public let course_id: Int
//    public let course_name: String
    public let name: String?
    public let description: String?
    public let tot_views: Int?
//    public let image: String
    public let video_url: String
//    public let notes_text: String
    public let published: String
//    public let tot_views: Int
 
}


 

// MARK: - CourseLecturesSchoolDetail
public struct CourseLecturesSchoolDetail: Decodable {
    public let id: Int
    public let full_name: String?
//    public let partner_unique_id: String
    public let role_id: Int
    public let logo_url: String
    public let coverpage_url: String?
    public let banner_url: String

   
}

// MARK: - CourseLecturesSubject
public struct CourseLecturesSubject: Decodable {
    public let id: Int
    public let subject: String
    public let description: String
    public let school_id: Int
    public let cover_page: String
//    public let banner: String?
//    public let created_by: Int
//    public let updated_by: Int
    public let coverpage_url: String
    public let banner_url: String
 
}

 
   


// MARK: - StudentCourseLecturesViewModel

class  StudentCourseLecturesViewModel: ObservableObject {
    @Published var datas  = [CourseLecturesDatum]()
    @Published var details:CourseLecturesSubject?//  = String()
    @Published var school_details:CourseLecturesSchoolDetail?//  = String()
    
    func getCourseLectureData(subjectId: Int) {

//        let apiurl = APILoginUtility.studentExamTestApi
        guard let url = URL(string: "https://alibrary.in/api/student/showSubjectCourses?subject_id=\(subjectId)") else {
            // handle invalid URL error
            print("This is incorrect API URL...")
            return
        }
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
        let service = HTTPLoginUtility()

        service.getLoginData(from: url, model: CourseLecturesModel.self, token: token){ (result) in
            switch result {
            case .success(let results):
                DispatchQueue.main.async {
                    if !results.courseLectures.data.isEmpty{
                        self.datas = results.courseLectures.data
                        
                    } else{
                        print("Empty Lecture")
                    }
                    self.details = results.subject
                    self.school_details = results.schoolDetail
                    print(self.details as Any)

                }
            case .failure(let error):
                print(error.localizedDescription)

            }

        }

    }

}
 
