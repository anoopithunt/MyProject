//
//  GuestLoginSidemenuView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 26/04/23.
//

import SwiftUI

struct GuestLoginSidemenuView: View {
    @StateObject private var loginVM = GetAuthenticationViewModel()
    @State var presentSideMenu = false
    @State var selectedSideMenuTab = 0
    @State private var selected: GuestSelectedScreen = .dashboard
    var body: some View {
        ZStack{
            NavigationView{
                    
                VStack(spacing: 0){
                        
                    headerView()
                        
                    switch selected {
                        
                    case .home:
                        HomeView()
                    case .explorecategory:
                        StacksView()
                    case .dashboard:
                        DashboardView()
                    case .donation:
                        DateView()
                    case .profile:
                        ProfileView()
                    case .account:
                        AccountView()
                    case .collection:
                        SearchBooksCollectionView()
                    case .rctrans:
                        EmptyView()
                    case .magazine:
                        MagazineBannerView()
                    case .publisher:
                        HomePublisherView()
                    case .library:
                        LibraryView()
                    case .reported_book:
                        ReportedBooklistView()
                    case .invite_earn:
                        EmptyView()
                    case .stories:
                        EmptyView()
                    case .user_request:
                        BookRequestView()
                    case .plan:
                            
                        GuestPlanView()
                        }
                        
                        Spacer()
                    }
                }
                SideMenu(isShowing: $presentSideMenu, content: AnyView(SideMenuView(selectedSideMenuTab: $selectedSideMenuTab, presentSideMenu: $presentSideMenu, selected: $selected)))
                
            
        }
    }
    
    
    
    func headerView() -> some View{
        HStack{
            Button(action: {
                
                self.presentSideMenu.toggle()
                
            }, label: {
                
                Image(systemName: "line.3.horizontal")
                    .foregroundColor(.white)
                    .font(.headline)
                
            })
            NavigationLink(destination: EmptyView() // SearchBooksCollectionView()
                .navigationTitle("")
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)){
                    
                    Button(action: {
                        
                    }, label: {
                        
                        
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
                    })
                }
            Spacer()
            
            //
            
            Button(action: {
                
            }, label: {
                NavigationLink(destination: EmptyView()) {
                    Image("qr_c").resizable()
                        .frame(width: 30, height: 30)
                }
                
                
            })
            //                        Spacer()
            
            Menu {
                Button(action: {
                    
                }, label: {
                    Text("Buy Read Creadit(RC)").foregroundColor(.black).font(.system(size: 23,weight: .bold))
                })
                Button(action: {
                    
                }, label: {
                    Text("User Guide").foregroundColor(.black).font(.system(size: 23,weight: .bold))
                })
                
                Button(action: {
                    loginVM.logout()
                }, label: {
                    Text("Log Out").foregroundColor(.black).font(.system(size: 23,weight: .bold))
                })
                
                
            } label: {
                Image(systemName: "ellipsis")
                    .foregroundColor(.white)
                    .font(.system(size: 33))
                    .rotationEffect(.degrees(-90))
                    .padding()
            }
            
            
        }.padding()
            .frame( width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height*0.06)
            .font(.headline)
            .background(Color.orange)
    }
    
    
}

struct GuestLoginSidemenuView_Previews: PreviewProvider {
    static var previews: some View {
        GuestLoginSidemenuView()
    }
}


struct SideMenu: View {
    @Binding var isShowing: Bool
    var content: AnyView
    var edgeTransition: AnyTransition = .move(edge: .leading)
    var body: some View {
        ZStack(alignment: .center) {
            if (isShowing) {
                Color.black
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShowing.toggle()
                    }
                content
                    .transition(edgeTransition)
                    .background(
                        Color.clear
                    )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        .animation(.easeInOut, value: isShowing)
    }
}




struct SideMenuView: View {
    
    @Binding var selectedSideMenuTab: Int
    @Binding var presentSideMenu: Bool
    @Binding var selected: GuestSelectedScreen
    var body: some View {
        HStack {
            
            ZStack{
                Rectangle()
                    .fill(.white)
                    .frame(width: 270)
                    .shadow(color: .purple.opacity(0.1), radius: 5, x: 0, y: 3)
                
                VStack(alignment: .leading, spacing: 0) {
                    ProfileImageView()
                        .frame(height: 140)
                        .padding(.bottom, 30)
                    ScrollView{
                        
                        VStack(alignment: .leading, spacing: 2){
                          
                              Button(action: {
                                  selectedSideMenuTab = 1
                                  selected = .home
                                  presentSideMenu.toggle()
                              }, label: {
                                  HStack{
                                      Image(systemName: "house.fill").font(.system(size: 28, weight: .regular)).foregroundColor(.black)
                                      Text("Home").foregroundColor(.black)
                                  }.padding()
                                  
                              }).buttonStyle(CustomButtonStyle(selected: selected == .home))
                        
                            Button(action: {
                                selectedSideMenuTab = 1
                                selected = .explorecategory
                                presentSideMenu.toggle()
                            }, label: {
                                HStack{
                                    Image(systemName: "square.grid.3x3.fill").font(.system(size: 28, weight: .regular)).foregroundColor(.black)
                                    Text("Explore Categories").foregroundColor(.black)
                                }.padding()
                                
                            }).buttonStyle(CustomButtonStyle(selected: selected == .explorecategory))
                            
                            
                            Button(action: {
                                selectedSideMenuTab = 1
                                selected = .plan
                                presentSideMenu.toggle()
                            }, label: {
                                HStack{
                                    Image("round_wb_incandescent_black").resizable().frame(width: 35, height: 35)
                                    Text("Plan").foregroundColor(.black)
                                }.padding()
                                
                            }).buttonStyle(CustomButtonStyle(selected: selected == .plan))
                            
                            Button(action: {
                                selectedSideMenuTab = 1
                                selected = .donation
                                presentSideMenu.toggle()
                            }, label: {
                                HStack{
                                    Image(systemName: "rectangle.split.2x2.fill").font(.system(size: 32, weight: .regular)).foregroundColor(.black)
                                
                                    Text("Donation").foregroundColor(.black)
                                }.padding()
                                
                            })
                            .buttonStyle(CustomButtonStyle(selected: selected == .donation))
                            
                            Button(action: {
                                selectedSideMenuTab = 1
                                selected = .dashboard
                                presentSideMenu.toggle()
                            }, label: {
                                HStack{
                                    Image(systemName: "rectangle.split.2x2.fill").font(.system(size: 32, weight: .regular)).foregroundColor(.black)
                                    Text("Dashboard").foregroundColor(.black)
                                }.padding()
                                
                            }).buttonStyle(CustomButtonStyle(selected: selected == .dashboard))
                            
                            Button(action: {
                                selectedSideMenuTab = 1
                                selected = .profile
                                presentSideMenu.toggle()
                            }, label: {
                                HStack{
                                    Image(systemName: "person.crop.square.fill").font(.system(size: 32, weight: .regular)).foregroundColor(.black)
                                    
                                    Text("My Profile").foregroundColor(.black)
                                }.padding()
                                
                            })
                            
                            Button(action: {
                                selectedSideMenuTab = 1
                                selected = .account
                                presentSideMenu.toggle()
                            }, label: {
                                HStack{
                                    Image(systemName: "gearshape.fill").font(.system(size: 16, weight: .medium)).foregroundColor(.white).padding(5).background(Color.black).cornerRadius(4)
                                    Text("Account Setting").foregroundColor(.black)
                                }.padding()
                                
                            })
                            
                            Button(action: {
                                selectedSideMenuTab = 1
                                selected = .collection
                                presentSideMenu.toggle()
                            }, label: {
                                HStack{
//                                    Image("soft").resizable().frame(width: 35, height: 35)
                                    
                                    Image(systemName: "house.fill").font(.system(size: 28, weight: .regular)).foregroundColor(.black)
                                    Text("Book Collection").foregroundColor(.black)
                                }.padding()
                                
                            })
                           Divider()
                            Group{
                                Button(action: {
                                    selectedSideMenuTab = 1
                                    selected = .rctrans
                                    presentSideMenu.toggle()
                                }, label: {
                                    HStack{
                                        Image(systemName: "clock.arrow.circlepath").font(.system(size: 32, weight: .regular)).foregroundColor(.black)
                                        Text("Read Credit(RC) Transactions").foregroundColor(.black)
                                    }.padding()
                                    
                                })
                                Button(action: {
                                    selectedSideMenuTab = 1
                                    selected = .magazine
                                    presentSideMenu.toggle()
                                }, label: {
                                    HStack{
                                        Image("soft").resizable().frame(width: 35, height: 35)
                                        Text("Magazines").foregroundColor(.black)
                                    }.padding()
                                    
                                })
                                Button(action: {
                                    selectedSideMenuTab = 1
                                    selected = .publisher
                                    presentSideMenu.toggle()
                                }, label: {
                                    HStack{
                                        Image(systemName: "person.2.fill")
                                            .font(.system(size: 26, weight: .regular))
                                            .foregroundColor(.black)
                                        Text("Publishers").foregroundColor(.black)
                                    }.padding()
                                    
                                })
                                
                                
                                
                                Button(action: {
                                    selectedSideMenuTab = 1
                                    selected = .library
                                    presentSideMenu.toggle()
                                }, label: {
                                    HStack{
                                        Image("library").resizable().frame(width: 35, height: 35)
                                        Text("Library").foregroundColor(.black)
                                    }.padding()
                                    
                                })
                                
                                Button(action: {
                                    selectedSideMenuTab = 1
                                    selected = .reported_book
                                    presentSideMenu.toggle()
                                }, label: {
                                    HStack{
                                        Image("soft").resizable().frame(width: 35, height: 35)
                                        Text("Reported Books").foregroundColor(.black)
                                    }.padding()
                                    
                                })
                                
                                
                                Button(action: {
                                    selectedSideMenuTab = 1
                                    selected = .invite_earn
                                    presentSideMenu.toggle()
                                }, label: {
                                    HStack{
                                        
                                        Image(systemName: "gift").font(.system(size: 28, weight: .regular)).foregroundColor(.black)
                                        Text("Invite & Earn").foregroundColor(.black)
                                    }.padding()
                                    
                                })
                                
                                
                                Button(action: {
                                    selectedSideMenuTab = 1
                                    selected = .stories
                                    presentSideMenu.toggle()
                                }, label: {
                                    HStack{
                                        Image("soft").resizable().frame(width: 35, height: 35)
                                        Text("Stories").foregroundColor(.black)
                                    }.padding()
                                    
                                })
                            Divider()
                                VStack(alignment: .leading){
                                    Button(action: {
                                        selectedSideMenuTab = 1
                                        selected = .user_request
                                        presentSideMenu.toggle()
                                    }, label: {
                                        HStack{
                                            Image("user_request").resizable().frame(width: 25, height: 25)
                                            Text("User request").foregroundColor(.black)
                                        }.padding()
                                        
                                    })
                                    
                                    
                                    Button(action: {
                                        
                                        // Alert Action
                                    }, label: {
                                        HStack{
                                            Image(systemName: "person.2.fill")
                                                .font(.system(size: 26, weight: .regular))
                                                .foregroundColor(.black)
                                            Text("About Us").foregroundColor(.black)
                                        }.padding()
                                        
                                    })
                                    
                                    Button(action: {
                                        
                                        // Alert Action
                                    }, label: {
                                        HStack{
                                            Image(systemName: "person.crop.rectangle.stack.fill")
                                                .font(.system(size: 26, weight: .regular))
                                                .foregroundColor(.black)
                                            Text("Contact us").foregroundColor(.black)
                                        }.padding()
                                        
                                    })
                                    
                                    
                                    Button(action: {
                                        
                                        // Alert Action
                                    }, label: {
                                        HStack{
                                            Image("soft").resizable().frame(width: 35, height: 35)
                                            Text("Privacy and Policy").foregroundColor(.black)
                                        }.padding()
                                        
                                    })
                                    
                                    
                                    Button(action: {
                                        
                                        // Alert Action
                                    }, label: {
                                        HStack{
                                            Image(systemName: "checkmark.shield.fill")
                                                .font(.system(size: 32, weight: .regular))
                                                .foregroundColor(.black)
                                            Text("Terms and conditions").foregroundColor(.black)
                                        }.padding()
                                        
                                    })
                                    Button(action: {
                                        
                                        // Alert Action
                                    }, label: {
                                        HStack{
                                            Image(systemName: "person.circle.fill")
                                                .font(.system(size: 32, weight: .regular))
                                                .foregroundColor(.black)
                                            Text("Adolescence").foregroundColor(.black)
                                        }.padding()
                                        
                                    })
                                    
                                    
                                    Button(action: {
                                        
                                        // Alert Action
                                    }, label: {
                                        HStack{
                                            Image("lock").resizable().frame(width: 35, height: 35)
                                            Text("DMCA").foregroundColor(.black)
                                        }.padding()
                                        
                                    })
                                    Button(action: {
                                        
                                        // Alert Action
                                    }, label: {
                                        HStack{
                                            Image(systemName: "c.circle").font(.system(size: 32, weight: .regular)).foregroundColor(.black)
                                            Text("Copy Right").foregroundColor(.black)
                                        }.padding()
                                        
                                    })
                                    Button(action: {
                                        
                                        // Alert Action
                                    }, label: {
                                        HStack{
                                            Image(systemName: "text.bubble.fill")
                                                .font(.system(size: 32, weight: .regular)).foregroundColor(.black)
                                            Text("Subscribe").foregroundColor(.black)
                                        }.padding()
                                        
                                    })
                                    
                                }
                                
                                
                            }
                        }
                        
                    }
                    
                    Spacer()
                }
                .padding(.top, 100)
                .frame(width: 270)
                .background(
                    Color.white
                )
            }
            
            
            Spacer()
        }
        .background(.clear)
    }
    
    func ProfileImageView() -> some View{
        VStack(alignment: .center){
            HStack{
                Spacer()
                Image("Anoop")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(.orange, lineWidth: 3)
                    )
                    .cornerRadius(50)
                Spacer()
            }
            
            Text("Anoop Mishra")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.black)
            
            Text("IOS Developer")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.black.opacity(0.5))
        }
    }
    
    func RowView(isSelected: Bool, imageName: String, title: String, hideDivider: Bool = false, action: @escaping (()->())) -> some View{
        Button{
            action()
        } label: {
            VStack(alignment: .leading){
                HStack(spacing: 20){
                    Rectangle()
                        .fill(isSelected ? .orange : .white)
                        .frame(width: 5)
                    
                    ZStack{
                        Image(imageName)
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(isSelected ? .black : .gray)
                            .frame(width: 26, height: 26)
                    }
                    .frame(width: 30, height: 30)
                    Text(title)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(isSelected ? .black : .gray)
                    Spacer()
                }
            }
        }
        .frame(height: 50)
        .background(
            LinearGradient(colors: [isSelected ? .orange.opacity(0.5) : .white, .white], startPoint: .leading, endPoint: .trailing)
        )
    }
    

}

enum SideMenuRowType: Int, CaseIterable{
    case home = 0
    case category
    case plan
    case donation
    case dashboard
    case profile
    case account
    case book_collection
    case readcredit
    case magazine
    case publisher
    case library
    case reported_book
    case invite_earn
    case story
    
    
    var title: String{
        switch self {
        case .home:
            return "Home"
        case .category:
            return "Explore Categories"
        case .plan:
            return "Chat"
        case .donation:
            return "Profile"
        case .dashboard:
            return "Library"
        case .profile:
            return "Home"
        case .account:
            return "Explore Categories"
        case .book_collection:
            return "Chat"
        case .readcredit:
            return "Profile"
        case .magazine:
            return "Library"
        case .publisher:
            return "Chat"
        case .library:
            return "Profile"
        case .reported_book:
            return "Library"
            
        case .invite_earn:
            return "Profile"
        case .story:
            return "Library"
    
        }
    }
    
    var iconName: String{
        switch self {
        case .home:
            return "Anoop"
        case .category:
            return "Anoop"
        case .plan:
            return "soft"
        case .donation:
            return "upload"
        case .dashboard:
            return "stack_gray"
        case .profile:
            return "Anoop"
        case .account:
            return "Anoop"
        case .book_collection:
            return "soft"
        case .readcredit:
            return "upload"
        case .magazine:
            return "stack_gray"
        case .publisher:
            return "Anoop"
        case .library:
            return "Anoop"
        case .reported_book:
            return "soft"
        case .invite_earn:
            return "upload"
        case .story:
            return "stack_gray"
        }
    }
}




enum GuestSelectedScreen {
    case home
    case explorecategory
    case plan
    case donation
    case dashboard
    case profile
    case account
    case collection
    case rctrans
    case magazine
    case publisher
    case library
    case reported_book
    case invite_earn
    case stories
    case user_request
    //    case about
    //    case contact
    //    case privacy
    //    case terms
    //    case adolscence
    //    case dmca
    //    case copyright
    //    case subscribe
    
}


struct CustomButtonStyle: ButtonStyle {
    var selected: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(selected ? Color.orange : Color.white)
            .foregroundColor(.black)
            .cornerRadius(4)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}
