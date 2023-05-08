//
//  PublisherTotalBooksUploadView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 24/09/23.
//

import SwiftUI

struct PublisherTotalBooksUploadView: View {
    @State var fdate = Date()
    @State var fdate1:Date?

    @State private var tdate = Date()
    @State  var currentPage:Int = 1
    @StateObject var list = PublisherTotalUploadBookViewModel()
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        ZStack{
            Image("u").resizable().ignoresSafeArea()
            VStack{
                HStack(spacing: 12){
                    Button(action: {
                        dismiss()
                    }, label: {
                        
                        Image(systemName: "chevron.left")
                            .resizable().foregroundColor(.black)
                            .frame(width: 20, height: 28)
                    })
                    Text("Monthly Total Books Upload")
                        .font(.system(size: 24, weight: .medium))
                    
                    Spacer()
                }.padding(.horizontal)
                
                
                HStack{
                    DatePicker("From Date", selection: $fdate,displayedComponents: [.date])
                    //                        .labelsHidden()
                        .datePickerStyle(.compact)
                        .foregroundColor(.black)
                        .onChange(of: fdate) {newDate in
                            list.fromDate = "\(DateFormatter.displayDate.string(from: fdate))"
                            list.currentPage = 1
                            list.datas.removeAll()
                            list.getTotalBookUploadData(currentPage: 1)
                            print("\(DateFormatter.displayDate.string(from: fdate))" )
                        }
                    
                    Spacer()
                    
                    DatePicker("To Date", selection: $tdate,displayedComponents: [.date]).datePickerStyle(.compact)
//                        .labelsHidden()
                        .foregroundColor(.black)
                        .onChange(of: tdate) {newDate in
                            list.toDate = "\(DateFormatter.displayDate.string(from: tdate))"
                            list.currentPage = 1
                            list.datas.removeAll()
                            list.getTotalBookUploadData(currentPage: 1)
                            print("\(DateFormatter.displayDate.string(from: fdate))" )
                        }
                    
                    
                }.padding(2)
                
                
                Divider()
                    .frame(height:1)
                    .background(Color.gray)
                    .padding(.horizontal,4)
                Spacer()
                
                ScrollView{
                    LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible())]){
                        
                        ForEach(list.datas,id: \.id){ item in
                            VStack(spacing: 4){
                                AsyncImage(url: URL(string: item.url ?? "")){
                                    img in
                                    img.resizable().frame(width:175, height:195)
                                }placeholder: {
                                    Image("logo_gray")
                                        .resizable()
                                        .frame(width:175, height: 175)
                                }
                                Divider().foregroundColor(Color.red)
                                VStack(alignment:.leading){
                                    Text(item.name).lineLimit(1)
                                    HStack{
                                        Text("\(item.category_name)")
                                        Spacer()
                                        Text("\(item.subcategory_name)")
                                        
                                    }
                                    HStack{
                                        Text("Published: ")
                                            .foregroundColor(.brown)
                                            .lineLimit(1)
                                        Spacer()
                                        Text("\(item.published ?? "")")
                                    }
                                }
                            }.padding(6).background(Color.white)
                                .cornerRadius(12)
                                .shadow(color: .gray, radius: 2).padding(6)
                        }
                        //                        if self.currentPage <= list.totalPage {
                        //                            CircularProgressBar().frame(35).onAppear{
                        //
                        //                            }
                        //                        }
                        
                        if list.currentPage < list.totalPage {
                            CircularProgressView()
                                .frame(width: 35, height: 35)
                                .onAppear {
                                    list.currentPage += 1
                                    list.getTotalBookUploadData(currentPage: list.currentPage)
                                }
                        }
                    }
                }
            }
        }.onAppear{
            list.getTotalBookUploadData(currentPage: 1)
            
        }
    }
}

extension DateFormatter {
    static let displayDate: DateFormatter = {
         let formatter = DateFormatter()
         formatter.dateFormat = "dd-MM-yyyy"
         return formatter
    }()
}

struct PublisherTotalBooksUploadView_Previews: PreviewProvider {
    static var previews: some View {
        PublisherTotalBooksUploadView()
    }
}
