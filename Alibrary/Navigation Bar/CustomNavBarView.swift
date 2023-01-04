//
//  CustomNavBarView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 04/07/22.
//

import SwiftUI

struct CustomNavBarView: View {


    @State private var showMenu: Bool = false
  
    @State private var selected: SelectedScreen = .home
    
    enum SwipeHorizontalDirection: String {
          case left, right, none
      }

      @State var swipeHorizontalDirection: SwipeHorizontalDirection = .none { didSet { print(swipeHorizontalDirection) } }
    
    
    var body: some View {
        HStack{
            Button(action: {
                
                
                
                
                
            }, label: {
                Image(systemName: "line.3.horizontal")
                    .font(.title).frame(width: 40,height: 65)
                    .frame(alignment: .leading)
                    .foregroundColor(.white)
                    
            })
          
           
            
            Button(action: {
                
            }, label: {
            
            
            ZStack {

                HStack {
                 
                    Image(systemName: "magnifyingglass").foregroundColor(.gray).font(.body).frame(width: 30,height: 35)
              
                    Text("search books..").foregroundColor(.gray)
                    Spacer()
                           
                }.frame(width: UIScreen.main.bounds.width*0.5)
                        .padding(.leading, 7)
                    }
                        .frame(height: 40)
                        .background()
                        .cornerRadius(8)
            })
            Spacer()
            Button(action: {
                
                
                
                
                
            }, label: {
                Image("qr_c").resizable()
                    .frame(width: 30, height: 30)
                    
            })
            //for 3 dot vertical point
            Spacer()
            Button(action: {
                
            }, label: {
                Image(systemName: "ellipsis")
                    .foregroundColor(.white)
                    .font(.system(size: 33))
                    .rotationEffect(.degrees(-90))
                    .frame(width: 11, height: 55, alignment: .center)
                    .padding()
                    
            })
        }.padding(10)

        .frame( width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height*0.06)
        
        .font(.headline)
        .background(Color.orange)
    }
}

struct CustomNavBarView_Previews: PreviewProvider {
    static var previews: some View {
//        VStack {
//            CustomNavBarView()
//            Spacer()
            
            MainHomePageView()
//        }
        
    }
}


extension CustomNavBarView {
   
    private var menuButton: some View {
        Button(action: {
            
            
            self.showMenu = true
            
            
        }, label: {
            Image(systemName: "line.3.horizontal")
                .font(.title).frame(width: 40,height: 65)
                .frame(alignment: .leading)
                .foregroundColor(.white)
                
        })
    }
    
}




enum SelectedScreen {
    case dashboard
    case home
    case screen1
    case screen2
    case alert
    case explorecategory
    case plans
}



struct MenuViewQ: View {
    
@StateObject var loginVM = GetAuthenticationViewModel()
    @Binding var showMenu: Bool
    @Binding var selected: SelectedScreen
    @State var shown = false
    @State var selectedItem = 1
    @Environment(\.dismiss) var dismiss
    var body: some View {
        
        
      
//        NavigationView {
            ZStack {
                    HStack(spacing:0) {
                        ScrollView{
                           
                    VStack(alignment: .leading) {
                        
                                NavigationLink(destination: LoginPageView().navigationTitle("")
                                    .navigationBarHidden(true)
                                    .navigationBarBackButtonHidden(true), label: {
                                        
                                 
                                    
                                    Text("LOGIN").foregroundColor(.white).font(.title).frame(width: UIScreen.main.bounds.width*0.67, height: 55, alignment: .center).background(.black).cornerRadius(32).padding(.horizontal).padding(.top,122)
                                })

                        Button(action: {
                            if loginVM.isAuthenticated{
                                selected = .dashboard
                                showMenu = false
                                
                            }
                            else{
                                selected = .home
                                showMenu = false
                                
                            }
                            
                           
                        }, label: {
                            
                            HStack{
                                Image(systemName: "house.fill")
                                    .font(.title2)
                                    .foregroundColor(.gray)
                                    .padding(.leading)
                                Text("Home")
                                    .font(.title2)
                                    .foregroundColor(.black)
                                    .padding(.leading,5)
                                Spacer()
                            }
                            .padding(.vertical)
                            
                            
                        })
                        
                        Button(action: {
                            
                            selected = .explorecategory
                            showMenu = false
                            
                        }, label: {
                            
                            HStack{
                                Image(systemName: "square.grid.3x3.fill")
                                    .font(.title2)
                                    .foregroundColor(.gray)
                                    .padding(.leading)
                                Text("Explore Categories")
                                    .font(.title2)
                                    .foregroundColor(.black)
                                    .padding(.leading,5)
                                Spacer()
                            }
                            .padding(.vertical)
                            
                            
                        })
                      
                        Button(action: {
                            
                            selected = .plans
                            showMenu = false
                            
                            
                        }, label: {
                            
                            
                            HStack{
                                Image(systemName: "lightbulb.fill")
                                    .font(.title2)
                                    .foregroundColor(.gray)
                                    .padding(.leading)
                                Text("Plan")
                                    .font(.title2)
                                    .foregroundColor(.black)
                                    .padding(.leading,5)
                                Spacer()
                            }
                            .padding(.vertical)
                        })
    //                    Button(action: {
    //                        selected = .alert
    //                        showMenu = false
    //
    //
    //                    }, label: {
    //
    //
    //                        HStack{
    //                            Image(systemName: "person.crop.square.fill")
    //                                .font(.title2)
    //                                .foregroundColor(.gray)
    //                                .padding(.leading)
    //                            Text("My Profile")
    //                                .foregroundColor(.black)
    //                                .font(.title2)
    //                                .padding(.leading,5)
    //                            Spacer()
    //                        }.padding(.vertical)
    //
    //                    })
                        Group{
                            
                            
                            
                            NavigationLink(destination: DonationView().navigationTitle("")
                                .navigationBarHidden(true)
                                .navigationBarBackButtonHidden(true), label: {
                                    
                                    HStack {
                                        
                                        Image(systemName: "doc.fill") .font(.title2)
                                            .foregroundColor(.gray)
                                            .padding(.leading)
                                        
                                        Text("Donations")
                                            .font(.title2)
                                            .padding(.leading, 5)
                                            .foregroundColor(.black)
                                    }.padding(.vertical)
                                    
                                })
                            NavigationLink(destination: MagazinesView().navigationTitle("")
                                .navigationBarHidden(true)
                                .navigationBarBackButtonHidden(true), label: {
                                
                                HStack{
                                    Image(systemName: "rectangle.trailinghalf.filled")
                                        .font(.title2).foregroundColor(.gray)
                                    //                    .background(Color.gray)
                                        .padding(.leading)
                                    Text("Magazines")
                                        .font(.title2).foregroundColor(.black)
                                        .padding(.leading,5)
                                    Spacer()
                                }.padding(.vertical)
                                
                            })
                            
                           
    //
    //                        HStack{
    //                            Image(systemName: "book.fill")
    //                                .font(.title2)
    //                                .foregroundColor(.gray)
    //                                .padding(.leading)
    //                            Text("Reported Books")
    //                                .font(.title2)
    //                                .padding(.leading, 5)
    //                            Spacer()
    //                        }.padding(.vertical)
    //                        HStack{
    //                            Image(systemName: "rectangle.split.2x2.fill")
    //                                .font(.title2)
    //                                .foregroundColor(.gray)
    //                                .padding(.leading)
    //                            Text("Assign Books")
    //                                .font(.title2)
    //                                .padding(.leading,5)
    //                            Spacer()
    //                        }.padding(.vertical)
                            
    //                        HStack{
    //                            Image(systemName: "indianrupeesign.square.fill")
    //                                .font(.title2)
    //                                .foregroundColor(.gray)
    //                                .padding(.leading)
    //                            Text("Invite & Earn")
    //                                .font(.title2)
    //                                .padding(.leading, 5)
    //                            Spacer()
    //                        }.padding(.vertical)
    //                        HStack{
    //                            Image(systemName: "rectangle.split.1x2")
    //                                .font(.title2)
    //                                .foregroundColor(.gray)
    //                                .padding(.leading)
    //                            Text("Stories")
    //                                .font(.title2)
    //                                .padding(.leading,5)
    //                            Spacer()
    //                        }.padding(.vertical)
                            
                            Divider()
                                .frame( height: 1)
                                .background(Color.gray)
                            //            Spacer()
                            HStack {
                                Text("Others")
                                    .foregroundColor(.gray)
                                    .bold()
                                    .font(.system(size: 18)).padding(.leading)
                                Spacer()
                            }
                        }

                        Group{

                            Button(action: {
                                
                                shown.toggle()
                                selectedItem = 1
                                
                            }, label: {
                                
                                HStack{
                                    Image(systemName: "person.2.fill")
                                        .font(.title2)
                                        .foregroundColor(.gray)
                                        .padding(.leading)
                                    Text("About us").foregroundColor(.black)
                                        .font(.title2)
                                        .padding(.leading,5)
                                    Spacer()
                                }.padding(.vertical)
                              
                            })
                            
                            
                        Button(action: {
                            shown.toggle()
                            selectedItem = 2
                            
                        }, label: {
                            
                            HStack{
                                Image(systemName: "person.crop.rectangle.stack.fill")
                                    .font(.title2)
                                    .foregroundColor(.gray)
                                    .padding(.leading)
                                Text("Contact Us")
                                    .font(.title2).foregroundColor(.black)
                                    .padding(.leading,5)
                                Spacer()
                            }.padding(.vertical)
                            
                        })
                           
                             
                                
                           
                            
                            Button(action: {
                                
                                shown.toggle()
                                selectedItem = 3
                                
                                
                            }, label: {
                                HStack{
                                    Image(systemName: "magnifyingglass.circle.fill")
                                        .font(.title2)
                                        .foregroundColor(.gray)
                                        .padding(.leading)
                                    Text("Privacy and Policy")
                                        .font(.title2).foregroundColor(.black)
                                        .padding(.leading,5)
                                    Spacer()
                                }.padding(.vertical)
                                
                                
                                
                            })
                            
                            
                            
                            Button(action: {
                                shown.toggle()
                                selectedItem = 4
                            }, label: {
                                
                                HStack{
                                    Image(systemName: "checkmark.shield.fill")
                                        .font(.title2)
                                        .foregroundColor(.gray)
                                        .padding(.leading)
                                    Text("Terms and conditions")
                                        .font(.title2).foregroundColor(.black)
                                        .padding(.leading,5)
                                    Spacer()
                                }.padding(.vertical)
                            })
                            
                            Button(action: {
                                
                                shown.toggle()
                                selectedItem = 5
                                
                            }, label: {
                                HStack{
                                    Image(systemName: "person.circle.fill")
                                        .font(.title2)
                                        .foregroundColor(.gray)
                                        .padding(.leading)
                                    Text("Adolescence")
                                        .font(.title2)
                                        .foregroundColor(.black)
                                        .padding(.leading,5)
                                    Spacer()
                                }.padding(.vertical)
                                
                            })
                            
                            Button(action: {
                                
                                shown.toggle()
                                selectedItem = 6
                                
                            }, label: {
                                
                                HStack{
                                    Image(systemName: "lock.fill")
                                        .font(.title2)
                                        .foregroundColor(.gray)
                                        .padding(.leading)
                                    Text("DMCA")
                                        .font(.title2).foregroundColor(.black)
                                        .padding(.leading,5)
                                    Spacer()
                                }.padding(.vertical)
                                
                            })
                           
                           
                            
                            NavigationLink(destination: CopyRightView().navigationTitle("")
                                .navigationBarHidden(true)
                                .navigationBarBackButtonHidden(true), label: {
                                    
                                    HStack{
                                        Image(systemName: "c.circle")
                                            .font(.title2)
                                            .foregroundColor(.gray)
                                            .padding(.leading)
                                        //                                Link("Copy Right", destination: URL(string: "https://www.alibrary.in/claim-copyright")!)
                                        Text("Copy Right")
                                            .foregroundColor(.black)
                                            .font(.title2)
                                            .padding(.leading,5)
                                        Spacer()
                                    }.padding(.vertical)
                                    
                                }
                                           )
                            Button(action: {
                                
                                shown.toggle()
                                selectedItem = 7
                               
                            }, label: {
                                
                                
                                HStack{
                                    Image(systemName: "text.bubble.fill")
                                        .font(.title2)
                                        .foregroundColor(.gray)
                                        .padding(.leading)
                                    Text("Subscribe")
                                        .font(.title2).foregroundColor(.black)
                                        .padding(.leading,5)
                                    Spacer()
                                }.padding(.vertical)
                                
                            })
                            
                          
                            
                        }
                        
                        
                       
    //                Spacer()
                    }
                        }
             
                        .background(Color.white)

                        VStack {
                            Color.black.opacity(0.3).ignoresSafeArea().onTapGesture {
                                showMenu = false
                            }
                        }
                    }
               
                    if shown {
                        
                        if selectedItem == 1{
//                            Spacer()
                            AboutUsView(isShown: $shown)
                        }
                        else if selectedItem == 2{
                            
//                           ContactUsView(isShown: $shown)
                            
                            EmptyView()
                        }
                        else if selectedItem == 3{
                            
                            PrivacyView(isShown: $shown)
                            
                        }
                        else if selectedItem == 4{
                            TermsAndConditionView( isShown: $shown)
                            
                        }
                        else if selectedItem == 5{
                            AdolescenceView(isShown: $shown)
                        }
                        else if selectedItem == 6{
                            DMCAView(isShown: $shown)
                        }
                        else if selectedItem == 7{
                            SubscribeView(isShown: $shown)
                          
                        }
                        
                       
//                    }
            }
        }
        
    }
}




