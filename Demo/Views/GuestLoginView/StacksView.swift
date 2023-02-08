//
//  StacksView.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 05/12/22.
//

import SwiftUI
import AlertToast

struct StacksView: View {
    @Environment(\.dismiss) var dismiss
    @State var rotate: [Int] = [0, 10, -10]
    @State var index: Int = -1
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    @StateObject var list = StacksViewModel()
    @State var shown = false
    var body: some View {
        NavigationView {
            ZStack {
                Image("u").resizable()
                VStack(spacing: 6) {
                    HStack(spacing: 25){
                        Button(action: {
                            dismiss()
                        },
                               label: {
                            
                            Image(systemName: "arrow.backward")
                            
                                .font(.system(size:22, weight:.heavy))
                            
                                .foregroundColor(.white)
                        })
                        Text("Stacks")
                        
                            .font(.system(size: 22, weight: .heavy))
                            .foregroundColor(.white)
                        
                        Spacer()
                        Button(action: {
                            self.shown = true
                        }, label: {
                            Image("stack_add_blue_")
                                .resizable()
                                .frame(width: 45, height: 55)
                        })
                        
                    }.padding(9)
                      .frame(width: UIScreen.main.bounds.width, height: 65)
                        .background(Color("orange"))
                    
                    ScrollView{
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(list.datas, id: \.id){ item in
                                VStack(alignment: .center, spacing: 8){
                                    NavigationLink(destination: StackBookListView(id: item.stack_detail.id, name: item.stack_detail.name).navigationTitle("")
                                        .navigationBarHidden(true)
                                        .navigationBarBackButtonHidden(true), label: {
                                      ZStack{
                                          ForEach(item.stack_book_link.indices.reversed(), id: \.self) { index in
                                             
                                              AsyncImage(url: URL(string: item.stack_book_link[index].book_url)){ img in
                                                  img.resizable().frame(width: 125, height: 155)
                                                      .rotationEffect(Angle(degrees: Double(rotate[ index])))
                                                      .shadow(radius: 5)
                                              }placeholder: {
                                                  VStack{
                                                      Image("add_plus")//.resizable()
                                                  }.background(Color("gray")).frame(width: 145, height: 155)
                                                //.frame(width: 145, height: 155)
                                                 .rotationEffect(Angle(degrees: Double(rotate[ index])))
                                                      .shadow(radius: 0.3)
                                              }

                                          }
                                      }.frame(width: 140,height: 165,alignment: .center) .padding(12)
                                  })
                                   
                      
                                    HStack{
                                        Text(item.stack_detail.name).font(.system(size: 22)).padding(.leading,4).foregroundColor(Color("default_"))
                                        Spacer()
                                    }
                                    
                                    HStack(spacing: 6){
                                        Text("\(item.stack_book_link_count)").foregroundColor(.gray).font(.system(size: 16))
                                        Image("stack_blue").resizable().frame(width: 25, height: 20)
                                        Image(systemName: "eye.slash.fill").resizable().frame(width: 25, height: 20).foregroundColor(.gray)
                                        Spacer()
                                        Menu {
                                            Button {
                                                
                                            } label: {
                                                Label("Edit", systemImage: "square.and.pencil").foregroundColor(.green).font(.system(size: 22))
                                            }
                                            Button {
                                                
                                            } label: {
                                                Label("Delete", systemImage: "trash")
                                            }

                                        } label: {
                                            Image(systemName: "ellipsis")
                                                .font(.system(size: 22, weight: .bold)).foregroundColor(Color("default_")).rotationEffect(.degrees(90)).padding(.trailing)
                                        }
                                    }.padding(.bottom).padding(.leading,4)
                                   
                                }.background(Color("gray")).cornerRadius(12).frame(width: UIScreen.main.bounds.width/2.2).shadow(color: .gray.opacity(0.5),radius: 1).padding(.horizontal)
                            }

                        }.onAppear{
                            list.getStacksData()
                        }
                    }
                   
                    Spacer()
                }
                if shown{
                    StacksViewAlertView(rcShow: $shown)
                }
            }
           
        }
    }
}

struct StacksView_Previews: PreviewProvider {
    static var previews: some View {
        StacksView()
    
//        Stacks()
    }
}

struct StacksViewAlertView: View{
    @State private var selected = 0
    let labels = ["Public", "Private"]
    @State var pressed: Bool = false
    @Binding var rcShow: Bool
   @State private var isEditing = false
    let screenSize = UIScreen.main.bounds
    @State var text: String = ""
    @State var rupee: String = ""
    @State var selectedOption: String = ""
    
    var body: some View{
        ZStack {
            Color.black.opacity(0.5).ignoresSafeArea()
            VStack(alignment: .leading){
            HStack{
                Image("ic_launcher").resizable().frame(width: 55, height: 55).cornerRadius(12)
                Text("New Stack").font(.system(size: 22)).bold().foregroundColor(.white).padding(.leading)
                Spacer()
            }.padding()
                .padding(.leading)
                .frame(width: UIScreen.main.bounds.width*0.94, height: 90).background(Color("orange"))
           
                VStack (alignment: .leading){
                    CustomTextField(placeHolder: "Enter the Name", text: $text).padding(6)
                  
                    CustomTextField(placeHolder: "Enter the Description", text: $rupee).padding(6)
                   
                    Text("Make your stack").foregroundColor(.black).font(.system(size:22)).padding(.leading)
                    VStack(alignment: .leading){
                        HStack(spacing: 2) {
                            ForEach(0..<labels.count) { index in
                                RadioButton(selected: self.$selected, index: index, label: self.labels[index])
                            }
                        }.padding()
                        if selected == 1 {
                 
                                Button(action: {
                                    pressed.toggle()
                                }, label: {
                                    HStack{
                                        Image(systemName: !pressed ? "square" : "checkmark.square.fill")//.padding()
                                            .font(.system(size: 28))
                                            .foregroundColor(.black)
                                        Text("**I Agree**")
                                            .multilineTextAlignment(.leading).foregroundColor(.black)//.bold()
                                    }.padding(.leading,4)
                                })
                              
                            Text("Dear User,please note that if you have fully organized your stack and all book content placed in it matches your title according to you, You may allow it to be publicly placed in the public media. Please note that if the content you put in this type does not match your original title,then the library may block it and unnecessarily cancle your stack as aviolation.\nNote: Books placed in the stack will not appear in the public stack if the number is less than 3.").font(.system(size: 14)).foregroundColor(.black).padding(.leading, 38)
           
                        }
                    }
                    HStack(alignment: .top){
                        Spacer()
                        Button(action: {
                                            self.rcShow = false
                            
                        }){
                            Text("Cancel").font(.headline)
                                .frame(width: 116, height: 45, alignment: .center)
                                .background(Color("default_"))
                                .foregroundColor(.white)
                                .cornerRadius(33)
                        }//.padding(12)
                        Button(action: {
                                           
                            
                        }){
                            Text("Create").font(.headline)
                                .frame(width: 116, height: 45, alignment: .center)
                                .background(self.pressed ? Color("default_") : Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(33)
                        }
                    }.padding(.trailing)
                    
                    
               
                }.padding(4)
            
            
        }
            .frame(width: screenSize.width * 0.9, height: .infinity)
                .background(Color.white.opacity(1))
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                                        .animation(.spring(), value: rcShow)

        }
       
    }
    }

struct StacksViewTile: View{
   
    
    @State var title:String = "Gynomaical"
    @State var image:String = "http://www.softlogic.co.in/images/software/online.jpg"
    @State var stacks:String = "7"
    var body: some View{
        VStack(alignment: .center, spacing: 8){
            ZStack{
                AsyncImage(url: URL(string: "https://storage.googleapis.com/pdffilesalib/pdf/thumbnail/Nutrition_Concepts_And_Controversies_20220201143904_11/1.png")){
                    image in
                    image.resizable().rotationEffect(Angle(degrees: -10))
                        .frame(width: 125,height: 155)
                        .padding(5)
                }placeholder: {
                    Image("soft").resizable().rotationEffect(Angle(degrees: -10))
                        .frame(width: 125,height: 155)
                        .padding(5)
                }
                AsyncImage(url: URL(string: "https://storage.googleapis.com/pdffilesalib/pdf/thumbnail/Ramayan_Ke_Amar_Patra_-_Maryada_Purushottam_Shri_Ram_%28Hindi_Edition%29_20220926174957_11/1.png")){
                    image in
                    image.resizable().rotationEffect(Angle(degrees: 10))
                        .frame(width: 125,height: 155)
                        .padding(5)
                }placeholder: {
                    Image("bg_black").resizable().rotationEffect(Angle(degrees: 10))
                        .frame(width: 125,height: 155)
                        .padding(5)
                }
                AsyncImage(url: URL(string: "https://storage.googleapis.com/pdffilesalib/pdf/thumbnail/Life-Sciences_part-2-CSIR-JRF-NET-GATE-DBT_20221004210526_128/1.png")){
                    image in
                    image.resizable().rotationEffect(Angle(degrees: 0))
                        .frame(width: 125,height: 155)
                        .padding(5)
                }placeholder: {
                    Image("Anoop").resizable()//.rotationEffect(Angle(degrees: 0))
                        .frame(width: 125,height: 155)
                        .padding(5)
                }
            }.frame(width: 130,height: 165,alignment: .center) .padding(5)

            HStack{
                Text(title).font(.system(size: 22)).padding(.leading).foregroundColor(Color("default_"))
                Spacer()
            }
            
            HStack(spacing: 6){
                Text(stacks).foregroundColor(.gray).font(.system(size: 16))
                Image("stack_blue").resizable().frame(width: 25, height: 20)
                Image(systemName: "eye.slash.fill").resizable().frame(width: 25, height: 20).foregroundColor(.gray)
                Spacer()
                Menu {
                    Button {
                        
                    } label: {
                        Label("Edit", systemImage: "square.and.pencil").foregroundColor(.green).font(.system(size: 22))
                    }
                    Button {
                        
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }

                } label: {
                    Image(systemName: "ellipsis")
                        .font(.system(size: 22, weight: .bold)).foregroundColor(Color("default_")).rotationEffect(.degrees(90)).padding(.trailing)
                }
            }.padding(.bottom).padding(.leading,4)
           
        }.background(Color("gray")).cornerRadius(12).frame(width: UIScreen.main.bounds.width/2.2).shadow(color: .gray.opacity(0.5),radius: 1).padding(.horizontal)
    }
}

//import Foundation
public struct StacksModel:Decodable {
    public let studentStacks: StudentStacks
}


public struct StudentStacks:Decodable {
    public let data: [StacksDatum]
    public let total: Int
}

public struct StacksDatum:Decodable {
    public let id: Int
    public let stack_book_link: [StackBookLink]
    public let bookcount: Int
    public let stack_book_link_count: Int
    public let stack_detail: StackDetail

   
}

public struct StackBookLink :Decodable{
    public let id: Int
    public let book_url: String
    public let stack_book: StackBook

}

public struct StackBook:Decodable {
    public let id: Int
    public let name: String
    public let title: String
    public let author_name: String
    public let isbn_no: String
    
}

public struct StackDetail:Decodable {
    public let id: Int
    public let name: String
    public let description: String
  
   
}

// View Model of Stacks for get Authentication
class StacksService{
    
    func getStacksData(token: String, completion: @escaping (Result<StacksModel, NetworkError>) -> Void) {
        
        guard let url = URL(string: APILoginUtility.studentStacksApi!) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(.noData))
                return
            }
            
            guard let response = try? JSONDecoder().decode(StacksModel.self, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            
            completion(.success(response))
            
        }.resume()
        
        
    }
    
}


// Stacks View Model for data fetching


class StacksViewModel: ObservableObject{
   
    @Published var datas = [StacksDatum]()
//    @Published var revimage: [String] = []
    @Published var image: [String] = []
    @Published var totalPage = Int()
    @Published var currentPage = 1
    func getStacksData() {
        
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
        
        StacksService().getStacksData(token: token){ (result) in
            switch result {
                case .success(let results):
                    DispatchQueue.main.async {
                        self.datas = results.studentStacks.data
                        self.totalPage = results.studentStacks.total
//                        self.datas.append(contentsOf: results.studentStacks.data)
                        for data in self.datas {
                            for imgdata in data.stack_book_link.reversed(){
                                self.image.append(imgdata.book_url)
                             
                            }
//                            self.image =  self.revimage.reversed()
                            
                        }
                        print(self.datas)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
      
}

struct TooltipText: View {
    @State private var isActive = false
    
    let text: String
    let helpText: String
    var body: some View {
        Text(isActive ? helpText : text)
            .padding( isActive ? 6 : 0)
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 3)
                    .stroke(Color.blue, lineWidth: isActive  ? 2 : 0)
            )
            .animation(.easeInOut(duration: 1) )
            .gesture(DragGesture(minimumDistance: 0)
                        .onChanged( { _ in isActive = true } )
                        .onEnded( { _ in isActive = false } )
            )
    }
}


struct Stacks: View{

    @State var rotate: [Int] = [0, 10, -10]
       @State var index: Int = -1
       @StateObject var list = StacksViewModel()
       
       var body: some View{
           
           VStack(spacing: 35){
               ForEach(list.datas, id: \.id) { item in
                   ZStack{
                       ForEach(item.stack_book_link.indices.reversed(), id: \.self) { index in
                           AsyncImage(url: URL(string: item.stack_book_link[index].book_url)){ img in
                               img.resizable().frame(width: 125, height: 155)
                                   .rotationEffect(Angle(degrees: Double(rotate[ index])))
                                   .shadow(radius: 5)
                           }placeholder: {
                               Image("u").resizable().frame(width: 125, height: 155).rotationEffect(Angle(degrees: Double(rotate[ index])))
                                   .shadow(radius: 5)
                           }

                       }
                   }
               }
           }
           .onAppear{
               list.getStacksData()
           }
       }
    
}



struct RadioButton: View {
    @Binding var selected: Int
    let index: Int
    let label: String

    var body: some View {
        HStack {
            Text(label)
            
            Image(systemName: selected == index ? "largecircle.fill.circle" : "circle")
                .foregroundColor(.black)
            Spacer()
        }
        .onTapGesture {
            self.selected = self.index
        }
    }
}

struct RadioButtonGroup: View {
    @State private var selected = 0
    @State  var labels = ["Public", "Private"]
    @State var pressed: Bool = false
    
    init( labels: [String]  = ["Public", "Private"]) {

        self.labels = labels

    }
    var body: some View {
        VStack(alignment: .leading){
            HStack(spacing: 2) {
                ForEach(0..<labels.count) { index in
                    RadioButton(selected: self.$selected, index: index, label: self.labels[index])
                }
            }.padding()
            if selected == 1 {
                HStack{
                    Button(action: {
                        pressed.toggle()
                    }, label: {
                        Image(systemName: !pressed ? "square" : "checkmark.square.fill").font(.system(size: 28)).foregroundColor(.black)
                        
                    })
                    Text("I Agree").bold()
                }.padding(.leading,4)
                Text("Views and their content in SwiftUI depend on the value of state properties quite often. Images views are no exception, so we’ll introduce a new state property here that we’ll use in order to determine the image to display.").padding(.leading, 35)

            }
        }
    }
}

