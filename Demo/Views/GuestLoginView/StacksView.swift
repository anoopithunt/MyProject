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
                VStack(spacing: 0) {
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

                                StacksViewTile(title: item.stack_detail.name,stacks: "\(item.stack_book_link_count)")
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
       
//        RadioButton()
    }
}

struct StacksViewAlertView: View{
    @Binding var rcShow: Bool
    @State private var isSelected = true
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

                    FloatingTextField(placeHolder: "Enter the Name", text: $text).padding()
                    FloatingTextField(placeHolder: "Enter the Description", text: $rupee).padding()
                    Text("Make your stack").foregroundColor(.black).font(.system(size:22)).padding(.leading)
                   
                    
                    
                    HStack{
                        Spacer()
                        Button(action: {
                                            self.rcShow = false
                            
                        }){
                            Text("Cancel").font(.headline)
                                .frame(width: 116, height: 45, alignment: .center)
                                .background(Color("default_"))
                                .foregroundColor(.white)
                                .cornerRadius(33)
                        }.padding(12)
                        Button(action: {
                                           
                            
                        }){
                            Text("Create").font(.headline)
                                .frame(width: 116, height: 45, alignment: .center)
                                .background(Color("default_"))
                                .foregroundColor(.white)
                                .cornerRadius(33)
                        }.padding(.trailing)
                    }
                    
           
               
            }
            
            
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
//            AsyncImage(url: URL(string: image)){
//                image in
//                image.resizable()
//                    .frame(height: 155)
//                    .padding(5)
//            }placeholder: {
//                Image("add_stack")
//                    .resizable()
//                    .frame(height: 155)
//                    .padding(5)
//            }
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

// Radio Button Design
struct RadioButtonField: View {
    let id: String
    let label: String
    let size: CGFloat
    let color: Color
    let textSize: CGFloat
    let isMarked:Bool
    let callback: (String)->()
    
    init(
        id: String,
        label:String,
        size: CGFloat = 20,
        color: Color = Color.black,
        textSize: CGFloat = 22,
        isMarked: Bool = false,
        callback: @escaping (String)->()
        ) {
        self.id = id
        self.label = label
        self.size = size
        self.color = color
        self.textSize = textSize
        self.isMarked = isMarked
        self.callback = callback
    }
    
    var body: some View {
        Button(action:{
            self.callback(self.id)
        }) {
            HStack(alignment: .center, spacing: 10) {
                Image(systemName: self.isMarked ? "largecircle.fill.circle" : "circle")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: self.size, height: self.size)
                Text(label)
                    .font(Font.system(size: textSize))
                Spacer()
            }.foregroundColor(self.color)
        }
        .foregroundColor(Color.white)
    }
}


enum Gender: String {
    case male = "Male"
    case female = "Female"
}

struct RadioButtonGroups: View {
    let callback: (String) -> ()
    
    @State var selectedId: String = ""
    
    var body: some View {
      HStack {
          radioMaleMajority
            radioFemaleMajority
        
        }
    }
    
    var radioMaleMajority: some View {
        RadioButtonField(
            id: Gender.male.rawValue,
            label: Gender.male.rawValue,
            isMarked: selectedId == Gender.male.rawValue ? true : false,
            callback: radioGroupCallback
        )
    }
    
    var radioFemaleMajority: some View {
        RadioButtonField(
            id: Gender.female.rawValue,
            label: Gender.female.rawValue,
            isMarked: selectedId == Gender.female.rawValue ? true : false,
            callback: radioGroupCallback
        )
    }
    
    func radioGroupCallback(id: String) {
        selectedId = id
        callback(id)
    }
}

//import AlertToast

struct RadioButton: View {
    @State private var showToast = false
    var body: some View {
        VStack(alignment: .leading){
            Button(action: {
                self.showToast.toggle()
            }, label: {
                Text("Gender")
                    .font(Font.headline)
            })
          
            RadioButtonGroups { selected in
                print("Selected Gender is: \(selected)")
            }
           
        }.padding()
            .toast(isPresenting: $showToast, duration: 2, tapToDismiss: true, alert: {

                AlertToast(displayMode: .hud, type: .regular, title: "This is Toast Message here we alert the toast..")
            })
    }
}

// View Model of Stacks for get uthentication
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
    @Published var images = [StackBookLink]()
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
                        //self.images = results.studentStacks.data.
                        self.totalPage = results.studentStacks.total
//                        self.datas.append(contentsOf: results.studentStacks.data)
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
