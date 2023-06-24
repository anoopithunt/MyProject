//
//  TeacherClassListView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 31/10/23.
//

import SwiftUI

struct TeacherClassListView: View {
    @State var isClass: Bool
    @StateObject var list = ClassListViewModel()
    var body: some View {
        NavHeaderClosure(title: "Class List"){
            ZStack{
                Image("u")
                    .resizable()
                    .ignoresSafeArea()
                ScrollView{
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]){
                        ForEach(list.datas ?? [], id: \.id){ item in
                            VStack{
                                NavigationLink(destination: {
                                    if isClass{
                                        AssignmentView(id: "\(item.id)", title: item.class).navigationBarBackButtonHidden()
                                    } else {
                                        EmptyView()
                                    }
                                }, label: {
                                    Text(item.class)
                                        .font(.system(size: 22, weight: .bold))
                                        .padding(8)
                                        .foregroundColor(.white)
                                })
                            }
                            .frame(width: UIScreen.main.bounds.width/2.2)
                            .background(Color("default_"))
                            .cornerRadius(14)
                            
                        }
                    }
                    .padding(.top)
                }
                
            }.onAppear{
                list.getClasses()
            }
        }
    }
}

struct TeacherClassListView_Previews: PreviewProvider {
    static var previews: some View {
        TeacherClassListView(isClass: false)
    }
}

 


 // MARK: - ClassListModel
public struct ClassListModel: Decodable {
    public let classes: [ClassList]
//    public let partner: ClassListPartner
}
// MARK: - ClassList
public struct ClassList:Decodable {
    public let id: Int
    public let `class`: String
//    public let description: String

     
}

// MARK: - ClassListPartner
public struct ClassListPartner:Decodable {
    public let id: Int
    public let first_name: String
    public let last_name: String
    public let full_name: String
    public let father_name: String
    public let gender: String
    public let dob: String
    public let partner_role: ClassListPartnerRole

   
}

// MARK: - ClassListPartnerRole
public struct ClassListPartnerRole: Decodable {
    public let id: Int
    public let name: String
    public let guard_name: String
    
}

// MARK: - ClassListViewModel
class  ClassListViewModel: ObservableObject {
    @Published var datas:[ClassList]?
    
    func getClasses() {

//        let apiurl = APILoginUtility.studentExamTestApi
        guard let url = URL(string: "https://www.alibrary.in/api/guest/homeworkClass") else {
            // handle invalid URL error
            print("This is incorrect API URL...")
            return
        }
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
        let service = HTTPLoginUtility()

        service.getLoginData(from: url, model: ClassListModel.self, token: token){ (result) in
            switch result {
            case .success(let results):
                DispatchQueue.main.async {
                    if !results.classes.isEmpty{
                        self.datas = results.classes
                    } else{
                        print("There is no assignment for this class")
                    }
                    print(results.classes)
                }
            case .failure(let error):
                print(error.localizedDescription)

            }

        }

    }

}
