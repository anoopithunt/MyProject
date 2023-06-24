//
//  PreviewBookView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 08/08/23.
//

import SwiftUI 

struct PreviewBookView: View {
    @State var currentPage: Int = 0
    @State private var showSheet = false
    @State private var isAnimating = false
    @StateObject var list = StudentPreviewBookViewModel()
    var body: some View {
        VStack{ 
            
            HStack{
                Button(action: {
//                    dismiss()
                }, label: {
                    
                    Image(systemName: "chevron.left").font(.system(size: 28, weight: .bold)).foregroundColor(.gray)
                })
                Spacer()
                
                
                Button(action: {
//                    self.searchView = true
                }, label: {
                    Image("magnifire_glass")//.resizable()//.frame(height: 25)
                })
                
                Button(action: {
                    
                }, label: {
                    Image("qr_scanalib")
                        .resizable()
                        .frame(width: 55,height:55)
                })
                Button(action: {
//                    self.isOpenThumbnail = true //.toggle()
                }, label: {
                    
                    Image("thumb_")//.resizable().frame(height: 25)
                    
                })
                //                                })
                
                Button(action: {
//                    isAnimating.toggle()
                }, label: {
                    Image(isAnimating ? "zoomin" : "zoomout")//.resizable().frame(height: 25)
                })
                
                
            }.padding(.horizontal)
            
            PDFViewWrapper(url: URL(string: "\(list.path)\(self.currentPage + 1).pdf")!, password: "alib_\(list.id)")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
             
            HStack{
                Text(list.name)
                    .font(.system(size: 18, weight: .regular))
                    .foregroundColor(.black)
                Spacer()
                Button(action: {
                    showSheet = true
                }, label: {
                    Image("menu_icon")
                        .resizable()
                        .frame(width: 45,height: 45)
                })
                
            }
            .padding(.horizontal)
            
            HStack{
                Slider(value: Binding<Double>(
                    get: { Double(self.currentPage) },
                    set: {
                        self.currentPage = Int($0)
//                        Disable the Next button when the slider reaches the maximum limit
                        if self.currentPage == list.total {
//                            self.isAnimating = true
                        } else {
//                            self.isAnimating = false
                        }
                    }
                ), in: 0 ... Double((list.total) + 1), step: 1.0)
                
                Text("\(self.currentPage)-\(self.currentPage+1)/\(list.total)")
                    .foregroundColor(.gray)
                
            }
            .padding()
            
            
        }.onAppear{
            list.getPreviewBookData(subjectId: 3871)
        }
        .overlay(alignment: .center){
            
            HStack(alignment: .center){
                if self.currentPage != 0 {
                    Button(action: {
                        
                        self.currentPage -= 1
                    }, label: {
                        Image("previous")
                            .resizable()
                            .frame(width: 25, height: 122, alignment: .leading)
                        
                    }).disabled(self.currentPage <= 0)
                    
                }
                Spacer()
                
                if self.currentPage != list.total+1{
                    Button(action: {
                        withAnimation(.linear(duration: 0.4)) {
                            self.currentPage += 1
                        }
                    }, label: {
                        Image("next")
                            .resizable()
                            .frame(width: 25, height: 122, alignment: .leading)
                        
                    }).disabled(self.currentPage >= list.total)
                }
            }
            .frame(alignment: .leading )
        }
        .sheet(isPresented: $showSheet) {
            if #available(iOS 16.0, *) {
                VStack(alignment: .leading){
                    Button(action: {
                        self.showSheet = false
                    }, label: {
                        HStack(spacing: 14){
                            Image("qr_scanalib").resizable().frame(width: 35,height:35)
                            
                            Text("Add Stack")
                                .foregroundColor(.black)
                                .font(.system(size: 24))
                            Spacer()
                        }
                    })
                    
                    Button(action: {
                        
                    }, label: {
                        HStack(spacing: 14){
                            Image("like").resizable()
                                .frame(width: 35,height: 35)
                            Text("Like").foregroundColor(.black)
                                .font(.system(size: 24))
                            Spacer()
                            
                        }
                    })
                    
                    Button(action: {
                        self.showSheet = false
//                        reportOpen = true
                    }, label: {
                        HStack(spacing: 14){
                            Image("bookre").resizable().frame(width: 35,height: 35)
                            Text("Report")
                                .foregroundColor(.black)
                                .font(.system(size: 24))
                            Spacer()
                        }
                    })
                    
                    Button(action: {
//                        QRopen = true
                        self.showSheet = false
                    }, label: {
                        HStack(spacing: 14){
                            Image("qr_scanalib").resizable().frame(width: 35,height:35)
                            Text("QR Code")
                                .foregroundColor(.black)
                                .font(.system(size: 24))
                            Spacer()
                            
                        }
                    })
                    
                    Button(action: {
//                        publisherSheet = true
                        self.showSheet = false
                    }, label: {
                        HStack(spacing: 14){
                            Image("publisher_icon").resizable().frame(width: 35,height: 35)
                            
                            Text("Publisher").foregroundColor(.black).font(.system(size: 24))
                            //                                    })
                            
                            Spacer()
                        }
                    })
                    
                    
                }.padding(.leading).presentationDetents([.fraction(0.35)])
                    .presentationDragIndicator(.hidden)
            } else {
                // Fallback on earlier versions
            }
        }
    }
}

struct PreviewBookView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewBookView()
    }
}

 
// MARK: - Model


// MARK: - PreviewBookModel
public struct PreviewBookModel:Decodable {
    public let book_details: PreviewBookDetails


}

// MARK: - PreviewBookBookDetails
public struct PreviewBookDetails:Decodable {
    public let id: Int
    public let name: String
    public let tot_pages: Int
    public let isbn_no: String
    public let size: String
    public let protectedpdf: String
    public let demo: String
    public let thumbnail: String
    public let book_media: PreviewBookMedia
    public let demo_book_page: PreviewBookDemoPage
    public let partner_name: PreviewBookPartnerName
//    public let book_likes: [Any?]
//    public let partner_book_likes: NSNull
//    public let book_review: NSNull
    public let book_partner_link: PreviewBookPartnerLink
 
}





// MARK: - PreviewBookMedia
public struct PreviewBookMedia:Decodable {
    public let id: Int
    public let book_media_type_id: Int
    public let media_type_id: Int
    public let book_id: Int
    public let url: String

  
}

// MARK: - PreviewBookPartnerLink
public struct PreviewBookPartnerLink:Decodable  {
    public let id: Int
    public let partner_id: Int
    public let book_id: Int

     
}

// MARK: - DemoBookPage
public struct PreviewBookDemoPage:Decodable  {
    public let id: Int
    public let book_id: Int
    public let page_from: Int
    public let page_to: Int
    public let url: String
    public let created_by: Int
 
}

// MARK: - PreviewBookPartnerName
public struct PreviewBookPartnerName:Decodable  {
    public let id: Int
    public let role_id: Int
    public let full_name: String
    public let dob: String
    public let qr_code_url: String
    public let referal_code: String
    public let partner_role: PreviewBookPartnerRole
 
}

// MARK: - PreviewBookPartnerRole
public struct PreviewBookPartnerRole:Decodable  {
    public let id: Int
    public let name: String
    public let guard_name: String
 
}


//MARK: ViewModel
// MARK: Api https://alibrary.in/api/student/preview-book?book_id=3871

class  StudentPreviewBookViewModel: ObservableObject {
    @Published var id = Int()
    @Published var total = Int()
    @Published var name = String()
    @Published var path = String()
    @Published var currentPage:Int = 1
    func getPreviewBookData(subjectId: Int) {

//        let apiurl = APILoginUtility.studentExamTestApi
        guard let url = URL(string: "https://alibrary.in/api/student/preview-book?book_id=\(subjectId)") else {
            // handle invalid URL error
            print("This is incorrect API URL...")
            return
        }
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
        let service = HTTPLoginUtility()

        service.getLoginData(from: url, model: PreviewBookModel.self, token: token){ (result) in
            switch result {
            case .success(let results):
                DispatchQueue.main.async {
//                    self.datas = results.book_details
                    self.id = results.book_details.id
                    self.name = results.book_details.name
                   
                    self.path = results.book_details.protectedpdf
                    self.total = results.book_details.tot_pages
                    
                    print(results)
                }
            case .failure(let error):
                print(error.localizedDescription)

            }

        }

    }

}


 
