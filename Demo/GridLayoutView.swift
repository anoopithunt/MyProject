////
////  GridLayoutView.swift
////  Demo
////
////  Created by Anup Kumar Mishra on 10/08/22.
////
//
//import SwiftUI
//
//struct GridLayoutView: View {
//    @ObservedObject var lists = getData()
//
//    var layout: [GridItem] = [
//           GridItem(.flexible(), spacing: nil, alignment: nil),
//           GridItem(.flexible(), spacing: nil, alignment: nil)
//       ]
//    var body: some View {
//       
//           
//                    ScrollView{
//                        LazyVGrid(columns: layout, spacing: 4) {
//                            ForEach(lists.datas, id: \.id) { i in
//                             
//                            
//                    
//                                HStack{
//                                    ExView(full_name: i.full_name, totalBookViews: i.totalBookViews, totalfollowers: i.totalfollowers, totalBooks: i.totalBooks, url: "hrrr")
//                                   
//                                    
////                                        .frame(height: 345)
//                                        .cornerRadius(22)
////                                        .padding(.all,5)
//                             Spacer()
//                            }
//                           
//                            }
//    }
//                        .padding()
//
//                    }
//    
//                    .padding(.vertical,22)
//    }
//}
//struct GridLayoutView_Previews: PreviewProvider {
//    static var previews: some View {
//        GridLayoutView()
//
//       
//    }
//}
