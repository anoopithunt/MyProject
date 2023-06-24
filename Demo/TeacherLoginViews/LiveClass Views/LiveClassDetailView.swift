//
//  LiveClassDetailView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 14/11/23.
//

import SwiftUI

struct LiveClassDetailView: View {
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy"
        formatter.locale = Locale.current
        return formatter
    }()
    @State var date:String = "08 Nov 2023 10:15 AM"
    @State var subject:String = "English"
    @State var nextLive:String = "NEXT- MATH 11:20 AM"
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationView{
            ZStack{
                Image("u")
                    .resizable()
                    .ignoresSafeArea()
        
                VStack(alignment: .leading, spacing:0){
                    HStack(spacing: 25) {
                        Button(action: {
                            dismiss()
                        }, label: {
                            Image(systemName: "arrow.backward")
                                .font(.system(size: 22, weight: .heavy))
                                .foregroundColor(.white)
                        })
                        
                        Text("Live Class")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(.white)
                        
                        Spacer()
                        Text("EXPIRED")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal)
                    .frame(width: UIScreen.main.bounds.width, height: 65)
                    .background(Color("orange"))
                    
                    ScrollView(showsIndicators: false){
                        Image("online_class").resizable()
                            .frame(height: 245)
                            .shadow(radius:6)
                        
                        VStack(alignment: .leading){
                            HStack{
                                Text("\(dateFormatter.string(from: Date()))"  + " 10:15 AM")
                                    .font(.system(size: 20, weight: .regular))
                                    .padding(.vertical)
                                
                                Spacer()
                                
                                NavigationLink(destination: {
                                    
                                }, label: {
                                    HStack{
                                        Image("coureses_gray")
                                            .resizable()
                                            .frame(width: 22, height: 30)
                                            .padding(2)
                                        
                                        Text("Course")
                                            .foregroundColor(Color("default_"))
                                            .font(.system(size: 22, weight: .medium))
                                        
                                    }
                                    .padding(8)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 22)
                                            .stroke(Color("default_"), lineWidth: 2)
                                    )
                                })
                                
                            }
                            .padding([.horizontal, .top])
                            
                            Text("Subject Details")
                                .font(.system(size: 22,weight: .regular))
                                .padding(.leading, 9)
                            
                            Text(subject)
                                .font(.system(size: 22,weight: .regular))
                                .padding(.leading, 9)
                            
                            HStack{
                                Text("Q N A")
                                    .foregroundColor(Color("default_"))
                                    .font(.system(size: 22, weight: .bold))
                                Spacer()
                                
                                Button(action: {
                                    
                                }, label: {
                                    Text("Live")
                                        .font(.system(size: 22, weight: .bold))
                                        .foregroundColor(.white)
                                        .padding(.horizontal)
                                        .padding(8)
                                        .background(Color("green"))
                                        .cornerRadius(18)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 32)
                                                .stroke(Color.white, lineWidth: 3)
                                        )
                                })
                                
                            }.padding(.horizontal)
                            
                            HStack{
                                Spacer()
                                
                                Image(systemName: "circle.inset.filled")
                                    .resizable()
                                    .frame(width: 235, height: 235)
                                    .padding()
                                    .foregroundColor(.black)
                                    .overlay{
                                        Text("00")
                                            .font(.system(size: 65, weight: .bold))
                                            .foregroundColor(.white)
                                    }
                                Spacer()
                            }.padding()
                        }
                        
                    }
                    
                    Color.blue
                        .frame(height
                               :35)
                        .overlay{
                            Text(nextLive)
                                .foregroundColor(.white)
                                .font(.system(size: 25, weight: .bold))
                        }
                    
                }
                
            }
            
        }
        
    }
}

struct LiveClassDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LiveClassDetailView()
    }
}


 
