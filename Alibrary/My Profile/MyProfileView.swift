//
//  MyProfileView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 23/08/22.
//

import SwiftUI

struct MyProfileView: View {
    @State var name:String = "Anup Mishra"
    @State var mobile:String = "82********"
    @State var address:String = "Kunda Pratapgarh"
    var body: some View {
        ZStack {

            
            VStack(spacing:0){
                
                CustomNavBarView()
                Image("8")
                    .resizable()
                .frame(width: UIScreen.main.bounds.width, height: 233)
                .padding(.bottom)
               
                    VStack(alignment: .center, spacing: 15){
                    Text("Anup Mishra")
                        .foregroundColor(.gray)
                        .bold()
                        .textCase(.uppercase)
                        .font(.system(size: 25))
    //                Spacer()
                    Text("anoopmishrapitz@gmail.\("com")")
                        
                        .textCase(.lowercase)
                        .foregroundColor(.orange)
                        .padding(.vertical,1)
                
                        
                        
                        
                        
                        HStack{
                            VStack(alignment: .leading) {
                                            Section {
                                                
                                                Text("Full Name:")
                                                    .font(.system(size: 18))
                                                    .bold()
                                                    .multilineTextAlignment(.leading)
                                                  .foregroundColor(.gray)
                                                Text("Mobile:")
                                                    .font(.system(size: 18))
                                                    .bold()
                                                    .multilineTextAlignment(.leading)
                                                    .foregroundColor(.gray)
                                                Text("Address:")
                                                    .font(.system(size: 18)) .bold()
                                                    .multilineTextAlignment(.leading)
                                                    .foregroundColor(.gray)
                                            }
                                            .padding(.bottom)
                                        }
                                        .padding()
               Spacer()

                            VStack(alignment: .leading) {
                                            Section {
                                                Text(name)
                                                    .multilineTextAlignment(.leading)
                                                    .padding(.trailing,1)
                                                    
                                                    .foregroundColor(.black)
                                               Text(mobile)
                                                    .multilineTextAlignment(.leading)
                                                    .padding(.trailing,1)
                                                    
                                                    .foregroundColor(.black)
                                                Text(address)
                                                    .multilineTextAlignment(.leading)
                                                    .padding(.trailing,1)
                                                    
                                                    .foregroundColor(.black)
                                            }
                                            .padding(.bottom)
                                        }
                            .padding(.trailing)
                            
                        }

                }
                .padding(.top,50)
                .frame(width: UIScreen.main.bounds.width-32, alignment: .center)
                .background(Color.white)
                .cornerRadius(18)
            .shadow(color: Color.gray, radius: 1/2, x: 0, y: 0)
                
                Image("3")
                    .resizable()
                    .frame(width: 110, height: 110)
                    .cornerRadius(70)
                    .padding(.top, -370)
            Spacer()
            }
           
                
            
           
    }
        .background(Image("u")
            .resizable()
            .background(Color.white)
            
            .ignoresSafeArea())
        
       
    }
}

struct MyProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MyProfileView()
    }
}
