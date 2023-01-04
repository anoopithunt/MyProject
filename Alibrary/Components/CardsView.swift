//
//  CardsView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 09/07/22.
//

import SwiftUI

struct CardsView: View {
    var body: some View {
        NavigationView{
//            Color.gray
//                .ignoresSafeArea()
            
            ZStack {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                
                    .toolbar{
                        ToolbarItem( placement: .navigationBarTrailing){
                            Menu {
                                Button(action: {}, label: {
                                    Label( title: { Text("Categories")},
                                           icon: {Image(systemName: "tray.fill")})
                                    
                                    
                                })
                                
                                
                                Button(action: {}, label: {
                                    Label( title: { Text("Donate")},
                                           icon: {Image(systemName: "indianrupeesign.square.fill")})
                                    
                                })
                                
                                
                                Button(action: {}, label: {
                                    
                                    Label( title: { Text("Home")},
                                           icon: {Image(systemName: "house.fill")})
                                    
                                })
                                
                                
                                
                                Button(action: {}, label: {
                                    
                                    Label( title: { Text("Registration")},
                                           icon: {Image(systemName: "tray.fill")})
                                    
                                })
                                
                                
                                Button(action: {}, label: {
                                    
                                    Label( title: {  Text("Contact Us")},
                                           icon: {Image(systemName: "phone.fill")})
                                   
                                })
                                
                            } label: {
                                Label(title: {Text("Login")}, icon: {
                                    Image(systemName: "plus")
                                })
                            }
                        }
                }
            }
            
        }
       
    }
}

struct CardsView_Previews: PreviewProvider {
    static var previews: some View {
        CardsView()
    }
}
