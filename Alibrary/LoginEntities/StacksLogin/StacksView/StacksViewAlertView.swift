//
//  StacksViewAlertView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 15/02/23.
//

import SwiftUI

struct StacksViewAlertView: View{
    @State private var selected = 0
    let labels = ["Public", "Private"]
    @State var pressed: Bool = false
    @Binding var rcShow: Bool
   @State private var isEditing = false
    let screenSize = UIScreen.main.bounds
    @State var text: String = ""
    @State var rupee: String = ""
    @State var selectedOption: String = ""
    
    var body: some View{
        ZStack {
            Color.black.opacity(0.5).ignoresSafeArea()
            VStack(alignment: .leading){
            HStack{
                Image("ic_launcher").resizable().frame(width: 55, height: 55).cornerRadius(12)
                Text("New Stack").font(.system(size: 22)).bold().foregroundColor(.white).padding(.leading)
                Spacer()
            }.padding()
                .padding(.leading)
                .frame(width: UIScreen.main.bounds.width*0.94, height: 90).background(Color("orange"))
           
                VStack (alignment: .leading){
                    CustomTextField(placeHolder: "Enter the Name", text: $text).padding(6)
                  
                    CustomTextField(placeHolder: "Enter the Description", text: $rupee).padding(6)
                   
                    Text("Make your stack").foregroundColor(.black).font(.system(size:22)).padding(.leading)
                    VStack(alignment: .leading){
                        HStack(spacing: 2) {
                            ForEach(0..<labels.count) { index in
                                RadioButton(selected: self.$selected, index: index, label: self.labels[index])
                            }
                        }.padding()
                        if selected == 1 {
                 
                                Button(action: {
                                    pressed.toggle()
                                }, label: {
                                    HStack{
                                        Image(systemName: !pressed ? "square" : "checkmark.square.fill")//.padding()
                                            .font(.system(size: 28))
                                            .foregroundColor(.black)
                                        Text("**I Agree**")
                                            .multilineTextAlignment(.leading).foregroundColor(.black)//.bold()
                                    }.padding(.leading,4)
                                })
                              
                            Text("Dear User,please note that if you have fully organized your stack and all book content placed in it matches your title according to you, You may allow it to be publicly placed in the public media. Please note that if the content you put in this type does not match your original title,then the library may block it and unnecessarily cancle your stack as aviolation.\nNote: Books placed in the stack will not appear in the public stack if the number is less than 3.").font(.system(size: 14)).foregroundColor(.black).padding(.leading, 38)
           
                        }
                    }
                    HStack(alignment: .top){
                        Spacer()
                        Button(action: {
                                            self.rcShow = false
                            
                        }){
                            Text("Cancel").font(.headline)
                                .frame(width: 116, height: 45, alignment: .center)
                                .background(Color("default_"))
                                .foregroundColor(.white)
                                .cornerRadius(33)
                        }//.padding(12)
                        Button(action: {
                                           
                            
                        }){
                            Text("Create").font(.headline)
                                .frame(width: 116, height: 45, alignment: .center)
                                .background(self.pressed ? Color("default_") : Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(33)
                        }
                    }.padding(.trailing)
                    
                    
               
                }.padding(4)
            
            
        }
            .frame(width: screenSize.width * 0.9, height: .infinity)
                .background(Color.white.opacity(1))
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                                        .animation(.spring(), value: rcShow)

        }
       
    }
    }
