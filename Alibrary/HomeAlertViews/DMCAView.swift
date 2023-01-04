//
//  DMCAView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 01/11/22.


import SwiftUI
import RichText

struct DMCAAlertView: View {
    @State var shown = false

    var body: some View {
        ZStack {
                VStack {
                    Image("4")
                        .resizable().frame(width: 300, height: 300).cornerRadius(200)
                    VStack {
                        Spacer()
                        Button("About Us ") {
                            shown.toggle()
                        }
                    }
                    Spacer()
                }

            
            if shown {
                DMCAView(isShown: $shown)
            }
            
        }
    }
    
}

struct DMCAView_Previews: PreviewProvider {
    static var previews: some View {
        DMCAAlertView()
    }
}

struct DMCAView: View {
    @Binding var isShown: Bool
    @State private var isLoading = true
    let screenSize = UIScreen.main.bounds
  @State var list = String()
    var body: some View {
        
        ZStack {
            Color(.black).opacity(0.4).frame(height: screenSize.height).ignoresSafeArea()
            VStack{
            HStack{
                Image("ic_launcher").resizable().frame(width: 55, height: 55).cornerRadius(26)
                Text("DMCA (v: 1.0.36)").font(.system(size: 22)).bold().foregroundColor(.white).padding(.leading)
                Spacer()
            }.padding()
                .padding(.leading)
                .frame(width: UIScreen.main.bounds.width*0.94, height: 90).background(Color("orange"))
            
            ScrollView(.vertical) {
                VStack {
                    if isLoading {
                       
                        
                        Spacer(minLength: 234)
                        CircleProgressView().padding()
                                                   
                                         
                    } else {
//                        Text(html: list).padding()
                        RichText(html: list).padding()
                        HStack{
                            Spacer()
                            Button(action: {
                                                            self.isShown = false
                                
                            }){
                                Text("Okay").font(.headline)
                                    .frame(width: 116, height: 45, alignment: .center)
                                    .background(Color("default_"))
                                    .foregroundColor(.white)
                                    .cornerRadius(33)
                            }.padding(23)
                        }
                    }
                   
                    
                }
                .onAppear{
                    fetchApi()
                }
            }
            
            
        }
                .frame(width: screenSize.width * 0.9, height: screenSize.height * 0.9)
                .background(Color("white").opacity(1))
                .clipShape(RoundedRectangle(cornerRadius: 4.0, style: .continuous))
//                                        .offset(y: isShown ? 0 : screenSize.height)
                                        .animation(.spring(), value: isShown)
//                                    .shadow(color: .gray, radius: 50, x: 9, y: 9)
        }
            
            
        
       
    }
    
    func fetchApi(){
        let url = URL(string: "https://alibrary.in/api/dmca")
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if let data = data {
              if let results = try? JSONDecoder().decode(DMCAModel.self, from: data){
                  DispatchQueue.main.async {
                    self.list = results.dmca.description
                      self.isLoading = false    //for loading View shown
                      
                                     }
                }
               
            }
            
            
        }.resume()
    }
    
    
}



//Model of About Us Screen

public struct DMCAModel:Decodable {
    public var dmca: DMCA


}

public struct DMCA: Decodable {

    public let description: String


}
