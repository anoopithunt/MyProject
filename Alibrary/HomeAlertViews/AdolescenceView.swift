//
//  AdolescenceView.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 01/11/22.
//


import SwiftUI
import RichText

struct AdolscencesAlertView: View {
    @State var shown = false
    var body: some View {
        ZStack {
                VStack {
                    Image(systemName: "person.fill")
                        .resizable().frame(width: 300, height: 300).foregroundColor(Color(hex: colorsList.randomElement() ?? "#8557a0"))
                    VStack {
                        Button("Privacy Alert Button") {
                            shown.toggle()
                        }
                    }
                    Spacer()
                }.blur(radius: shown ? 30 : 0)
            
            if shown {
                AdolescenceView(isShown: $shown)
            }
            
        }
    }
}

struct AdolscencesAlertView_Previews: PreviewProvider {
    static var previews: some View {
        AdolscencesAlertView()
    }
}




struct AdolescenceView: View {
    @Binding var isShown: Bool
    let screenSize = UIScreen.main.bounds
    @State private var isLoading = true
  @State var list = String()
    var body: some View {
        VStack{
        HStack{
            Image("ic_launcher").resizable().frame(width: 55, height: 55).cornerRadius(4)
            Text("Adolescence(v: 1.0.34)").font(.system(size: 22)).bold().foregroundColor(.white).padding(.leading)
            Spacer()
        }.padding()
            .padding(.leading,12)
            .frame(width: UIScreen.main.bounds.width*0.94, height: 90).background(Color("orange"))
        
        ScrollView(.vertical) {
            VStack {
                if isLoading{
                    HStack(alignment: .center){
                        CircleProgressView().padding()
                    }
           
                }
                else{
                    
//                    Text(html: list).padding()
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
        
        
    }.padding(.top,-5)
            .frame(width: screenSize.width * 0.9, height: screenSize.height * 0.9)
            .background(Color("white").opacity(1))
            .clipShape(RoundedRectangle(cornerRadius: 4.0, style: .continuous))
                                    .offset(y: isShown ? 0 : screenSize.height)
                                    .animation(.spring(), value: isShown)
            .shadow(color: .gray, radius: 50, x: 9, y: 9)
            
            
        
       
    }
    
    func fetchApi(){
        let url = URL(string: "https://www.alibrary.in/api/Adolescence")
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if let data = data {
              if let results = try? JSONDecoder().decode(AdolescenceModel.self, from: data){
                  DispatchQueue.main.async {
                    self.list = results.adolescence.description
                      self.isLoading = false
                                     }
                }
               
            }
            
            
        }.resume()
    }
    
    
}


//Model of Adolescence View
public struct AdolescenceModel:Decodable {
    public var adolescence: Adolescence


}

public struct Adolescence: Decodable {

    public let description: String


}
