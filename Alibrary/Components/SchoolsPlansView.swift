//
//  SchoolsPlansView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 16/11/22.
//

import SwiftUI

struct SchoolsPlansView: View{
    @StateObject var list = SchoolPlanViewModel()
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.1).ignoresSafeArea()
            VStack{
                Spacer()
                VStack {
                    Spacer(minLength: 80)
                    ScrollView(showsIndicators: false){
                        VStack{
                           
                            HStack(alignment: .center, spacing: nil) {
                                
                                ForEach(list.schoolPlanHeading, id: \.self){ heading in
                                    Text("**\(heading)**").font(.system(size: 22))
                                    
                                }.frame(maxWidth: UIScreen.main.bounds.width/3.1, alignment: .center)
    //                                .border(.gray, width: 2)

                            }
                            .padding()
                            
                            
                            ForEach(list.schoolPlanData, id: \.self) { array in
                                HStack(alignment: .center, spacing: nil) {
                                    
                                    ForEach(array, id: \.self){ item in
                                        switch item {
                                                               case .integer(let int):
                                            if int == 9999 {
                                                Image(systemName: "checkmark.circle.fill").foregroundColor(Color("green")).font(.system(size: 28))
                                                                                             
                                                                                          }
                                        else if int == 0{
                                            Image(systemName: "multiply.circle.fill").foregroundColor(.red.opacity(0.8)).font(.system(size: 28))
                                                                        }
                                            
                                            else{
                                                Text("\(int)").font(.system(size: 24))
                                            }
    //
                                                               case .string(let str): Text(str).font(.system(size: 18))
                                                               }
                                        
                                    }.frame(maxWidth: UIScreen.main.bounds.width/3.1, alignment: .center)
                                    //                                .border(.gray, width: 2)
                                    
                                }
                                .padding()
                            }
                            
                       
                        }
                        .frame(width: UIScreen.main.bounds.width*0.95).background(Color.white).border(.gray, width: 0.2).cornerRadius(12)
                        Text("**Read credit upgrade**\nReading Prime Books or Prime Magazines will cost 1 Read Credit(RC) by dafault. In case of full consumption of Read Credits(RC) during Prome Membership, Readers are requested to top up by purchasing Read Credits(RC) as per their reading habit.")
                    }
                    .padding(1)
                }
                
                Button(action: {
                    
                    
                }, label: {
                    Text("**Purchase Now**").font(.system(size: 26)).foregroundColor(.white).frame(width: UIScreen.main.bounds.width*0.8, height: 66).background(Color("green")).cornerRadius(28)
//
                }).overlay(
                    RoundedRectangle(cornerRadius: 38)
                        .stroke(Color.white, lineWidth: 3)
                )
                Spacer(minLength: 44)
            }
        }.task {
            await list.getData()
        }
        
        
    }
}

struct SchoolsPlansView_Previews: PreviewProvider {
    static var previews: some View {
        SchoolsPlansView()
    }
}
