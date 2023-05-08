//
//  BookSuggestionView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 22/10/23.
//

import SwiftUI

struct BookSuggestionView: View {
    @StateObject var list = PublisherBookSuggestionViewModel()
   @FocusState private var isTextFieldFocused: Bool
   
   var body: some View {
       NavHeaderClosure(title: "Book Suggestion"){
       
           ZStack{
               Image("u").resizable().ignoresSafeArea()
               VStack{
                   TextField("search stacks", text: $list.searchText)
                       .font(.title)
                       .padding(4)
                       .padding(.trailing,26)
                       .foregroundColor(.gray)
                       .cornerRadius(8)
                       .focused($isTextFieldFocused)
                       .showClearButton($list.searchText)
                       .overlay(
                           RoundedRectangle(cornerRadius: 8)
                               .stroke(Color.red, lineWidth: 0.6)
                           
                       )
                       .frame(height: 55)
                  
                  
                       ScrollView{
                           if list.datas.isEmpty {
                                  Text("No results found")
                                      .foregroundColor(.white)
                                      .padding()
                           } else {
                           LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]){
                               ForEach(list.datas.filter { list.searchText.isEmpty ? true : $0.title.localizedCaseInsensitiveContains(list.searchText) }, id: \.title){item in
                                   
                                   
                                   VStack(alignment: .leading, spacing: 2){
                                       
                                       AsyncImage(url: URL(string: "\(item.book_url)")){
                                           img in
                                           img
                                               .resizable()
                                               .frame(height: 235)
                                       }placeholder: {
                                           Image("logo_gray")
                                               .resizable()
                                               .frame(height:235)
                                       }
                                       Text("\(item.title)")
                                           .lineLimit(1).truncationMode(.tail)
                                           .font(.system(size: 16))
                                       Text("By: \(item.uploaded_by) ")
                                           .foregroundColor(Color.brown)
                                           .font(.system(size: 13,weight: .regular))
                                       //
                                       Text("\(item.published) ")
                                           .foregroundColor(Color.brown)
                                           .font(.system(size: 14,weight: .regular))
                                       //
                                       
                                   }
                                   .padding(6)
                                   .background(Color.white)
                                   .cornerRadius(12)
                                   .shadow(color: .gray, radius: 2)
                               }
                               
//                                if list.currentPage < list.totalPage {
//                                    CircularProgressBar()
//                                        .frame(35)
//                                        .onAppear {
//                                            list.currentPage += 1
//                                            list.getBookSuggestionData(currentPage: list.currentPage)
//
//                                        }
//
//                                }
                               
                           }
                           .padding(.leading,4)
                           
                       }
                   }
               }
               
           }.onAppear{
               list.getBookSuggestionData(currentPage: 1)
           }
       }
       
   }
}
struct BookSuggestionView_Previews: PreviewProvider {
    static var previews: some View {
        BookSuggestionView()
    }
}
