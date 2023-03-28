//
//  PDFKitView.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 20/03/23.
//

import SwiftUI
import PDFKit

struct PDFKitViews: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedItem: SheetItem?
    @State private var isAnimating = false
    @State var isOpenThumbnail: Bool = false
    @State var currentPage: Int = 1
    @State var id: Int = 17
    @State var searchView: Bool = false
    @State private var showSheet = false
    @StateObject var list = PreviewBooksViewModel()
    @State private var publisherSheet = false
    @State private var QRopen: Bool = false
    @State private var reportOpen: Bool = false
    var body: some View {
        ZStack{
            NavigationView{
                VStack {
                    
                    ZStack(alignment: .init(horizontal: .center, vertical: .center)) {
                        VStack{
                            HStack{
                                Button(action: {
                                    dismiss()
                                }, label: {
                                    
                                    Image(systemName: "chevron.left").font(.system(size: 28, weight: .bold)).foregroundColor(.gray)
                                })
                                Spacer()
                                
                                
                                Button(action: {
                                    self.searchView = true
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
                                    self.isOpenThumbnail = true //.toggle()
                                }, label: {
                                    
                                    Image("thumb_")//.resizable().frame(height: 25)
                                    
                                })
                                //                                })
                                
                                Button(action: {
                                    isAnimating.toggle()
                                }, label: {
                                    Image(isAnimating ? "zoomin" : "zoomout")//.resizable().frame(height: 25)
                                })
                                
                                
                            }.padding(.horizontal)
                            
                            
                            PDFViewWrapper(url: URL(string: "\(list.path)/\(currentPage).pdf")!, password: "alib_\(list.id)")
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                        HStack(alignment: .center){
                            Button(action: {
                                
                                self.currentPage -= 1
                            }, label: {
                                Image("previous")
                                    .resizable()
                                    .frame(width: 25, height: 122, alignment: .leading)
                                
                            }
                            )
                            .disabled(self.currentPage == 1)
                            
                            
                            Spacer()
                            
                            
                            if self.currentPage != list.pdfs+1{
                                Button(action: {
                                    withAnimation(.linear(duration: 0.4)) {
                                        self.currentPage += 1
                                    }
                                }, label: {
                                    Image("next")
                                        .resizable()
                                        .frame(width: 25, height: 122, alignment: .leading)
                                    
                                })
                                .disabled(self.currentPage == list.pdfs)
                            }
                        }
                        .frame(alignment: .leading )
                        
                    }
                    HStack{
                        Text(list.bookName)
                            .font(.system(size: 18, weight: .regular))
                            .foregroundColor(.black)
                        Spacer()
                        Button(action: {
                            showSheet = true
                        }, label: {
                            //                        BlinkingImage(blinkImage: "menu_icon")
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
                                
                                // Disable the Next button when the slider reaches the maximum limit
                                if self.currentPage == list.pdfs {
                                    self.isAnimating = true
                                } else {
                                    self.isAnimating = false
                                }
                            }
                        ), in: 0...Double((self.list.pdfs) + 1), step: 1.0)
                        
                        Text("\(self.currentPage)-\(self.currentPage+1)/\(list.pdfs)")
                            .foregroundColor(.gray)
                        
                    }
                    .padding()
                }.onAppear{
                    list.getBookData(id: self.id)
                }
                .sheet(isPresented: $showSheet) {
                    if #available(iOS 16.0, *) {
                        VStack(alignment: .leading){
                            Button(action: {
                                
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
                                    Text("Like").foregroundColor(.black).font(.system(size: 24))
                                    Spacer()
                                    
                                }
                            })
                            
                            Button(action: {
                                self.showSheet = false
                                reportOpen = true
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
                                QRopen = true
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
                                publisherSheet = true
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
            .navigationBarBackButtonHidden(true)
            NavigationLink(destination: //DashboardView()
                           LatestMagazineView(id: list.partner_id)
                .navigationTitle("")
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true), isActive: $publisherSheet){
                    EmptyView().navigationTitle("").navigationBarBackButtonHidden(true).navigationBarHidden(true)
                }.navigationTitle("")
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
            
            
            if self.searchView{
                SearchContentView(closebtn: $searchView)
            }
            BookThumbnailView(isOpenThumbnail: self.$isOpenThumbnail, currentPage: self.$currentPage, id: self.id)
                .frame(width: UIScreen.main.bounds.width)
                .background(Color.black.opacity(0.2))
                .offset(x: self.isOpenThumbnail ? 0 : 2*UIScreen.main.bounds.width)
                .animation(.linear(duration: 0.65))
            
            
            if QRopen{
                BookQRCodeView(open: $QRopen)
              }
            if reportOpen{
                
                BookReportView(comment: "", open: $reportOpen)
            }
            
        }

    }
}


struct PDFKitViews_Previews: PreviewProvider {
    static var previews: some View {
//        PDFKitViews1(id: 17)
        PDFKitViews(id: 22)
//        PDFKitViews2(id: 17)
    }
}


//MARK: Model

// MARK: - PreviewBooksModel
public struct PreviewBooksModel: Decodable {
    public let book: PreviewModel

}

// MARK: - Book
public struct PreviewModel: Decodable {
    public let id: Int
    public let name: String
    public let tot_pages: Int
    public let title: String
    public let author_name: String
    public let tot_likes: String?
    public let tot_view: Int?
    public let validity_date: String
    public let pdf_path: String
    public let published: String
    public let published_date: String
    public let partner_id: Int
    public let url: String
    public let protectedpdf: String
    public let demo: String
    public let thumbnail: String

}

class PreviewBooksViewModel: ObservableObject{

    @Published var path = String()
    @Published var totatPages = Int()
    @Published var bookName = String()
    @Published var pdfs:Int = Int()
    @Published var currentPage = 1
    @Published var id = 1
    @Published var partner_id = Int()
    
    @Published var pageUrl = String()
    @Published var thumbnail = String()
    
    func getBookData(id: Int) {

        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }

        AuthenticationPreviewBookService().getBookData(token: token, id: id){ (result) in
            switch result {
                case .success(let results):
                    DispatchQueue.main.async {
                        self.path = results.book.pdf_path
                        self.id = results.book.id
                        self.partner_id = results.book.partner_id
                        self.bookName = results.book.title
                        self.totatPages = results.book.tot_pages
                        self.thumbnail = results.book.thumbnail
                        self.pageUrl = "\(results.book.pdf_path)/\(self.currentPage).pdf"
                        if self.totatPages % 2 == 0 {
                            self.pdfs = (self.totatPages + 2) / 2
                        } else{
                            self.pdfs = (self.totatPages + 1)/2
                        }
                        
                        print("\(self.path)")
                        print("\(self.pdfs)")
                        
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }

    }
}



class AuthenticationPreviewBookService {
    func getBookData(token: String,id: Int, completion: @escaping (Result<PreviewBooksModel, NetworkError>) -> Void) {
            
        guard let url = URL(string: "\(APILoginUtility.preViewBooksApi)?id=\(id)") else {
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
            
            guard let response = try? JSONDecoder().decode(PreviewBooksModel.self, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            
            completion(.success(response))
            
        }.resume()
           
        }
    
}


// MARK: PDF Reader

struct PDFViewWrapper: UIViewRepresentable {
    typealias UIViewType = PDFView
    let url: URL
    let password: String
    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.autoScales = true
        pdfView.displayMode = .singlePageContinuous
        pdfView.displayDirection = .horizontal
    
        return pdfView
    }
    
    func updateUIView(_ uiView: PDFView, context: Context) {
        
        DispatchQueue.global(qos: .background).async {
            if let document = PDFDocument(url: url) {
//                document.unlock(withPassword: "alib_4") // Unlock the document here
                DispatchQueue.main.async {
                    uiView.document = document
                    document.unlock(withPassword: password)
                    DispatchQueue.main.async {
                        uiView.document = document

                               }
                }
//            } else {
//                print("Error loading PDF")
            }
        }
    }
}








struct PDFKitViews1: View {
//    @Environment(\.dismiss) var dismiss
    @State private var selectedItem: SheetItem?
    @State private var isAnimating = false
    @State var isOpenThumbnail: Bool = false
    @State var currentPage: Int = 1
    @State var id: Int// = 17
    @State var searchView: Bool = false
    @State private var showSheet = false
    @StateObject var list = PreviewBooksViewModel()

    var body: some View {
        ZStack{
            NavigationView{
                VStack {
                    
                    ZStack(alignment: .init(horizontal: .center, vertical: .center)) {
                        VStack{
                            HStack{
                                Button(action: {
//                                    dismiss()
                                }, label: {
                                    
                                    Image(systemName: "chevron.left").font(.system(size: 28, weight: .bold)).foregroundColor(.gray)
                                })
                                Spacer()
                                
                                
                                Button(action: {
                                    self.searchView = true
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
                                    self.isOpenThumbnail = true //.toggle()
                                }, label: {
                                    
                                    Image("thumb_")//.resizable().frame(height: 25)
                                                                        })
//                                })
                                
                                Button(action: {
                                    isAnimating.toggle()
                                }, label: {
                                    Image(isAnimating ? "zoomin" : "zoomout")//.resizable().frame(height: 25)
                                })
                                
                                
                            }.padding(.horizontal)
                           
                            
                            PDFViewWrapper(url: URL(string: "\(list.path)/\(currentPage).pdf")!, password: "alib_\(list.id)")
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                        HStack(alignment: .center){
                            Button(action: {
                                
                                self.currentPage -= 1
                            }, label: {
                                Image("previous")
                                    .resizable()
                                    .frame(width: 25, height: 122, alignment: .leading)
                                
                            }
                            )
                            .disabled(self.currentPage == 1)
                            
                            
                            Spacer()
                            
                            
                            if self.currentPage != list.pdfs+1{
                                Button(action: {
                                    withAnimation(.linear(duration: 0.4)) {
                                        self.currentPage += 1
                                    }
                                }, label: {
                                    Image("next")
                                        .resizable()
                                        .frame(width: 25, height: 122, alignment: .leading)
                                    
                                })
                                .disabled(self.currentPage == list.pdfs)
                            }
                        }
                        .frame(alignment: .leading )
                        
                    }
                    HStack{
                        Text(list.bookName)
                            .font(.system(size: 18, weight: .regular))
                            .foregroundColor(.black)
                        Spacer()
                        Button(action: {
                            showSheet = true
                        }, label: {
//                        BlinkingImage(blinkImage: "menu_icon")
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
                                
                                // Disable the Next button when the slider reaches the maximum limit
                                if self.currentPage == list.pdfs {
                                    self.isAnimating = true
                                } else {
                                    self.isAnimating = false
                                }
                            }
                        ), in: 0...Double((self.list.pdfs) + 1), step: 1.0)
                        
                        Text("\(self.currentPage)-\(self.currentPage+1)/\(list.pdfs)")
                            .foregroundColor(.gray)
                        
                    }
                    .padding()
                }.onAppear{
                    list.getBookData(id: self.id)
//                }.sheet(item: $selectedItem) { item in
//                    switch item {
//                    case .publisher:
//                        NavigationView {
//                            LatestMagazineView()
//                        }
//                    case .addStack:
//                        EmptyView()
//                    }
                }
                .sheet(isPresented: $showSheet) {
                    if #available(iOS 16.0, *) {
                        VStack(alignment: .leading){
                            Button(action: {
                                
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
                                    Text("Like").foregroundColor(.black).font(.system(size: 24))
                                    Spacer()
                                    
                                }
                            })
                            
                            Button(action: {
                                
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
                                selectedItem = .publisher
                                self.showSheet = false
                            }, label: {
                                HStack(spacing: 14){
                                    Image("publisher_icon").resizable().frame(width: 35,height: 35)
                                    NavigationLink(destination: {
                                        LatestMagazineView(id: 128)

                                    }, label: {
                                        Text("Publisher").foregroundColor(.black).font(.system(size: 24))
                                    })
                                   
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
                if self.searchView{
                    SearchContentView(closebtn: $searchView)
                }
            BookThumbnailView(isOpenThumbnail: self.$isOpenThumbnail, currentPage: self.$currentPage, id: self.id)
                .frame(width: UIScreen.main.bounds.width)
                .background(Color.black.opacity(0.2))
                .offset(x: self.isOpenThumbnail ? 0 : 2*UIScreen.main.bounds.width)
                .animation(.linear(duration: 0.65))
            
        }

    }
}


struct PDFKitViews2: View {
//    @Environment(\.dismiss) var dismiss
    @State private var selectedItem: SheetItem?
    @State private var isAnimating = false
    @State var isOpenThumbnail: Bool = false
    @State var currentPage: Int = 1
    @State var id: Int //= 17
    @State var searchView: Bool = false
    @State private var showSheet = false
    @StateObject var list = PreviewBooksViewModel()
var body: some View {
    NavigationView {
        ZStack{
            VStack {
                HStack{
                    Text(list.bookName)
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
            }
            .onAppear {
                list.getBookData(id: 17)
            }
            .sheet(item: $selectedItem) { item in
                switch item {
                case .publisher:
                    NavigationView {
                        LatestMagazineView(id: 128)
                    }
                case .addStack:
                    EmptyView()
                }
            }
            .sheet(isPresented: $showSheet) {
                if #available(iOS 16.0, *) {
                    VStack(alignment: .leading) {
                        Button(action: {
                        }, label: {
                            HStack(spacing: 14){
                                Image("qr_scanalib")
                                    .resizable()
                                    .frame(width: 35,height:35)
                                
                                Text("Add Stack")
                                    .foregroundColor(.black)
                                    .font(.system(size: 24))
                                
                                Spacer()
                            }
                        })
                        
                        Button(action: {
                            selectedItem = .publisher
                            self.showSheet = false
                        }, label: {
                            HStack(spacing: 14){
                                Image("publisher_icon")
                                    .resizable()
                                    .frame(width: 35,height: 35)
                                
                                Text("Publisher")
                                    .foregroundColor(.black)
                                    .font(.system(size: 24))
                                
                                Spacer()
                            }
                        })
                    }
                    .padding(.leading)
                    .presentationDetents([.fraction(0.35)])
                    .presentationDragIndicator(.hidden)
                } else {
                    // Fallback on earlier versions
                }
            }
        }
    }
}
}

enum SheetItem: Identifiable {
     
    case addStack
    case publisher
    var id: Self {
            self
        }
}
