//
//  SchoolLibraryView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 14/06/23.
//

import SwiftUI

struct SchoolLibraryView: View {
    @State var pdfs: Int
    @State var stacks: Int
    var body: some View {
        NavHeaderClosure(title: "School Library"){
            ZStack{
                Image("u")
                    .resizable()
                    .ignoresSafeArea()
                
                VStack{
                    NavigationLink(destination: {
                        StudentUserUploadView().navigationTitle("")
                            .navigationBarHidden(true)
                            .navigationBarBackButtonHidden(true)
                    }, label: {
                        LibraryViewTile(total: "\(stacks)", title: "PDF Files", headTitle: "Total Uploads", icon: "t_upload")
                    }
                    )
                    NavigationLink(destination: {
                        StudentUserStackView().navigationTitle("")
                            .navigationBarHidden(true)
                            .navigationBarBackButtonHidden(true)
                    }, label: {
                        LibraryViewTile(total: "\(pdfs)", title: "Stack Files", headTitle: "Total Stacks", icon: "t_stack")
                    })
                    
                    Spacer()
                }
            }
            
            
        }.navigationViewStyle(StackNavigationViewStyle())

    }
    
}

struct SchoolLibraryView_Previews: PreviewProvider {
    static var previews: some View {
        SchoolLibraryView(pdfs: 0, stacks: 4)
    }
}
 
/**
// MARK: - SchoolLibraryModel
public struct SchoolLibraryModel: Decodable {
    public let schoolBookCount: Int
    public let schoolStackCount: Int

}


//MARK: SchoolLibraryViewModel



class  SchoolLibraryViewModel: ObservableObject {
    @Published  public var schoolBookCount: Int = 0
    @Published  public var schoolStackCount: Int = 0// = Int()

    func getLibraryData() {

        let apiurl = "\(APILoginUtility.schoolLibraryApi)"
        guard let url = URL(string: apiurl) else {
            // handle invalid URL error
            return
        }
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
        let service = HTTPLoginUtility()

        service.getLoginData(from: url, model: SchoolLibraryModel.self, token: token){ (result) in
            switch result {
            case .success(let results):
                DispatchQueue.main.async {
                    self.schoolBookCount =  results.schoolBookCount
                    self.schoolStackCount = results.schoolStackCount

                    print(results)

                }
            case .failure(let error):
                print(error.localizedDescription)

            }

        }

    }

}

    */
