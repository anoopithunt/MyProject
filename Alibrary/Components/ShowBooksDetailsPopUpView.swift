//
//  ShowBooksDetailsPopUpView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 29/11/22.
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
                            .frame(width: UIScreen.main.bounds.width*0.6, height: 365, alignment: Alignment(horizontal: .center, vertical: .center))
                    }placeholder: {
                        Image("logo_gray").resizable()
                            .frame(width: UIScreen.main.bounds.width*0.6, height: 365, alignment: Alignment(horizontal: .center, vertical: .center))
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

struct ShowBooksDetailsPopUpView_Previews: PreviewProvider {
//    @State var isShown = true
    static var previews: some View {
        ShowBooksDetailsPopUpViewAlert()
    }
}
struct ShowBooksDetailsPopUpViewAlert: View{
    @State var isShown = true
    var body: some View {
        ShowBooksDetailsPopUpView( isShown: $isShown)
    }
}
