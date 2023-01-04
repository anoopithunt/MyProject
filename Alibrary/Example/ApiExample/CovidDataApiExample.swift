//
//  CovidDataApiExample.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 28/07/22.
//

import SwiftUI

struct CovidDataApiExample: View {
    @ObservedObject var fetch = ApiService()
    
    var body: some View {
        NavigationView{
                   ZStack{
                       VStack{
                           ForEach(fetch.datatotal){data in
                               //Kolom 1
                               HStack(spacing:10){
                                   
                                   HStack{
                                       Spacer()
                                       VStack{
                                           Image(systemName: "heart.fill").foregroundColor(Color.white)
                                           Text("Recover").font(.headline).foregroundColor(Color.white)
                                           Text("\(data.jumlah_sembuh)").font(.headline).foregroundColor(Color.white)
                                       }
                                       Spacer()
                                       }.frame(height:100).padding().background(Color.green).cornerRadius(20)
                                   
                                   HStack{
                                   Spacer()
                                   VStack{
                                       Image(systemName: "plus.circle.fill").foregroundColor(Color.white)
                                       Text("Positive").font(.headline).foregroundColor(Color.white)
                                       Text("\(data.jumlah_positif)").font(.headline).foregroundColor(Color.white)
                                   }
                                   Spacer()
                                   }.frame(height:100).padding().background(Color.blue).cornerRadius(20)
                               }
                               
                               //Kolom 2
                               HStack(spacing:10){
                                   HStack{
                                       Spacer()
                                       VStack{
                                           Image(systemName: "bed.double.fill").foregroundColor(Color.white)
                                           Text("Active Cases").font(.headline).foregroundColor(Color.white)
                                           Text("\(data.jumlah_dirawat)").font(.headline).foregroundColor(Color.white)
                                       }
                                       Spacer()
                                       }.frame(height:100).padding().background(Color.orange).cornerRadius(20)
                                   
                                   HStack{
                                   Spacer()
                                   VStack{
                                       Image(systemName: "waveform.path.ecg").foregroundColor(Color.white)
                                       Text("Death").font(.headline).foregroundColor(Color.white)
                                       Text("\(data.jumlah_meninggal)").font(.headline).foregroundColor(Color.white)
                                   }
                                   Spacer()
                                   }.frame(height:100).padding().background(Color.red).cornerRadius(20)
                               }
                               Spacer()
                           }
                       }.padding()
//                       Spacer()
                       //kondisional jika data belum terload
                       if(fetch.isLoading){
                           VStack{
                              
                               Indicator()
                               Text("Please Wait...")
                           }.padding().background(Color.white).cornerRadius(20).shadow(color: Color.secondary, radius: 20)
                       }
                   }
                   .navigationBarTitle("Covid19 Data")
               }
               
    }
}




struct Indicator : UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<Indicator>) -> UIActivityIndicatorView {
        let indi = UIActivityIndicatorView(style: .large)
        indi.color = UIColor.red
        return indi
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<Indicator>) {
        uiView.startAnimating()
    }
}


struct CovidDataApiExample_Previews: PreviewProvider {
    static var previews: some View {
        CovidDataApiExample()
    }
}
