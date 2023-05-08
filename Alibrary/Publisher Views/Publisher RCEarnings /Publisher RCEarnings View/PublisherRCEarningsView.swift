//
//  PublisherRCEarningsView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 24/09/23.
//

import SwiftUI

struct PublisherRCEarningsView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var list = PublisherRCEarningsViewModel()
    
    @State private var options = ["Select Month","January", "February", "March", "April", "May", "June", "July", "August", "September","October", "November","December"]
    //    @State private var years = ["Select Year","2020","2021", "2022", "2023", "2024"]
    @State private var selectedYear = 2023
    @State private var selectedMonth = "Select Month"
    var body: some View {
        
        ZStack{
            Image("u")
                .resizable()
                .ignoresSafeArea()
            
            VStack{
                HStack(spacing: 22){
                    Button(action: {
                        dismiss()
                    }, label: {
                        
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                            .font(.system(size: 32,weight: .bold))
                    })
                    Text("RC Earnings")
                        .font(.system(size: 32,weight: .bold))
                    Spacer()
                }.padding(.horizontal)
                
                
                HStack(spacing: 6){
                    HStack{
                        Image(systemName: "calendar")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.gray)
                        Button(action: {
                            
                        }, label: {
                            Picker("Select Month", selection: $selectedMonth) {
                                
                                ForEach(options, id: \.self){
                                    month in
                                    Text(String(describing: month)).tag(month)
                                        .font(.system(size: 32,weight: .bold))
                                }
                            }
                            .tint(.black)
                            .pickerStyle(.menu)
                            .border(.black)
                            
                        })
                    }.frame(width: UIScreen.main.bounds.width/1.8)
                    
                    HStack{
                        Image(systemName: "calendar").font(.system(size: 32, weight: .bold))
                            .foregroundColor(Color.gray)
                        Menu {
                            ForEach(list.years.indices, id: \.self) { index in
                                Button(String(describing: list.years[index])) {
                                    
                                    self.selectedYear = list.years[index]
                                    list.sel_year = "\(list.years[index])"
                                    print(list.sel_year)
                                    list.datas.removeAll()
                                    list.getRCEarningsData(currentPage: 1)
                                }
                            }
                        } label: {
                            Text(String(describing: selectedYear))
                                .foregroundColor(.black)
                                .font(.system(size: 22))
 
                        }
                        .padding(.horizontal)
                        .border(.black)
 
                    }.padding(.horizontal)
                }
                 Divider()
                    .background(Color.black)
                    .padding(.horizontal)
                ScrollView{
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]){
                        ForEach(list.datas, id: \.id){ item in
                            VStack(alignment: .leading, spacing: 2){
                                AsyncImage(url: URL(string: "\(item.book_url)")){ img in
                                    img
                                        .resizable()
                                        .frame(height: 235)
                                }placeholder: {
                                    Image("logo_gray")
                                        .resizable()
                                        .frame(height:235)
                                }
                                Text("\(item.book_name)")
                                    .lineLimit(1).truncationMode(.tail)
                                    .font(.system(size: 22,weight: .bold))
                                Text("Rc Count: ")
                                    .foregroundColor(Color.brown)
                                    .font(.system(size: 22,weight: .regular))
                                + Text("\(item.tot_rccount)")
                                    .font(.headline)
                                    .foregroundColor(Color("default_"))
                                
                                Text("Rc Value: ")
                                    .foregroundColor(Color.brown)
                                    .font(.system(size: 22,weight: .regular))
                                
                                + Text("\(item.tot_rcvalue) ")
                                    .font(.headline)
                                    .foregroundColor(Color("default_"))
                                
                            }
                            .padding(6)
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(color:.gray, radius: 8)
                        }
                        
                    }
                    .padding(.leading,4)
                    
                }
                Spacer()
                
            }
            
        }.onAppear{
            list.getRCEarningsData(currentPage: 1)
        }
        
    }
    
}

struct PublisherRCEarningsView_Previews: PreviewProvider {
    static var previews: some View {
        PublisherRCEarningsView()
    }
}
