//
//  MainHomePageView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 07/11/22.
//

import SwiftUI

struct MainHomePageView: View{
    @State private var showMenu = false
    @State private var selected: SelectedScreen = .home
@StateObject var loginVM = GetAuthenticationViewModel()
    enum SwipeHorizontalDirection: String {
          case left, right, none
      }

      @State var swipeHorizontalDirection: SwipeHorizontalDirection = .none { didSet {


//          print(swipeHorizontalDirection)

      } }

    var body: some View {

        NavigationView {

            ZStack {
//                Color.white.opacity(1).ignoresSafeArea(.all, edges: .all)
                VStack(spacing:0) {


                HStack{
                    Button(action: {

                        self.showMenu = true

                    }, label: {

                        Image(systemName: "line.3.horizontal")
                            .foregroundColor(.white)
                            .font(.headline)

                    })
                    NavigationLink(destination: SearchBooksCollectionView().navigationTitle("")
                        .navigationBarHidden(true)
                        .navigationBarBackButtonHidden(true)){

//                                    Button(action: {
//
//                                    }, label: {


                                //Action On Search Books Button


                                ZStack {

                                    HStack {

                                        if #available(iOS 16.0, *) {
                                            Image(systemName: "magnifyingglass").foregroundColor(.gray).fontWeight(.heavy)
                                        } else {
                                            // Fallback on earlier versions

                                            Image(systemName: "magnifyingglass").foregroundColor(.gray).font(.body).frame(width: 30,height: 30)
                                        }
                                        Text("search books..").foregroundColor(.gray)
                                        Spacer()

                                    }.frame(width: UIScreen.main.bounds.width*0.6)
                                        .padding(.leading, 7)
                                }
                                .frame(height: 40)
                                .background()
                                .cornerRadius(8)
//                                    })
                        }
                    //                            Spacer()

                    //

                    Button(action: {

                    }, label: {
                        NavigationLink(destination: CodeScannerView()) {
                            Image("qr_c").resizable()
                                .frame(width: 30, height: 30)
                        }


                    })
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
                    
                }.padding(.leading)
                        .frame( width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height*0.06)

                            .font(.headline)
                            .background(Color("orange"))
                            
//                    Spacer()
                        switch selected {
                            
                        case .dashboard:
                            DashboardView()
                        case .home:
//                            if loginVM.isAuthenticated{
//                                DashboardView()
//                            }
//                            else{
                                HomePage()
//                            }
                            Spacer()
                                .disabled(self.showMenu ? true : false)
                        case .explorecategory:
                            Spacer()
                            ExploreCategoriesView()

                        case .plans:
                            PlansView()
                        case .screen2:

                            AdolscencesAlertView()

                        case .alert:
                            DMCAAlertView()


                        case .screen1:

                            ExploreCategoriesView()

                        }

                    Spacer()
                }//.padding(.top, -5)
                .gesture(DragGesture(minimumDistance: 70, coordinateSpace: .local)
                    .onChanged{
                        if $0.startLocation.x > $0.location.x{
                            self.swipeHorizontalDirection = .left
                            
                        } else if $0.startLocation.x == $0.location.x {
                            self.swipeHorizontalDirection = .none
                            
                        } else {
                            self.swipeHorizontalDirection = .right
                            
                        }

                }
                    .onEnded{_ in
                        if swipeHorizontalDirection == .right{
                            self.showMenu = true
                            
                        }
                        else if swipeHorizontalDirection == .left{
                            self.showMenu = false
                        }

                    }

                )

//                Spacer(minLength: 10)
                if self.showMenu {
                    MenuViewQ(showMenu: $showMenu, selected: $selected)
                        .offset(x: CGFloat(self.showMenu ? 0 : 1))
                                           .animation(.linear)

//                        .transition(.flipFromLeft(duration: 2))
                        
                }

            }
            

        }
    }

}



struct MainHomePageView_Previews: PreviewProvider {
    static var previews: some View {
        MainHomePageView()
    }
}



//struct MainHomePageView: View {
//
//    @State private var selected: SelectedScreen = .home
//  @State private var showMenu: Bool = false
//
//    enum SwipeHorizontalDirection: String {
//          case left, right, none
//      }
//
//      @State var swipeHorizontalDirection: SwipeHorizontalDirection = .none { didSet {
//
//
////          print(swipeHorizontalDirection)
//
//      } }
//  var body: some View {
//    NavigationView {
//
//      ZStack {
//
//          Color.white.opacity(0.1).ignoresSafeArea(.all, edges: .all)
//
//        VStack(spacing: 0) {
//            HStack{
//                Button(action: {
//                    self.showMenu.toggle()
//
//                }, label: {
//                    Image(systemName: "line.3.horizontal")
//                        .font(.title).frame(width: 40,height: 65)
//                        .frame(alignment: .leading)
//                        .foregroundColor(.white)
//
//                })
//                Button(action: {
//
//                }, label: {
//
//
//                ZStack {
//
//                    HStack {
//
//                        Image(systemName: "magnifyingglass").foregroundColor(.gray).font(.body).frame(width: 30,height: 35)
//
//                        Text("search books..").foregroundColor(.gray)
//                        Spacer()
//
//                    }.frame(width: UIScreen.main.bounds.width*0.5)
//                            .padding(.leading, 7)
//                        }
//                            .frame(height: 40)
//                            .background()
//                            .cornerRadius(8)
//                })
//                Spacer()
//                Button(action: {
//
//
//
//
//
//                }, label: {
//                    Image("qr_c").resizable()
//                        .frame(width: 30, height: 30)
//
//                })
//                //for 3 dot vertical point
//                Spacer()
//                Button(action: {
//
//                }, label: {
//                    Image(systemName: "ellipsis")
//                        .foregroundColor(.white)
//                        .font(.system(size: 33))
//                        .rotationEffect(.degrees(-90))
//                        .frame(width: 11, height: 55, alignment: .center)
//                        .padding()
//
//                })
//            }.padding(.horizontal, 10)
//
//            .frame( width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height*0.06)
//
//            .font(.headline)
//            .background(Color.orange)
//            switch selected {
//            case .home:
//                HomePage()
//                Spacer()
//                    .disabled(self.showMenu ? true : false)
//            case .explorecategory:
//                Spacer()
//                ExploreCategoriesView().onPageAppear{
//                    self.showMenu = false
//                }
//
//            case .plans:
//                DashboardView()
//            case .screen2:
//
//              EmptyView()
//
//            case .alert:
//                EmptyView()
//
//
//            case .screen1:
//                EmptyView()
//
//            }
//            Spacer()
//        }
//
//        GeometryReader { _ in
//
//          HStack {
//
//
//              SideMenuView(showMenu: false, selected: $selected )
//              .offset(x: showMenu ? 0 : -UIScreen.main.bounds.width)
//              .animation(.easeInOut(duration: 0.4), value: showMenu)
//              Spacer()
//          }
//
//        }
//        .background(Color.black.opacity(showMenu ? 0.5 : 0).ignoresSafeArea().onTapGesture {
//            showMenu = false
//        })
//
//      }.gesture(DragGesture(minimumDistance: 70, coordinateSpace: .local)
//        .onChanged{
//        if $0.startLocation.x > $0.location.x {
//                                self.swipeHorizontalDirection = .left
//                            } else if $0.startLocation.x == $0.location.x {
//                                self.swipeHorizontalDirection = .none
//                            } else {
//                                self.swipeHorizontalDirection = .right
//                            }
//
//    }
//        .onEnded{_ in
//            if swipeHorizontalDirection == .right{
//                self.showMenu = true
//
//            }
//            else if swipeHorizontalDirection == .left{
//
//
//                self.showMenu = false
//            }
//
//        }
//
//    )
//
//
//    }
//  }
//}
//
//// Side Menu Design Start------
//
//
struct SideMenuView: View {

    @State var showMenu: Bool
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
                   NavigationLink(destination: LoginPageView()
                    .navigationTitle("")
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true), label: {
                        Text("LOGIN").foregroundColor(.white)
                        .font(.title)
                        .frame(width: UIScreen.main.bounds.width*0.67, height: 55, alignment: .center)
                        .background(.black)
                        .cornerRadius(32)
                        .padding(.horizontal)
                        .padding(.top,122)

                    })
                   Button(action: {
                       selected = .home
                       showMenu = false

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
                            }.padding(.vertical)
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
                               .padding(.leading)
              Spacer()

                       }.padding(.vertical)

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

                       }.padding(.vertical)

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
                       HStack {
                           Image(systemName: "doc.fill")
                               .font(.title2)
                               .foregroundColor(.gray)
                               .padding(.leading)
                           Link("Donations", destination: URL(string: "https://www.alibrary.in/donate-funds")!)
                               .font(.title2)
                               .padding(.leading, 5)
                               .foregroundColor(.black)

                       }.padding(.vertical)

                    NavigationLink(destination: MagazinesView()
//                       EmptyView()
                        .navigationTitle("")
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
                           .font(.system(size: 18))
                           .padding(.leading)
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
                                    Text("About us")
                                        .foregroundColor(.black)
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
                                    .font(.title2)
                                    .foregroundColor(.black)
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
                                        .font(.title3)
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
                                }.padding(.vertical,5)
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
                                }.padding(.vertical,5)

                            })
                            NavigationLink(destination: CopyRightView().navigationTitle("")
                                .navigationBarHidden(true)
                                .navigationBarBackButtonHidden(true), label: {

                                    HStack{
                                        Image(systemName: "c.circle")
                                            .font(.title2)
                                            .foregroundColor(.gray)
                                            .padding(.leading)
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

                    }
                        }

                        .background(Color.white)

                    }.frame(width: UIScreen.main.bounds.width*0.7)

                    if shown {

                        if selectedItem == 1{
//                            Spacer()
                            AboutUsView(isShown: $shown)
                        }
                        else if selectedItem == 2{
                            EmptyView()
//                           ContactUsView(isShown: $shown)

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
