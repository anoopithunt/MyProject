//
//  SubscribeView.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 18/02/23.
//

import SwiftUI

struct SubscribeView: View {
    @StateObject var list = GuestSubscribeViewModel()
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    @State private var selectedOption = 0
    let options = ["All Books", "Paid Books", "Prime Books"]
    @State var value = ""
    var placeholder = "All Books"
    
    @State var searchText: String = ""
    var body: some View {
        NavigationView{
            ZStack{
                Image("u").resizable().ignoresSafeArea()
                
                VStack(spacing:0){
                    HStack(spacing: 12) {
                        Button(action: {
                            //                        dismiss()
                            print("close")
                        }, label: {
                            Image(systemName: "arrow.backward")
                                .font(.system(size: 22, weight: .heavy))
                                .foregroundColor(.white)
                        })
                        
                        Text("Subscriptions")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(.white)
                        
                        Spacer()
                        Menu {
                            ForEach(options, id: \.self){ client in
                                Button(client) {
                                    
                                    self.value = client
                                    
                                    if self.value == "All Books"{
                                        
                                        list.getSubscribeData(booktype: "all")
                                        
                                    }
                                    
                                    else if self.value == "Paid Books" {
                                        
                                        list.getSubscribeData(booktype: "paid")
                                        
                                    }
                                    
                                    else if self.value == "Prime Books" {
                                        
                                        list.getSubscribeData(booktype: "prime")
                                        
                                    }
                                    
                                }
                                
                            }
                            
                        } label: {
                            HStack(spacing: 2){
                                
                                Text(value.isEmpty ? placeholder : value)
                                    .frame(width: 125)
                                
                                    .onAppear{
                                        
                                    }
                                    .foregroundColor(value.isEmpty ? .black : .black)
                                Image(systemName: "arrowtriangle.down.fill")
                                    .foregroundColor(Color.white)
                                    .font(Font.system(size: 12, weight: .semibold))
                                //.padding()
                            }
                            .padding()
                            
                            
                        }
                    }
                    .padding(.horizontal)
                    .frame(width: UIScreen.main.bounds.width, height: 65)
                    .background(Color("orange"))
                    ZStack{
                        
                        Rectangle()
                            .fill(Color("orange"))
                            .frame(height: 45)
                        
                        
                        TextField("search books", text: $searchText)
                            .font(.system(size: 24))
                            .padding()
                        
                            .foregroundColor(.gray)
                        
                            .frame(height: 35).background(Color.white)
                        
                            .cornerRadius(10)
                        
                            .padding(.horizontal,11)
                        
                            .overlay{
                                
                                HStack{
                                    
                                    Spacer()
                                    
                                    Image(systemName: "magnifyingglass")
                                    
                                        .font(.system(size: 26, weight: .heavy))
                                    
                                        .foregroundColor(.gray.opacity(0.7))
                                    
                                        .padding(.trailing,18)
                                    
                                }
                                .frame(height: 24)
                                
                            }
                        
                    }
                    
                    .frame(width: UIScreen.main.bounds.width, height: 45)
                    
                    
                    
                    ScrollView{
                        
                        LazyVGrid(columns: columns, spacing: 10){
                            
                            ForEach(list.datas , id: \.id){
                                item in
                                VStack(alignment: .leading){
                                    
                                    AsyncImage(url: URL(string: item.book_media.url!)){
                                        
                                        img in
                                        
                                        NavigationLink(destination: {
                                            PDFKitViews(id: item.book_media.id)
                                            
                                        }, label: {
                                            img.resizable()
                                            
                                                .frame( height: 225)
                                        })
                                        
                                    }placeholder: {
                                        Image("logo_gray")
                                            .resizable()
                                            .frame( height: 225)
                                    }
                                    Text(item.book_detail.title).foregroundColor(Color("default_"))
                                        .font(.system(size: 16, weight: .medium))
                                        .lineLimit(2)
                                    TimerView(endDateText: "\(item.rc_enddate)")//.frame(height: 45)
                                    
                                    HStack{
                                        if item.book_detail.is_prime == 0 {
                                            Text("Paid")
                                                .font(.system(size: 20, weight: .bold)).foregroundColor(Color("green"))
                                        }
                                        else{
                                            Text("Prime").font(.system(size: 20, weight: .bold)).foregroundColor(.cyan)
                                        }
                                        Spacer()
                                        Image("rc_read_book").resizable().frame(width: 35, height: 35)
                                    }.padding(.horizontal, 4)
                                    
                                }.background(Color.white).cornerRadius(8).shadow(color: .gray, radius: 1)
                                
                            }
                            
                        }
                    }
                    
                }
            }
            
            
            .overlay(alignment: .topTrailing){
               
                
            }
            
            .onAppear{
                list.getSubscribeData(booktype: "all")
                
            }
            
        }
        
    }
}



struct SubscribeView_Previews: PreviewProvider {
    static var previews: some View {
//        TimerExample(endDate: .now + 900)
        SubscribeView()
       
    }
}
//Model

// MARK: - SubscribeModel
public struct SubscribeModel:Decodable {
    public let userRCBooks: SubscribeUserRCBooks
    public let totalRc: SubscribeTotalRc
    public let type: String
    public let booktype: String
    public let bookSearch: String
    public let comment: String
    public let data: Int

}

// MARK: - SubscribeTotalRc
public struct SubscribeTotalRc:Decodable {
    public let id: Int
    public let total_rc: Int

}

// MARK: - SubscribeUserRCBooks
public struct SubscribeUserRCBooks:Decodable {
    public let current_page: Int
    public var data: [SubscribeDatum]
//    public let first_page_url: String
    public let per_page: Int
    public let to: Int?
    public let total: Int

}

// MARK: - SubscribeDatum
public struct SubscribeDatum:Decodable {
    public let id: Int
    public let partner_id: Int
    public let book_id: Int
    public let rc_enddate: String
    public let published: String
    public let status: Int
    public let book_media: SubscribeBookMedia
    public var book_detail: SubscribeBookDetail

}

// MARK: - SubscribeBookDetail
public struct SubscribeBookDetail:Decodable {
    public let id: Int
    public let upload_type_id: Int
    public let name: String
    public let pdf_url: String
    public let html_url: String
    public let title: String
    public let long_desc: String?
    public let meta_keyword: String?
    public let author_name: String?
    public let isbn_no: String?
    public let tot_view: Int
    public var publish_date: String
    public let source: String?
    public let is_prime: Int?
    public let validity_date: String
    public let book_partner_link: SubscribeBookPartnerLink

}

// MARK: - SubscribeBookPartnerLink
public struct SubscribeBookPartnerLink:Decodable {
    public let id: Int
    public let partner_id: Int
    public let book_id: Int

}

// MARK: - SubscribeBookMedia
public struct SubscribeBookMedia:Decodable {
    public let id: Int
    public let book_media_type_id: Int
    public let media_type_id: Int
    public let book_id: Int
    public let url: String?

}

// MARK: - Authenticatication class
class GuestSubscribeService{
    
    func getSubscribeData(token: String,booktype: String, completion: @escaping (Result<SubscribeModel, NetworkError>) -> Void) {  //https://alibrary.in/api/guest/userrcbooks?bookSearch=&page=&booktype=prime
        
        guard let url = URL(string: APILoginUtility.guestSubscribeApi! + "?bookSearch=&page=&booktype=\(booktype)") else {
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
            
            guard let response = try? JSONDecoder().decode(SubscribeModel.self, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            
            completion(.success(response))
            
        }.resume()
        
        
    }
    
}


//View model

class GuestSubscribeViewModel: ObservableObject{
   
    @Published var datas = [SubscribeDatum]()
    @Published var totalPage = Int()
//    @Published var currentPage = 1
    func getSubscribeData(booktype: String) {
        
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
        
        GuestSubscribeService().getSubscribeData(token: token, booktype: booktype){ (result) in
            switch result {
                case .success(let results):
                    DispatchQueue.main.async {
                        self.datas = results.userRCBooks.data
                        self.totalPage = results.userRCBooks.to ?? 0
//                        self.datas.append(contentsOf: results.studentStacks.data)
                      
                        print(self.datas)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
      
}




struct TimerExample1: View {
    @State var currentTime = Date.now
  @State var inputDate = "21-02-2023"
    
    var body: some View {
        Text("The time is: \(convertDateFormat(inputDate: inputDate))")
            .padding()
            .onAppear(perform: {
                Timer.scheduledTimer(withTimeInterval:1.0, repeats: true) {
                     time in
                    
                    currentTime = Date.now
                }
            })
         }
 
     func formatTime (date: Date) -> String {
         let formatter = DateFormatter()
         formatter.dateFormat = "dd-MM-yyyy" //2022-12-03 12:20:09
         let formattedDate = formatter.string(from: date)
         return formattedDate
     }
   func convertDateFormat(inputDate: String) -> String {

         let olDateFormatter = DateFormatter()
         olDateFormatter.dateFormat =   "dd-MM-yyyy" //"yyyy-MM-dd'T'HH:mm:ss"

         let oldDate = olDateFormatter.date(from: inputDate)

         let convertDateFormatter = DateFormatter()
         convertDateFormatter.dateFormat = "dd'd'-MM'm'-yyyy'y'"

         return convertDateFormatter.string(from: oldDate!)
    }
    
    
    
  }

func convertDateFormat(inputDate: String) -> Date {
let str = "2022-02-12"
      let olDateFormatter = DateFormatter()
      olDateFormatter.dateFormat =   "dd-MM-yyyy" //"yyyy-MM-dd'T'HH:mm:ss"

    _ = olDateFormatter.date(from: inputDate)
    
    let mySubstring = str.prefix(5)
    
    
      let convertDateFormatter = DateFormatter()
      convertDateFormatter.dateFormat = "dd'd'-MM'm'-yyyy'y'"
      print(mySubstring)
    return convertDateFormatter.date(from: inputDate)!//.string(from: oldDate!)
 }


struct TimerExample: View {
    
    let endDate: Date //= .now //convertDateFormat(inputDate: "21-02-2023")
    
    var body: some View {
        TimelineView(.periodic(from: .distantFuture, by: 1)) { context in
            VStack {
                Text("Time remaining:")
                Text(endDate, style: .timer)
                    .font(.title)
                Spacer()
            }
            .padding()
        }
        
    }
}

struct DateTimerView:View{

    @State private var endDateText = "25-12-2027"
        @State private var remainingTime = "Enter an end date"
        @State private var timer: Timer?
        
        var body: some View {
            VStack {
                TextField("Enter an end date", text: $endDateText, onCommit: startTimer)
                    .padding()
                
                Text(remainingTime)
                    .padding()
            }
            .onDisappear(perform: stopTimer)
        }
        
        func startTimer() {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            
            if let endDate = formatter.date(from: endDateText) {
                let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                    let currentDate = Date()
                    
                    let calendar = Calendar.current
                    let difference = calendar.dateComponents([.day, .hour, .minute, .second], from: currentDate, to: endDate)
                    
                    if difference.day! > 0 {
                        remainingTime = "\(difference.day!) d  \(difference.hour!) h \(difference.minute!) m \(difference.second!) s"
                    } else if difference.hour! > 0 {
                        remainingTime = "\(difference.hour!) h  \(difference.minute!) m \(difference.second!) s"
                    } else if difference.minute! > 0 {
                        remainingTime = "\(difference.minute!) m \(difference.second!) s"
                    } else {
                        remainingTime = "\(difference.second!) s"
                    }
                    
                    if currentDate >= endDate {
                        stopTimer()
                    }
                }
                
                self.timer = timer
            } else {
                remainingTime = "Invalid date format"
            }
        }
        
        func stopTimer() {
            timer?.invalidate()
            timer = nil
        }
}

