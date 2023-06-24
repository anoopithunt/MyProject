//
//  AssignmentView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 01/11/23.
//

import SwiftUI
 
struct AssignmentView: View {
    @State var id:String
    @State var title:String?
    @StateObject var list = AssignmentViewModel()
    @State private var selectedYear = 2023
    @State private var selectedSection = "Select Section"
    @State private var selectedSubject = "Select Subject"
    @Environment(\.dismiss) var dismiss

    var body: some View {

        NavigationView{
            ZStack{
                Image("u")
                    .resizable()
                    .ignoresSafeArea()

                VStack{
                    HStack(spacing: 12){
                        Button(action: {
                            dismiss()
                        }, label: {
                            Image(systemName: "arrow.backward")
                                .font(.system(size: 22, weight: .bold))
                        })

                        Text(title ?? "")
                            .font(.system(size: 28, weight: .bold))
                        Spacer()

                        NavigationLink(destination: {
                            EmptyView()
                        }, label: {
                            Image(systemName: "plus")
                                .font(.system(size: 26, weight: .bold))
                                .padding()
                                .foregroundColor(.white)
                        })
                    }
                    .padding(.horizontal)
                    .foregroundColor(.white)
                    .frame(height: 75)
                    .background(Color("orange"))


                    HStack{
                        Menu {
                            ForEach(list.sections.indices, id: \.self) { index in
                                Button(String(describing: list.sections[index].section)) {

                                    self.selectedSection = list.sections[index].section
                                    
//                                    list.sel_year = "\(list.years[index])"
                                    print(list.sections.count)
//                                   list.datas.removeAll()
//                                 list.getRCEarningsData(currentPage: 1)
                                }
                            }
                        } label: {
                            Text(String(describing: selectedSection))
                                .foregroundColor(.black)
                                .font(.system(size: 22, weight: .regular))
                                .frame(width: UIScreen.main.bounds.width / 2.3)

                        }
                        .padding(6)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.orange, lineWidth: 1.9)
                                .frame(width: UIScreen.main.bounds.width / 2.3)
                        )
                        Spacer()
                        Menu {
                            ForEach(list.subjects.indices, id: \.self) { index in
                                Button(String(describing: list.subjects[index].subject)) {
                                    self.selectedSubject = list.subjects[index].subject
                                    //                                list.sel_year = "\(list.years[index])"
                                    print(list.sections.count)
//                                    list.datas.removeAll()
                                    
//                                    list.getRCEarningsData(currentPage: 1)
                                }
                            }
                        } label: {
                            Text(String(describing: selectedSubject))
                                .foregroundColor(.black)
                                .font(.system(size: 22, weight: .regular))
                                .frame(width: UIScreen.main.bounds.width / 2.3)

                        }
                        .padding(6)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.orange, lineWidth: 1.6)
                                .frame(width: UIScreen.main.bounds.width / 2.3)
                        )
                    }
                    .padding(2)
                    .padding(.horizontal)
                    ScrollView{
                        LazyVGrid(columns: [GridItem(.flexible())]){
                            ForEach(list.datas ?? [], id: \.id){ item in

                                VStack{
                                    HStack{
                                        VStack(alignment: .leading,spacing: 4){
                                            Text(item.subject_name)
                                                .font(.system(size: 22, weight: .bold))
                                                .padding(0)
                                                .foregroundColor(Color("default_"))
                                            Text("section \(item.section_name)")
                                                .font(.system(size: 22, weight: .regular))
                                                .padding(0)
                                                .foregroundColor(.gray)

                                            Text(item.description)
                                                .font(.system(size: 16, weight: .medium))
                                                .padding(4)
                                                .foregroundColor(.gray)
                                            HStack{
                                                Text("Created At \(item.createdAt)")
                                                    .font(.system(size: 16, weight: .regular)) .padding(4)
                                                    .foregroundColor(.gray)
                                                Spacer()
                                                
                                                Text("Publish Date \(item.homeworkDate)")
                                                    .font(.system(size: 16, weight: .regular))
                                                    .padding(4)
                                                    .foregroundColor(.gray)
                                                
                                            }.padding(.horizontal,6)

                                            Text("Created By \(item.createdBy)")
                                                .font(.system(size: 18, weight: .regular))
                                                .padding(8)
                                                .foregroundColor(Color("default_"))
                                        }
                                        .padding(8)
                                        VStack{
                                            Text("HomeWork Uploaded")
                                                .foregroundColor(.gray)
                                                .font(.system(size: 11, weight: .regular))


                                            Spacer()

                                            Text("\(item.studentcount)")
                                                .foregroundColor(.gray)
                                                .font(.system(size: 26, weight: .regular))

                                            Spacer()


                                        }.frame(width: 65)

                                    }

                                    Divider()
                                        .frame(height: 1)
                                        .background(Color.gray)

                                    HStack{
                                        NavigationLink(destination: {
                                            AssignmentPreviewView(title: item.subject_name, date: item.publish_date, description: item.description)
                                                .navigationBarBackButtonHidden()

                                        }, label: {
                                            Text("View")
                                                .font(.system(size: 18, weight: .bold))
                                                .padding(12)
                                                .padding(.horizontal)
                                                .foregroundColor(.white)
                                                .background(Color("default_"))
                                                .cornerRadius(14)
                                        })
                                        Spacer()
                                        Text("Edit")
                                            .font(.system(size: 18, weight: .bold))
                                            .padding(12)
                                            .padding(.horizontal)
                                            .foregroundColor(.white)
                                            .background(Color("default_"))
                                            .cornerRadius(14)

                                        Spacer()
                                        Text("Status")
                                            .font(.system(size: 18, weight: .bold))
                                            .padding(12)
                                            .padding(.horizontal)
                                            .foregroundColor(.white)
                                            .background(Color("default_"))
                                            .cornerRadius(14)
                                        Spacer()

                                        Image("delete_gray")
                                            .resizable()
                                            .frame(width: 25, height: 35)
                                    }
                                    .padding()

                                }
                                .background(Color.white)
                                .cornerRadius(14)

                            }

                        }
                    }
                    .padding(.horizontal,8)

                }
            }
        }.onAppear{
            list.id = self.id
            list.getAssignmentData()
        }

    }
}
 
 
struct AssignmentView_Previews: PreviewProvider {
    static var previews: some View {
        AssignmentView(id: "59", title: "L.K.G.")
    }
}
   
// MARK: - AssignmentViewModel
class  AssignmentViewModel: ObservableObject {
    @Published var datas:[AssignmentDatum]?
    @Published var sections = [AssignmentSection]()
    @Published var subjects = [AssignmentSubject]()
    @Published var id = String()
    @Published var totalPage:Int = 1//Int()
    
    func getAssignmentData() {

//        let apiurl = APILoginUtility.teacherAssignmentApi
        guard let url = URL(string: "https://www.alibrary.in/api/guest/class-homeworks?class_id=\(self.id)") else {
            // handle invalid URL error
            print("This is incorrect API URL...")
            return
        }
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
        let service = HTTPLoginUtility()

        service.getLoginData(from: url, model: AssignmentModel.self, token: token){ (result) in
            switch result {
            case .success(let results):
                DispatchQueue.main.async {
                    if !results.home_works.data.isEmpty{
                        self.totalPage = results.home_works.last_page
                        print(results.home_works.last_page)
                        self.datas = results.home_works.data
                    } else{
                        print("There is no homework for this class")
                    }
                    print(self.datas as Any)
                    self.sections = results.sections
                    self.subjects = results.subjects
                     
                }
            case .failure(let error):
                print(error.localizedDescription)

            }

        }

    }

}
 
  // MARK: - AssignmentModel
public struct AssignmentModel: Decodable {
    public let partner: AssignmentPartner
    public let home_works: AssignmentHomeWorks
    public let sections: [AssignmentSection]
    public let subjects: [AssignmentSubject]
    public let class_id: String
    public let `class`: AssignmentClass
    public let section_id: String
    public let subject_id: String
    public let data: Int
 
}
 
// MARK: - AssignmentHomeWorks
public struct AssignmentHomeWorks: Decodable {
    public let current_page: Int
    public let data: [AssignmentDatum]
    public let last_page: Int
    
}

// MARK: - AssignmentDatum
public struct AssignmentDatum: Decodable {
    public let id: Int
    public let school_id: Int
    public let description: String
    public let teacher_subject_link_id: Int
    public let publish_date: String
    public let class_name: String
    public let section_id: Int
    public let section_name: String
//    public let subject_id: Int
    public let subject_name: String
    public let studentcount: Int
    public let homeworkDate: String
    public let createdAt: String
    public let createdBy: String
    public let teachers_subject_link: AssignmentTeachersSubjectLink
    public let home_work_uplods: [AssignmentHomeWorkUpload]
    
}

// MARK: - AssignmentHomeWorkUplod
public struct AssignmentHomeWorkUpload: Decodable {
    public let id: Int
    public let school_id: Int
    public let student_id: Int
    public let homework_id: Int
    public let pdf_url: String
 
}

// MARK: - AssignmentTeachersSubjectLink
public struct AssignmentTeachersSubjectLink: Decodable {
    public let id: Int
    public let school_class_link: AssignmentSchoolClassLink
    public let subject_detail: AssignmentSubject
    public let class_detail: AssignmentClass
    public let section_detail: AssignmentSectionDetail
    
}

// MARK: - AssignmentClass
public struct AssignmentClass:Decodable {
    public let id: Int
    public let `class`: String
    public let description: String
 
}

// MARK: - AssignmentSchoolClassLink
public struct AssignmentSchoolClassLink: Decodable {
    public let id: Int
    public let school_id: Int
    public let class_id: Int
    public let class_detail: AssignmentClass
    public let section_detail: AssignmentSectionDetail
 
}

// MARK: - AssignmentSectionDetail
public struct AssignmentSectionDetail: Decodable {
    public let id: Int
    public let section: String
    public let description: String
 
}

// MARK: - AssignmentSubject
public struct AssignmentSubject: Decodable {
    public let id: Int
    public let subject: String
    public let description: String
    public let cover_page: String
    
}

// MARK: - AssignmentPartner
public struct AssignmentPartner: Decodable {
    public let id: Int
    public let full_name: String
    public let father_name: String
    public let dob: String
    public let partner_role: AssignmentPartnerRole
 
}

// MARK: - AssignmentPartnerRole
public struct AssignmentPartnerRole:Decodable {
    public let id: Int
    public let name: String
    public let guard_name: String
    
}

// MARK: - AssignmentSection
public struct AssignmentSection:Decodable {
    public let id: Int
    public let section: String
    public let description: String
//    public let school_id: Int
    
}
