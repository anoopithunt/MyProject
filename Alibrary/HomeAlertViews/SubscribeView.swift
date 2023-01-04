//
//  SubscribeView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 09/11/22.
//

import SwiftUI

struct SubscribeAlertView: View {
    @State var shown = true

    var body: some View {
        ZStack {
                VStack {
                    Image("Anoop")
                        .resizable().frame(width: 300, height: 300).cornerRadius(200)
                    VStack {
                        Spacer()
                        Button("Subsribe Alert") {
                            shown.toggle()
                        }
                    }
                    Spacer()
                }

            
            if shown {
               SubscribeView(isShown: $shown)
            }
            
        }
    }
    
}

struct SubscribeAlert_Previews: PreviewProvider {
    static var previews: some View {
        SubscribeAlertView()
    }
}


struct SubscribeView: View {
    @Binding var isShown: Bool
    @State var text = ""
    let screenSize = UIScreen.main.bounds

    var body: some View {
        
        ZStack {
            Color(.black).opacity(0.4).frame(height: screenSize.height).ignoresSafeArea()
            VStack{
            HStack{
                Image("ic_launcher").resizable().frame(width: 55, height: 55).cornerRadius(16)
                Text("Subscribe").font(.system(size: 24)).bold().foregroundColor(.white).padding(.leading)
                Spacer()
            }.padding(.horizontal,12)
//                .padding(.leading)
                    .frame(width: UIScreen.main.bounds.width*0.94, height: 90).background(Color("orange"))
            Spacer()

                VStack(spacing: 35){
                    Spacer()
                   
                    CustomFloatingTextField(placeHolder: "EnterYour Email Id", rightImage: "person.crop.square.fill", text: $text).textContentType(.emailAddress)
                        .padding()
                   
                    HStack{
                        Spacer()
                        
                        Button(action: {
                            self.isShown = false
                            
                        }){
                            Text("Cancel").font(.headline)
                                .frame(width: 126, height: 45, alignment: .center)
                                .background(Color("default_"))
                                .foregroundColor(.white)
                                .cornerRadius(33)
                        }
                        .padding(.top,23)
                        
                        Button(action: {
//                            self.isShown = false
                            
                        }){
                            Text("Okay").font(.headline)
                                .frame(width: 126, height: 45, alignment: .center)
                                .background(Color("default_"))
                                .foregroundColor(.white)
                                .cornerRadius(33)
                        }.padding(.top,23)
                    }.padding(.horizontal,8)
                        .padding(.bottom)
                    
                }

            
            
            }
                .frame(width: screenSize.width * 0.9, height: screenSize.height/2.6)
                .background(Color("white").opacity(1))
                .clipShape(RoundedRectangle(cornerRadius: 4.0, style: .continuous))
                                        .animation(.spring(), value: isShown)
                                       

        }
            
            
        
       
    }
    
    
    
}

//struct SubscribeView_Previews: PreviewProvider {
//    static var previews: some View {
//        SubscribeView()
//    }
//}
