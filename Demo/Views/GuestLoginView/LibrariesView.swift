//
//  LibrariesView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 06/04/23.
//

import SwiftUI

struct LibrariesView: View {
    @State private var isPublicLinkClicked = true
       @State private var isSelfLinkClicked = false
    @StateObject var list = GuestLibraryViewModel()
    var body: some View {
        ZStack{
           
                
            NavigationView{
                NavHeaderClosure(title: "Libraries"){
                    ZStack{
                        Image("u").resizable().ignoresSafeArea()
                        VStack{
                            HStack(spacing: 10){
                                NavigationLink(destination: {
                                
                                LibraryView(totalUploads: "\(list.guestPDFCount)", totalStacks: "\(list.guestStackCount)", title: "Public Library")
                                        .navigationTitle("")
                                        .navigationBarHidden(true)
                                        .navigationBarBackButtonHidden(true)
                            }, label: {
                               
                                    LibrariesViewTile(title: "Public", image: "public_stack", stackCount: "\(list.guestStackCount)", pdfCount: "\(list.guestPDFCount)")
                                                               
                            })
                                
                                NavigationLink(
                                    destination: {
                                    
                                        SelfLibraryView(totalUploads: "\(list.ownPDFCount)", totalStacks: "\(list.ownStackCount)")
                                            .navigationTitle("")
                                            .navigationBarHidden(true)
                                            .navigationBarBackButtonHidden(true)
                                }, label: {
                                    
                                    
                                    LibrariesViewTile(title: "Self", image: "self_stk", stackCount: "\(list.ownStackCount)", pdfCount: "\(list.ownPDFCount)")
                                }).accentColor(.green)
                            }.padding(.top)
                            Spacer()
                        }
                    }
                }.onAppear{
                    list.getLibraryData()
                }
                
            }
        }
     
    }
}

struct LibrariesView_Previews: PreviewProvider {
    static var previews: some View {
        LibrariesView()
    }
}


struct LibrariesViewTile: View{
    @State var title: String
    @State var image: String
     var stackCount: String
     var pdfCount: String
    
    var body: some View{
        
        VStack(spacing:22){
            HStack{
                Image(image).resizable().frame(width: 100, height: 115)
                VStack(spacing:10){
                    Image("stack_gray")
                        .resizable()
                        .frame(width: 20, height: 25)
                    Image("pdf_gray")
                        .resizable()
                        .frame(width: 20, height: 25)
                }
                VStack(spacing:10){
                    Text(stackCount).font(.system(size: 22, weight: .semibold)).foregroundColor(Color(.black))
                    Text(pdfCount).font(.system(size: 20, weight: .semibold)).foregroundColor(.black)
                }

            }
            
          ZStack(alignment: .center){
                Color.gray.frame(height: 45)
              VStack(spacing:0){
                  Rectangle()
                      .frame(height: 2)
                      .foregroundColor(.black)
                  Spacer()
                  Text(title)
                      .font(.system(size: 20,weight: .bold))
                      .foregroundColor(.white)
                  Spacer()
              }
            }.frame(height: 45)
        }.background(Color("gray")).frame(width: UIScreen.main.bounds.width*0.47)
            .cornerRadius(12)
            .shadow(color: .gray,radius: 3)
        
    }
}


// MARK: - StudentLibraryModel
//struct StudentLibraryModel: Decodable{
//    var  school_pdf:Int
//    var  school_stack:Int
//    var  teacherBooks:Int
//    var  teacherStacks:Int
//    var  studentBooks:Int
//    var  studentStacks:Int
//    var  own_pdf: Int
//    var  own_stack: Int
//    var  success: String
//    var  data: Int
//}


// MARK: - GuestLibraryModel
struct GuestLibraryModel: Decodable{
    var  guestPDFCount :Int
    var  guestStackCount: Int
    var  ownPDFCount: Int
    var  ownStackCount: Int
    var  success: String
    var  data:Int
}


class GuestLibraryModelService{
    
    func getLibraryData(token: String, completion: @escaping (Result<GuestLibraryModel, NetworkError>) -> Void) {
        
        guard let url = URL(string: "\(APILoginUtility.guestLibraryApi)") else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(.noData))
                return
            }
            
            guard let response = try? JSONDecoder().decode(GuestLibraryModel.self, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            
            completion(.success(response))
            
        }.resume()
        
        
    }
}




//MARK: View model

class GuestLibraryViewModel: ObservableObject{
    
    @Published var guestPDFCount = Int() //= ()
    @Published var guestStackCount = Int() //= ()
    @Published var ownPDFCount = Int() //= ()
    @Published var ownStackCount = Int() //= ()
//    @Published var librariesCount: [Int] = []  //= ()
   
    func getLibraryData() {
        
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
        
        GuestLibraryModelService().getLibraryData(token: token){ (result) in
            switch result {
            case .success(let results):
                DispatchQueue.main.async {
                    self.guestPDFCount = results.guestPDFCount
                    self.guestStackCount = results.guestStackCount
                    self.ownPDFCount = results.ownPDFCount
                    self.ownStackCount = results.ownStackCount
//                    self.librariesCount[0] = results.guestStackCount
//                    self.librariesCount[1] = results.guestPDFCount
//                    self.librariesCount[2] = results.ownStackCount
//                    self.librariesCount[3] = results.ownPDFCount
                    print(self.guestPDFCount)

                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}





//VStack(spacing:22){
//    HStack{
//        Image("public_stack").resizable().frame(width: 100, height: 115)
//        VStack(spacing:10){
//            Image("stack_gray")
//                .resizable()
//                .frame(width: 20, height: 25)
//            Image("pdf_gray")
//                .resizable()
//                .frame(width: 20, height: 25)
//        }
//        VStack(spacing:10){
//            Text("\(list.guestStackCount)").font(.system(size: 22, weight: .semibold)).foregroundColor(Color(.black))
//            Text("\(list.guestPDFCount)").font(.system(size: 20, weight: .semibold)).foregroundColor(.black)
//        }
//
//    }
//
//  ZStack(alignment: .center){
//        Color.gray.frame(height: 45)
//      VStack(spacing:0){
//          Rectangle()
//              .frame(height: 2)
//              .foregroundColor(.black)
//          Spacer()
//          Text("Public")
//              .font(.system(size: 20,weight: .bold))
//              .foregroundColor(.white)
//          Spacer()
//      }
//    }.frame(height: 45)
//}.background(Color("gray")).frame(width: UIScreen.main.bounds.width*0.47)
//    .cornerRadius(12)
//    .shadow(color: .gray,radius: 3)
