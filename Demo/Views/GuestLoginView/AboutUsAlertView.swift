//
//  AboutUsAlertView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 12/12/22.
//

import SwiftUI


struct AboutUsAlertView: View {
    @State var shown = false

    var body: some View {
        ZStack {
                VStack {
                    Image("1")
                        .resizable().frame(width: 300, height: 300).cornerRadius(200)
                   
                        Button("About Us ") {
                            shown.toggle()
                        }
                    
                    Spacer()
                }

            
            if shown {
                AboutUsView(isShown: $shown)
            }
            
        }
    }
    
}

struct AboutUsView_Previews: PreviewProvider {
    static var previews: some View {
        AboutUsAlertView()
    }
}

struct AboutUsView: View {
    @Binding var isShown: Bool
    @State private var isLoading = true
    let screenSize = UIScreen.main.bounds
  @State var list = String()
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .center, vertical: .center)) {
            Color(.gray).opacity(0.4).ignoresSafeArea()
            VStack{
            HStack{
                Image("ic_launcher").resizable().frame(width: 55, height: 55).cornerRadius(26)
                Text("About Us (v: 1.0.34)").font(.system(size: 22)).bold().foregroundColor(.white).padding(.leading)
                Spacer()
            }.padding()
                .padding(.leading)
                .frame(width: UIScreen.main.bounds.width*0.94, height: 90).background(Color("orange"))
            
            ScrollView(.vertical) {
                VStack {
                    if isLoading {
                       
                       VStack(alignment:.center){
                            Spacer()
                            CircleProgressView().padding()
                           Spacer()
                        }
                                                   
                                         
                    } else {
                        Text(html: list).padding()
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
                .background(Color.white.opacity(1))
                .clipShape(RoundedRectangle(cornerRadius: 4.0, style: .continuous))
                                        .animation(.spring(), value: isShown)

        }
            
            
        
       
    }
    
    func fetchApi(){
        let url = URL(string: "https://alibrary.in/api/about-us")
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if let data = data {
              if let results = try? JSONDecoder().decode(AboutUsModel.self, from: data){
                  DispatchQueue.main.async {
                    self.list = results.aboutus.description
                      self.isLoading = false    //for loading View shown
                      
                                     }
                }
               
            }
            
            
        }.resume()
    }
    
    
}



//Model of About Us Screen

public struct AboutUsModel:Decodable {
    public var aboutus: AboutUs


}

public struct AboutUs: Decodable {

    public let description: String


}
