//
//  ShowBooksDetailsView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 16/11/22.
//

import SwiftUI
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
        ShowBooksDetailsView( id: "201")
       
    }
}
