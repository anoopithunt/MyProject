//
//  BookReportView.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 05/04/23.
//

import SwiftUI

struct BookReportView: View {
    @State var pageNo: String = "1"
    @State private var selectedOption: String?
    @State var comment: String
    @Binding var open: Bool
        let options = ["Sexual or Pornography", "Violent or Repulsive", "Hateful"]
    
    var body: some View {
        ZStack{
            Color.black.opacity(0.2).ignoresSafeArea()
            VStack(spacing: 15){
                HStack{
                    Image("ic_launcher").resizable().frame(width: 55, height: 55).cornerRadius(8)
                    Text("Inappropriate?").font(.system(size: 26,weight: .bold)).foregroundColor(.white)
                    Spacer()
                }.padding(.leading,6).padding(.vertical).background(.gray).frame(height: 75)
                VStack(alignment: .leading, spacing:20){
                    Text("If you're the legal owner of the copyright in this document(or authorized to act on behalf of the owner), please refer to our DMCA Guidelines.")
                    
                    Text("Otherwise, select your concern and we will determine if it violates our company Guidelines. Use this feature sparingly, as overuse is also a violation of our Community Guidelines. Thanks.")
                    
                    ForEach(options, id: \.self) { option in
                                  
                        HStack {
                            if selectedOption == option {
                                          
                                Image(systemName: "largecircle.fill.circle")
                                
                                    .font(.system(size: 20, weight: .bold))
                            }
                            else {
                                Image(systemName: "circle")
                                    .font(.system(size: 20, weight: .bold))
                            }

                                       Text(option).font(.system(size: 20, weight: .regular))

                                       Spacer()
                                   }
                                   .onTapGesture {
                                       selectedOption = option
                                   }
                               }
                    Text("On Page No. \(pageNo)").bold()
                   
                    TextField("Comment here", text: $comment)
                        .underlineTextField().foregroundColor(comment.isEmpty ?.gray : .black)
                    
                    HStack(spacing: 12){
                        Spacer()
                        Button(action: {
                            
                        }, label: {
                            Text("Report").font(.system(size: 20, weight: .bold))
                                .padding(.vertical,12)
                                .padding(.horizontal)
                                .foregroundColor(.white).background(Color.gray).cornerRadius(20)
                        })
                        Button(action: {
                            open = false
                        }, label: {
                            Text("Cancel").font(.system(size: 20, weight: .bold))
                                .padding(.vertical,12)
                                .padding(.horizontal)
                                .foregroundColor(.white).background(Color.gray).cornerRadius(20)
                        })
                    }.padding()
                    
                }.padding(.horizontal)
                
            }.background(.white).frame(width: UIScreen.main.bounds.width-25)
                .cornerRadius(12).shadow(radius: 3)
              
        }
        
    }
}

struct BookReportView_Previews: PreviewProvider {
    static var previews: some View {
        BookReportViewEx()
    }
}
struct BookReportViewEx: View{
    @State var comment: String = ""
    @State var open: Bool = true
    var body: some View{
        ZStack{
            Button(action: {
                self.open = true
            }, label: {
                Text("Open Report Dialogue").foregroundColor(.black)
            })
            if open{
                BookReportView(comment: comment, open: $open)
            }
        }
    }
}
