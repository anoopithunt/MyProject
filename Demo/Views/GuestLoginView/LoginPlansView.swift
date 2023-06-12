//
//  LoginPlansView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 23/12/22.
//

import SwiftUI
//import PagerTabStripView
import RichText

struct LoginPlansView: View {
 
        @State var currentTab: Int = 0
            var body: some View {
                VStack {
                    
                    ZStack(alignment: .top) {
                        TabView(selection: self.$currentTab) {
                            GuestPlanView().tag(0)
                            ReadCreditsView().tag(1)
                        }
                        .tabViewStyle(.page(indexDisplayMode: .never))
                        .edgesIgnoringSafeArea(.bottom)
                        
                        TabBarView(currentTab: self.$currentTab)
                    }
    //                Spacer()
                }
                
            }
  
}

struct LoginPlansView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPlansView()

        
    }
}






struct TabBarView: View {
    @Binding var currentTab: Int
    @Namespace var namespace
    
    var tabBarOptions: [String] = ["Guest Plans","Read Credit(RC)"]
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
//        .edgesIgnoringSafeArea(.all)
    }
}



struct TabBarItem: View {
    @Binding var currentTab: Int
    let namespace: Namespace.ID
    
    var tabBarItemName: String
    var tab: Int
    
    var body: some View {
      
            Button {
                self.currentTab = tab
            } label: {
                VStack {
                    Spacer()
                    Text(tabBarItemName)
                        .foregroundColor(currentTab == tab ? .white : .gray).font(.system(size: 20,weight: .semibold))
                    if currentTab == tab {
                        Color.black
                            .frame(height: 3)
                            .matchedGeometryEffect(id: "underline",
                                                   in: namespace,
                                                   properties: .frame)
                    } else {
                        Color.clear.frame(height: 2)
                    }
                }
                .animation(.spring(), value: self.currentTab)
            }
            .buttonStyle(.plain)
       
        
    }
}




struct GuestPlanView: View {
    @StateObject private var authList = AuthenticationPlanListService()
    @State var shown = false
    var body: some View {
        ZStack {
            Color.gray.opacity(0.1).ignoresSafeArea()
            VStack{
                Spacer(minLength: 80)
               
                
               
                
                VStack {
                    
                    ScrollView(showsIndicators: false){
                        
                        
                        Text("**Anoop Mishra**")
                            .foregroundColor(.black)
                            .font(.system(size: 28))
                        
                        Button(action: {
                            
                        }, label: {
                            Text("**FREE ACCOUNT**").font(.system(size: 26)).foregroundColor(.white).frame(height: 22).padding(.horizontal,22).padding(13).background(Color.red).cornerRadius(22).overlay(RoundedRectangle(cornerRadius: 22)
                                .stroke(Color.white, lineWidth: 3))
                        })
                        
                        
                        HStack(spacing:15) {
        //                    VStack{
                            ZStack{
                                Color.green.opacity(0.2)
                                RoundedRectangle(cornerRadius: 38)
                                .stroke(Color.green, lineWidth: 3).frame(height: 180)
                                
                                VStack{
                                    HStack{
                                        Image("donate").resizable().frame(width: 75, height: 75, alignment: .leading)
                                        Spacer()
                                        Text("₹\(authList.active_donation_rc)").font(.system(size: 25, weight: .heavy))
                                    }.padding(.horizontal)
                                    Text("**Active Donations\nmissing**").font(.system(size: 20)).foregroundColor(.black)
                                }
                                
                                
                            }.frame(height: 180).cornerRadius(38)
                            ZStack{
                                Color.blue.opacity(0.2)
                                RoundedRectangle(cornerRadius: 38)
                                    .stroke(Color.blue, lineWidth: 1).frame(height: 180)
                               
                                VStack{
                                    HStack{
                                        Image("upload").resizable().frame(width: 75, height: 75, alignment: .leading)
                                        Spacer()
                                        Text("\(authList.upload_remain)/\(authList.upload_total)").font(.system(size: 25, weight: .heavy))
                                    }.padding(.horizontal)
                                    Text("**Uploading Today\ndaily**").font(.system(size: 20)).foregroundColor(.black)
                                }
                            }.frame(height: 180).cornerRadius(38)
                            
        //                    }
                        }.padding(.horizontal)
                        
                        ZStack{
                            VStack{
                                
                                HStack(alignment: .center, spacing: nil) {

                                    ForEach(authList.guestPlanHeadings, id: \.self){ heading in
                                        if heading == "Free"{
                                            Text("**\(heading)**").foregroundColor(.red).font(.system(size: 24, weight: .heavy))
                                        }
                                        else{
                                            Text("**\(heading)**").font(.system(size: 24))
                                        }


                                    }.frame(maxWidth: UIScreen.main.bounds.width/3.1, alignment: .center)
                                    //                                .border(.gray, width: 2)

                                }
                                .padding()
                                
                                
                                ForEach(authList.datas, id: \.self) { array in
                                    HStack(alignment: .center, spacing: nil) {
                                        
                                        ForEach(array, id: \.self){ item in
                                            switch item {
                                            case .integer(let int):
                                                if int == 9999 {
                                                    Image(systemName: "checkmark.circle.fill").foregroundColor(Color("green")).font(.system(size: 28))
                                                    
                                                }
                                                else if int == 0{
                                                    Image(systemName: "multiply.circle.fill").foregroundColor(.red.opacity(0.8)).font(.system(size: 28))
                                                }
                                                
                                                else{
                                                    Text("\(int)").font(.system(size: 24))
                                                }
                                                //
                                            case .string(let str): Text(str).font(.system(size: 18))
                                            }
                                            
                                        }.frame(maxWidth: UIScreen.main.bounds.width/3.1, alignment: .center)
                                        //                                .border(.gray, width: 2)
                                        
                                    }
                                    .padding()
                                }
                                Divider().background(Color.black).padding(.horizontal)
                                Text("[**Make a donation**](https://alibrary.in/donate-funds) to upgrade your account").padding()
                                //
                               
                            }
                            HStack(spacing: 0){
                                Spacer()
                                Color.green.opacity(0.2).frame(maxWidth: UIScreen.main.bounds.width/3.4, alignment: .center)
                                Color.blue.opacity(0.2).frame(maxWidth: UIScreen.main.bounds.width/3.4, alignment: .center)
//                                Spacer()
                            }.padding(.bottom,65)
                            
                        
                        }
                        .frame(width: UIScreen.main.bounds.width*0.95).background(Color.white
                        ).border(.gray, width: 0.2).cornerRadius(12)
                        Text("**Read credit upgrade**\nReading Prime Books or Prime Magazines will cost 1 Read Credit(RC) by dafault. In case of full consumption of Read Credits(RC) during Prome Membership, Readers are requested to top up by purchasing Read Credits(RC) as per their reading habit.").font(.system(size: 20)).padding(.horizontal)
                    }
                    .padding(1)
                }
                
                Button(action: {
                    shown.toggle()
                    
                }, label: {
                    Text("**Purchase Now**").font(.system(size: 26)).foregroundColor(.white).frame(width: UIScreen.main.bounds.width*0.8, height: 66).background(Color("green")).cornerRadius(28)
//                                .padding()
                }).overlay(
                    RoundedRectangle(cornerRadius: 38)
                        .stroke(Color.white, lineWidth: 3)
                )
                Spacer(minLength: 25)
            }
            if shown{
                PrimePurchageView(isShown: $shown)
            }
            
        }.task {
//            await list.getData()
             authList.getPlanData()
        }
        
        
        
    }
}

//
//class ReadCreditsViewModel: ObservableObject{
//
//    @Published var rcDatas = [RCPricing]()
//
//    let url = "https://www.alibrary.in/api/plans"
//
//    init() {
//        getData(url: url)
//    }
//
//    func getData(url: String) {
//        guard let url = URL(string: url) else { return }
//        URLSession.shared.dataTask(with: url) { (data, _, _) in
//            if let data = data {
//                do {
//                  let result  = try JSONDecoder().decode(PlanModel.self, from: data)
//                    DispatchQueue.main.async {
//                        self.rcDatas = result.rcPricings
//
//                    }
//                }
//                catch {
//                    print(error)
//                }
//            }
//        }.resume()
//    }
//
//
//
//
//}



struct ReadCreditsView: View {
    @StateObject var list = AuthenticationPlanListService()
    var body: some View {
        
        
        
        VStack {
            
            Spacer().frame(height: 110)
            VStack(spacing: 0){
                VStack(alignment: .leading, spacing:0) {
                    HStack(spacing: 0 ) {
                        
                        Text("**Read Credits**").frame(width: 134, height:48).border(.cyan,width: 1.1)
                        
                        Text("**Qty**").frame(width: 130, height:48).border(.cyan,width: 1.1)
                        Text("**₹ Price**").frame(width: 110, height:48).border(.cyan,width: 1.1)
                        
                    }.border(.cyan,width: 0.6).background(Color.cyan.opacity(0.6))
//                    Spacer()
                    ForEach(list.rcDataPrice, id: \.id){ item in
                        HStack(spacing: 0 ) {
                            
                            RichText(html: item.name).frame(width: 134, height:50).border(.cyan,width: 1.1)
                            
                            Text("\(item.rc_from) to \(item.rc_to)").frame(width: 130, height:50).border(.cyan,width: 1.1)
                            let p = item.price/10
                            Text("\(item.price/100).\(p%10) ₹").frame(width: 110, height:50).border(.cyan,width: 1.1)
                            
                        }.border(.cyan,width: 1.0)
                    }
//                                                Spacer()
                }.frame( height: 200).border(.cyan,width: 2)
                Text("**Read credit**\nRead Credit is a great book reading option by which multiple paidbooks can also be read easily by doanting read credit points and the read credit purchased by the user is provide with a life time validity. ").padding([.top, .leading, .bottom]).foregroundColor(.black.opacity(0.7))
                
                
                
                Button(action: {
                    
                    
                }, label: {
                    Text("**Purchase Point**").font(.system(size: 26)).foregroundColor(.white).frame(width: UIScreen.main.bounds.width*0.8, height: 66).background(Color("green")).cornerRadius(28)
                    //                                .padding()
                }).overlay(
                    RoundedRectangle(cornerRadius: 38)
                        .stroke(Color.white, lineWidth: 3)
                )
                
                
            }
            Spacer(minLength: 30)
            
                .onAppear{
                    list.getPlanData()
                }
            
            
        }
    }
}

