//
//  SlideMenuView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 20/07/22.
//

import SwiftUI

struct MenuContentView: View {
    var body: some View {
        
        ScrollView(.vertical){
//            Spacer()
//                .frame(height:120)
            
        VStack (alignment: .center, spacing: 1){
            Image("").resizable().frame(width: 322, height: 150)
                .background(.gray)
                .ignoresSafeArea()
            
            Text("LOGIN")
                .frame(width:UIScreen.main.bounds.width-150,height:57)
                    .background(.blue.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(19)
                    
       
                .padding()
            Text("Home").onTapGesture {
                print("My Profile")
                   
            }
            .padding()
            Text("Explore Categories").onTapGesture {
                print("Posts")
            }
            .padding()
            Text("Plan").onTapGesture {
                print("Logout")
            }
            .padding()
            
            Text("Donate Pdf").onTapGesture {
                print("My Profile")
            }.padding()
            Text("Magazines").onTapGesture {
                print("Posts")
            }.padding()
            Text("Publishers").onTapGesture {
                print("Logout")
            }.padding()
            Divider()
                .frame(height:2)
                .background(Color.black)
            Group{
            Text("About Us").onTapGesture {
                print("My Profile")
            }.padding()
            Text("Contact Us").onTapGesture {
                print("Posts")
            }.padding()
            Text("Privacy and policy").onTapGesture {
                print("Logout")
            }.padding()
            Text("Terms and policy").onTapGesture {
                print("Logout")
            }.padding()
            Text("Privacy and policy").onTapGesture {
                print("Logout")
            }.padding()
                
                Text("Adolescence").onTapGesture {
                    print("Logout")
                }.padding()
                Text("DMCA").onTapGesture {
                    print("Logout")
                }.padding()
                Text("Copy Right").onTapGesture {
                    print("Logout")
                }
                Text("Subscribe").onTapGesture {
                    print("Logout")
                }.padding()
                    
                
            }
            
          
            
        }
        .padding(.vertical )
        .font(.title2)
        .frame(width: UIScreen.main.bounds.width-102, height:UIScreen.main.bounds.height)
        
        }
    }
}


struct SlideMenuView: View {
    @State var menuOpen: Bool = false
       
       var body: some View {
           ZStack {
               if !self.menuOpen {
                   Button(action: {
                       self.openMenu()
                   }, label: {
                       Text("Open")
                   })
               }
               
               SideMenu(width: 312,
                        isOpen: self.menuOpen,
                        menuClose: self.openMenu)
           }
       }
       
       func openMenu() {
           self.menuOpen.toggle()
       }
}


struct SlideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SlideMenuView()
    }
}
struct SideMenu: View {
    let width: CGFloat
    let isOpen: Bool
    let menuClose: () -> Void
    
    var body: some View {
        ZStack {
                    GeometryReader { _ in
                        EmptyView()
                    }
                    .background(Color.gray.opacity(0.3))
                    .opacity(self.isOpen ? 1.0 : 0.0)
                    .animation(Animation.easeIn.delay(0.25), value: 3)
                    .onTapGesture {
                        self.menuClose()
                    }
                    
                    HStack {
                        
                        MenuContentView()
                            .frame(width: self.width)
                            .background(Color.white)
                            .offset(x: self.isOpen ? 0 : -self.width)
                            .animation(.default, value: 1)
                        
                        Spacer()
                    }
                }
    }
}
