//
//  ContentView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 05/08/22.
//

import SwiftUI

//import PagerTabStripView


struct ContentView: View {
    var body: some View {
//        AccountSettingView()
        MainHomePageView()
    }
}

struct MyPagerView: View {
    @State var currentTab: Int = 0
    
    var body: some View {
        VStack{
//            Spacer().frame(height: 80)
//        PagerTabStripView() {
//            AccountView()
//                .frame(width: UIScreen.main.bounds.width)
//                .pagerTabItem {
//                    TitleNavBarItem(title: "ACCOUNT", systomIcon: "character.bubble.fill")
//
//                }
//
//            UserAccountProfileView()
//                .frame(width: UIScreen.main.bounds.width)
//                .pagerTabItem {
//                    TitleNavBarItem(title: "PROFILE", systomIcon: "person.circle.fill")
//                }
//
//            UserAccountPasswordView()
//                .frame(width: UIScreen.main.bounds.width)
//                    .pagerTabItem {
//                        TitleNavBarItem(title: "PASSWORD", systomIcon: "lock.fill")
//                    }
//
//        }
//        .pagerTabStripViewStyle(.barButton(placedInToolbar: false, tabItemSpacing: 0, tabItemHeight: 80,indicatorViewHeight: 3, indicatorView: {
//            Color.black
//        })).padding(-2)
//
//        .foregroundColor(.white)
//
            
            
            ZStack {
                TabView(selection: self.$currentTab) {
                    AccountView().tag(0)
                    UserAccountProfileView().tag(1)
                    UserAccountPasswordView().tag(2)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .edgesIgnoringSafeArea(.bottom)
                
                PagerTabBarView(currentTab: self.$currentTab)
            }
            
        }
    }
}


struct TitleNavBarItem: View {
    let title: String
    let systomIcon: String
    var body: some View {
        VStack {
            Image(systemName: systomIcon)
             .foregroundColor( .white)
             .font(.title)
    
             Text( title)
                .font(.system(size: 22))
//                .bold()
//                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("orange"))
    }
}





struct AccountView: View{
 
    @StateObject var list = UserAccountSettingViewModel()
    @State var showDatePicker: Bool = false
    @State var date: Date? = nil
       
    var body: some View{
        ZStack{
            Image("u").resizable()
            
            VStack{
                
                
                ScrollView(showsIndicators: true){
                    
                    AccountFloatingTextField(placeHolder: "Email", leadingImage: "person.crop.rectangle.fill", text: $list.email_id).foregroundColor(.red).padding(.horizontal)
                    AccountFloatingTextField(placeHolder: "First Name", leadingImage: "person.crop.rectangle.fill", text: $list.first_name).padding(.horizontal)
                    AccountFloatingTextField(placeHolder: "Last Name", leadingImage: "person.crop.rectangle.fill", text: $list.last_name).padding(.horizontal)
                    
                        DateView().underlineTextField().foregroundColor(.black).padding(.horizontal)
                   
                   
                    HStack{
                        Text("**Address Details**").font(.system(size: 26)).frame(alignment: .leading).foregroundColor(.black)
                        Spacer()
                    }.padding(.horizontal)
                   
                    AccountFloatingTextField(placeHolder: "Mobile no.", leadingImage: "phone.fill", text: $list.mobile_no).padding(.horizontal)
                    
                    
                    AccountFloatingTextField(placeHolder: "Pincode", leadingImage: "magazine", text: $list.postal_code).padding().keyboardType(.numberPad)
                    
                   
                    Group{
                    AccountFloatingTextField(placeHolder: "Address", leadingImage: "location.fill", text: $list.full_address).padding(.horizontal)

                    
                    DropdownSelector(placeholder: list.city)
                                            .padding()
                    
                    
                        
                        HStack{
                            Text("**City Name:\(list.city)**").font(.system(size: 26)).frame(alignment: .leading).foregroundColor(.black)
                            Spacer()
                        }.padding()
                        HStack{
                            Text("**State Name:\(list.state)**").font(.system(size: 26)).frame(alignment: .leading).foregroundColor(.black)
                            Spacer()
                        }.padding()
                        HStack{
                            Spacer()
                            Text("**Update Account**")
                                .padding()
                                .font(.system(size: 26))
                                .frame(alignment: .leading)
                                .foregroundColor(.white)
                                .background(Color.black)
                                .cornerRadius(28)
                            
                        }.padding()
                        
                    }
                }
            }.onAppear{
                list.getAccountData()
            }
            
            
            if showDatePicker {
                Color.gray
                DatePickerWithButtons(showDatePicker: $showDatePicker, savedDate: $date, selectedDate: date ?? Date())
                    .animation(.linear, value: 2)
                    .transition(.opacity)
                
            }
}
    }
}





struct UserAccountPasswordView: View{
    @State var isInSecureField = false
    @State var email: String = ""
    @State var oldPass: String = ""
    @State var newPass: String = ""
    @State var comfirmPass: String = ""
    var body: some View{
        
        ZStack{
            Image("u").resizable().background(Color.white)
            VStack{
                CustomFloatingTextField(placeHolder: "Email", leadingImage: "person.crop.rectangle.fill", text: $email).padding()
                CustomFloatingTextField(placeHolder: "Old Password", leadingImage: "lock.fill", text: $oldPass).overlay(alignment: .trailing, content: {
                    Image(systemName: "eye").foregroundColor(.black).padding(.trailing,28)
                }).padding()
                
                
                CustomFloatingTextField(placeHolder: "New Password", leadingImage: "lock.fill", text: $newPass).overlay(alignment: .trailing, content: {
                    Image(systemName: "eye").foregroundColor(.black).padding(.trailing,28)
                }).padding()
                CustomFloatingTextField(placeHolder: "Comfirm Password", leadingImage: "lock.fill", text: $comfirmPass).padding()
//                SecureField("enter your password", text: Binding<String>(
//                               get: { self.email },
//                               set: { self.email = $0
//                                   print("editing a SecureField")
//                                   self.isInSecureField = true
//                                  }
//                )).overlay(alignment: .trailing, content: {
//                    Image(systemName: "lock.fill")
//                }).padding()
                Spacer()
                
//                HStack{
                
                    Text("**Update Password**").padding()
                    .font(.system(size: 22)).frame(width: UIScreen.main.bounds.width*0.9).foregroundColor(.white).background(Color.black).cornerRadius(28)
//                }.padding()
                
                
            }.padding(.top)
        }
    }
}





struct CustomFloatingPasswordField: View {
    let textFieldHeight: CGFloat = 50
    private let placeHolderText: String
    @State var rightImage: String
    @State var isTapped: Bool = true
    @State var text: String
    @State private var isEditing = false
    public init(placeHolder: String, rightImage: String,
                text: String) {
        self.text = text
        self.placeHolderText = placeHolder
        self.rightImage = rightImage
 
    }
    var shouldPlaceHolderMove: Bool {
        isEditing || (text.count != 0)
    }
    
    
    var body: some View {
        ZStack(alignment: .leading) {

            TextField("", text: $text, onEditingChanged: { (edit) in
                isEditing = true
            }) .overlay(alignment: .trailing, content: {
               
                    Image(systemName: isTapped ? "eye" : "eye.slash")
                    .foregroundColor(.black).onTapGesture {
                        
                        isEditing.toggle()
                    }
               
        })

                    
            .padding(.leading,40)
            .padding(.trailing,35)
            .foregroundColor(Color.gray)
            .accentColor(Color.orange)
            .font(.system(size: 22))
            .animation(.easeInOut(duration: 1.2), value:  true)
           
            ///Floating Placeholder
                Text(placeHolderText)
                .foregroundColor(shouldPlaceHolderMove ? Color.black: Color.gray)
            .padding(shouldPlaceHolderMove ?
                     EdgeInsets(top: 0, leading:12  , bottom: textFieldHeight, trailing: 0) :
                     EdgeInsets(top: 0, leading:43, bottom: 0, trailing: 0))
            .scaleEffect(shouldPlaceHolderMove ? 1.2 : 1.3)
            
            .animation(.easeInOut, value: 91)
            .overlay(alignment: .leading){
                Image(systemName: rightImage)
                    .foregroundColor(.gray)
                    .font(.system(size: 24)).padding(.trailing)
            }
                                
        }
        .underlineTextField()
        .foregroundColor(shouldPlaceHolderMove ? Color.black: Color.gray)
        .frame( height: 50)

    }
}



struct ProView: View {
    
    @State private var scrollText = false
    
    var body: some View {
        
        ZStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    ScrollViewReader { value in
                        
                        HStack(spacing: 5) {
                            
                            ForEach(0 ..< 100) { i in
                                
                                HStack {
                                    Image("Anoop")
                                        .resizable()
                                        .frame(width: UIScreen.main.bounds.width, height: 120)
                                    
                                    Image("image")
                                        .resizable()
                                        .frame(width: UIScreen.main.bounds.width, height: 120)
                                    
                                    Image("Anoop")
                                        .resizable()
                                        .frame(width: UIScreen.main.bounds.width, height: 120)
                                    
                                    Image("image")
                                        .resizable()
                                        .frame(width: UIScreen.main.bounds.width, height: 120)
                                    
                                    Image("Anoop")
                                        .resizable()
                                        .frame(width: UIScreen.main.bounds.width, height: 120)
                                    
                                    Image("image")
                                        .resizable()
                                        .frame(width: UIScreen.main.bounds.width, height: 120)
                                    
                                    Image("Anoop")
                                        .resizable()
                                        .frame(width: UIScreen.main.bounds.width, height: 120)
                                    
                                    Image("image")
                                        .resizable()
                                        .frame(width: UIScreen.main.bounds.width, height: 120)
                                    Image("Anoop")
                                        .resizable()
                                        .frame(width: UIScreen.main.bounds.width, height: 120)
                                    
                                    Image("image")
                                        .resizable()
                                        .frame(width: UIScreen.main.bounds.width, height: 120)
                                    
                              
                                    
                                }
                                .id(i)
                            }
                            
                        }
                        .offset(x: scrollText ? -1000 : 20)
                        .animation(Animation.linear(duration: 12).repeatForever(autoreverses: false))
                        .onAppear() {
                            value.scrollTo(23, anchor: .trailing)
                            scrollText.toggle()
                        }
                    }
                }
                
                Spacer()
            }
            
        }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {

//        ContentView()
        MyPagerView()
//        MainHomePageView()
    }
}


struct AccountFloatingTextField: View {
    let textFieldHeight: CGFloat = 50
    private var placeHolderText: String = ""
    @State var leadingImage: String
    
    @Binding var text: String
    @State private var isEditing = false
    public init(placeHolder: String, leadingImage: String,
                text: Binding<String>) {
        self._text = text
        self.placeHolderText = placeHolder
        self.leadingImage = leadingImage
 
    }
    var shouldPlaceHolderMove: Bool {
        isEditing || (text.count != 0)
    }
    
    
    var body: some View {
        ZStack(alignment: .leading) {
          
            
            TextField("", text: $text, onEditingChanged: { (edit) in
                isEditing = edit
            })
            .padding(.leading,40)
            .padding(.trailing,35)
            .foregroundColor(Color.black)
            .accentColor(Color.orange)
            .font(.system(size: 22))
            .animation(.linear, value:  true)
//            .overlay(alignment: .trailing){
//                Image(systemName: "eye")
//                    .foregroundColor(.black)
//            }
            ///Floating Placeholder
            Text(placeHolderText)
            
//                .foregroundColor(.white)
            .padding(shouldPlaceHolderMove ?
                     EdgeInsets(top: 2, leading:40, bottom: textFieldHeight, trailing: 0) :
                     EdgeInsets(top: 0, leading:55, bottom: 0, trailing: 0))
            .scaleEffect(shouldPlaceHolderMove ? 1.2 : 1.3)
            
            .animation(.easeInOut, value: 91)
            .overlay(alignment: .leading){
                Image(systemName: leadingImage)
                    .foregroundColor(Color.gray)
                    .font(.system(size: 24))
            }
                                
        }
        .underlineTextField()
        .foregroundColor(shouldPlaceHolderMove ? Color.black: Color.gray)
        .frame( height: 90)

    }
}






struct MainHomePageView: View {

    @State private var selected: SelectedScreen = .home
  @State private var showMenu: Bool = false

    enum SwipeHorizontalDirection: String {
          case left, right, none
      }

      @State var swipeHorizontalDirection: SwipeHorizontalDirection = .none { didSet {


//          print(swipeHorizontalDirection)

      } }
  var body: some View {
    NavigationView {

      ZStack {

          Color.white.opacity(0.1).ignoresSafeArea(.all, edges: .all)
          ScrollViewReader{_ in
              
              
              VStack(spacing: 0) {
                  
                  switch selected {
                  case .home:
//                      StacksView()
                      DashboardView()
                      Spacer()
                          .disabled(self.showMenu ? true : false)
                  case .explorecategory:
                      Spacer()
                      
                      CopyRightView()
                      
                      
                  case .plans:
                      LectureAudioView()
                  case .screen2:
                      
                      EmptyView()
                      
                  case .alert:
                      EmptyView()
                      
                      
                  case .screen1:
                      EmptyView()
                      
                  }
                  Spacer()
              }
          }.toolbar {
              HStack{
                  Button(action: {
                      self.showMenu.toggle()

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
              }.padding(.horizontal, 10)

              .frame( width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height*0.06)

              .font(.headline)
              .background(Color.orange)
          }.navigationBarHidden(self.showMenu)
        GeometryReader { _ in

          HStack {


             MenuViews(showMenu: $showMenu, selected: $selected )
              .offset(x: showMenu ? 0 : -UIScreen.main.bounds.width)
              .animation(.easeInOut(duration: 0.4), value: showMenu)
              Spacer()
          }

        }
        .background(Color.black.opacity(showMenu ? 0.5 : 0).ignoresSafeArea().onTapGesture {
            showMenu = false
        })

      }.gesture(DragGesture(minimumDistance: 70, coordinateSpace: .local)
        .onChanged{
        if $0.startLocation.x > $0.location.x {
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
         

    }
  }
}


struct PagerTabBarView: View {
    @Binding var currentTab: Int
    @Namespace var namespace
    
    var tabBarOptions: [String] = ["ACCOUNT","PROFILE", "PASSWORD"]
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(Array(zip(self.tabBarOptions.indices,
                                      self.tabBarOptions)),
                            id: \.0,
                            content: {
                        index, name in
                        TabBarItem(currentTab: self.$currentTab,
                                   namespace: namespace.self,
                                   tabBarItemName: name,
                                   tab: index)
                        
                    })
                }.padding(.leading,5)
                .background(Color("orange")).frame(width: UIScreen.main.bounds.width)
                
            }
            .background(Color.white)
        .frame(height: 80)
          
            Spacer()
        }
        .edgesIgnoringSafeArea(.all)
    }
}


//// Side Menu Design Start------
//
//
struct  MenuViews: View {

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

                    NavigationLink(destination: NotificationsView()
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

//                    if shown {
//
//                        if selectedItem == 1{
////                            Spacer()
//                            AboutUsView(isShown: $shown)
//                        }
//                        else if selectedItem == 2{
//                            EmptyView()
////                           ContactUsView(isShown: $shown)
//
//                        }
//                        else if selectedItem == 3{
//
//                           AboutUs(isShown: $shown)
//
//
//                        }
//                        else if selectedItem == 4{
//                            AboutUs( isShown: $shown)
//
//                        }
//                        else if selectedItem == 5{
//                            AboutUs(isShown: $shown)
//
//                        }
//                        else if selectedItem == 6{
//                            AboutUs(isShown: $shown)
//
//                        }
//                        else if selectedItem == 7{
//                            AboutUs(isShown: $shown)
//
//                        }


//            }
        }

    }

}

