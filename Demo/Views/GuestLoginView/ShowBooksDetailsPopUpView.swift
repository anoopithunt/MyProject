//
//  ShowBooksDetailsPopUpView.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 14/02/23.
//

import SwiftUI

    struct ShowBooksDetailsPopUpView: View {
        @State var bookUrl: String = ""
        @State var long_desc: String = ""
        @State var title: String = "Title"
        @State var isbn_no: String = "9778078654272825"
    //    @State var bookName: String = "Hindi-English Billing Visual Dictionary"
        @Binding var isShown: Bool
        var body: some View {
            
            VStack(alignment: .leading) {
                VStack(spacing:45){
                    
                    ScrollView{
                        
                        Spacer()
                        AsyncImage(url: URL(string: "\(bookUrl)")){
                            image in
                            image.resizable()
                                .frame(width: UIScreen.main.bounds.width*0.5, height: 305, alignment: Alignment(horizontal: .center, vertical: .center))
                        }placeholder: {
                            Image("logo_gray").resizable()
                                .frame(width: UIScreen.main.bounds.width*0.5, height: 305, alignment: Alignment(horizontal: .center, vertical: .center))
                        }.padding().background(
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .fill(.white)
                                .overlay(RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.gray, lineWidth: 0.1))
                                .shadow(radius: 4)
                        )
                        Text("**\(title)**").font(.system(size: 22, weight: .heavy)).foregroundColor(.teal).textCase(.uppercase)
                        Text("**ISBN \(isbn_no)**").font(.system(size: 22, weight: .bold)).foregroundColor(.black).textCase(.uppercase)
    //                    Text("\(bookName)").font(.system(size: 18)).foregroundColor(.black)
                        Text("\(long_desc)").padding()
                        HStack{
                            Spacer()
                            Button(action: {
                                isShown.toggle()
                                
                            }, label: {
                                
                                Text("**OKay**").padding().padding(.horizontal).foregroundColor(.white).background(Color("default_")).cornerRadius(24)
                            })
                            
                        }.padding()
                    }
    //
                }.frame(width: UIScreen.main.bounds.width*0.9).background(Color.white).cornerRadius(22).padding()
    //            Spacer()
            }.padding().background(Color.black.opacity(0.4))
        }
    }

//struct ShowBooksDetailsPopUpView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        ShowBooksDetailsPopUpViewAlert()
//    }
//}


//struct ShowBooksDetailsPopUpViewAlert: View{
//    @State var isShown = true
//    var body: some View {
//        ShowBooksDetailsPopUpView( isShown: $isShown)
//    }
//}
//

struct ShowBooksDetailsView: View {
    @Environment(\.dismiss) var backbtn
    @State var bookTitle = String()
    @State var shown = false
    @State var title = String()
    @State var url = String()
    @State var isbn_no = String()
    @State var authorName = String()
    @State var long_desc = String()
    @State var published = String()
    @State var pages = String()
    @State var relatedBookUrl = [RelatedBooks]()
    @State var id:String
//    @Binding var originalIsActive: Bool
    var body: some View {
        ZStack {
            Image("u").resizable().background(Color.white).ignoresSafeArea()
          
         
            VStack(spacing: 5){
                HStack{
                    Button(action: {
                        backbtn()
                    }, label: {
                        Image(systemName: "chevron.left").foregroundColor(.black).font(.system(size: 34))
                    })
                   
                    Spacer()
                    Text(title).font(.headline).bold().multilineTextAlignment(.center)
                    Spacer()
                    Image(systemName: "square.and.arrow.up").resizable().frame(width: 25,height: 32)
                }.padding()
                
                ScrollView(.vertical,showsIndicators: false){
                   Button(action: {
                       shown.toggle()
                   }, label: {
                       AsyncImage(url: URL(string: url)){ image in
                           image.resizable().frame(width: 185, height: 242).shadow(radius: 12).cornerRadius(12).padding(.bottom, 25)
                       }placeholder: {
                           Image("logo_gray").resizable().frame(width: 185, height: 262).shadow(radius: 5).padding(.bottom, 35)
                       }
                   })
                 
                    
                    VStack(alignment: .leading,spacing: 12){
                        HStack(alignment: .firstTextBaseline,spacing: 35){
                            Text("Author").foregroundColor(.black.opacity(0.9)).font(.caption)
                            Spacer().frame(width: 35)
                            Text(authorName).foregroundColor(.gray.opacity(0.9)).font(.caption)
                            Spacer()
                        }.multilineTextAlignment(.center)
                        HStack(alignment: .firstTextBaseline,spacing: 35){
                            Text("Published").foregroundColor(.black.opacity(0.9)).font(.caption)
                            Spacer().frame(width: 18)
                            Text(published).foregroundColor(.gray.opacity(0.9)).font(.caption)
                        }.multilineTextAlignment(.center)
                        HStack(alignment: .firstTextBaseline,spacing: 35){
                            Text("Pages").foregroundColor(.black.opacity(0.9)).font(.caption)
                            Spacer().frame(width: 37)
                            Text("\(pages)").foregroundColor(.gray.opacity(0.9)).font(.caption)
                        }.multilineTextAlignment(.center)
                        
                    }.padding().frame(width: UIScreen.main.bounds.width*0.8).background(Color.white).border(.gray, width: 0.2).cornerRadius(5)
                        .shadow( radius: 1)
                    
                    HStack{
                        Text("Related Books").bold().foregroundColor(.black.opacity(0.7))
                        Spacer()
                    }.padding()

                    ScrollView(.horizontal,showsIndicators: false){
                        HStack{

                            
                            ForEach(relatedBookUrl, id: \.id) { books in
                                
                                
                                NavigationLink(destination: ShowBooksDetailsView(id: "\(books.id)").navigationTitle("")
                                    .navigationBarHidden(true)
                                    .navigationBarBackButtonHidden(true)){
                                        AsyncImage(url: URL(string: books.book_media.url)){ image in
                                            image.resizable().frame(width:185,height: 222).padding()
                                            
                                        }placeholder: {
                                            Image("logo_gray").resizable().frame(width: 195,height: 232).padding()
                                        }
                                        
                                    }
                            }
                        }
                        .padding(.horizontal)
                        
   
                       
                        Spacer(minLength: 45)
                    }
                }
            }
            VStack{
                Spacer()
                Text("Preview").foregroundColor(.white).frame(width: UIScreen.main.bounds.width-65, height: 55).background(Color.cyan).cornerRadius(24).overlay{ RoundedRectangle(cornerRadius: 24)
                    .stroke(.white, lineWidth: 1)}
            }
            if shown{
                ShowBooksDetailsPopUpView(bookUrl: url, long_desc: long_desc, title: bookTitle, isbn_no: isbn_no, isShown: $shown)
            }
        }.onAppear{
            
            getData(id: self.id)
        }
        
        
    }
    func getData(id: String) {
        guard let url = URL(string: "https://www.alibrary.in/api/show-book?id=\(id)") else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            if let data = data {
                do {
                    let results = try JSONDecoder().decode(ShowBookDetailsModel.self, from: data).bookDetails
                    let results1 = try JSONDecoder().decode(ShowBookDetailsModel.self, from: data).relatedBooks
                    
                    DispatchQueue.main.async {

                        self.title = results.title
                        self.authorName = results.author_name
                        self.published = results.published
                        self.long_desc = results.long_desc
                        self.pages = "\(results.tot_pages)"
                        self.url = results.book_media.bookurl
                        self.isbn_no = results.isbn_no
                        self.relatedBookUrl = results1
                       
                    }
                }
                catch {
                    print(error)
                }
            }
        }.resume()
    }
}

struct ShowBooksDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ShowBooksDetailsView( id: "1607")
       
    }
}






public struct ShowBookDetailsModel: Decodable {
    public let bookDetails: ShowBookDetailsData
    public let relatedBooks: [RelatedBooks]

}


public struct ShowBookDetailsData: Decodable {
    public let id: Int
    public let name: String
    public let tot_pages: Int
    public let title: String
    public let long_desc: String
    public let author_name: String
    public let category_name: String
    public let subcategory_name: String
    public let published: String
    public let isbn_no: String
    public let book_media:ShowBookDetailMedia

}



public struct ShowBookDetailMedia:Decodable,Hashable {
    public var id: Int
    public let book_id: Int
    public let bookurl: String
    enum CodingKeys: String, CodingKey{
        case id
        case book_id
        case bookurl = "url"
    }

}

public struct RelatedBooks: Decodable{
    public var id: Int
    public let  book_media: RelatedBooksMedia

}

public struct RelatedBooksMedia: Decodable, Hashable{
    public var id: Int
    public var url: String
}
