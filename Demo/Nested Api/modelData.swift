//
//  modelData.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 20/08/22.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let temperatures = try? newJSONDecoder().decode(Temperatures.self, from: jsonData)
import SwiftUI
import Foundation
import UIKit
// MARK: - Userslist

struct Publisher: Codable{
    var userslist: [Userslist]?
}

public struct Userslist: Codable {
    public var id = UUID()
    public let userData: UserData?
    public let fullName: String?
    public let totalBooks: Int?
    public let totalBookViews: String?
    public let totalfollowers: Int?

    


    }

// MARK: - UserData
public struct UserData: Codable {
    public let id: Int
    public let name: String
    public let username: String
    public let email: String

    }





class ModelViewClass: UIViewController, ObservableObject{
    
    @Published var results: Publisher
//    init(){
//        self.viewDidLoad()
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .orange
        let urlString = "https://alibrary.in/api/publisherList"
         let url = URL(string: urlString)
         guard url != nil else{
             return
         }
         let session = URLSession.shared
         let dataTask = session.dataTask(with: url!){ (data, response, error) in
             if error == nil && data != nil {
                 
                 
                 let decoder = JSONDecoder()
                 do{
                     let publisher = try decoder.decode(Publisher.self, from: data!)
                     print(publisher)
                 }
                 catch{
                     print("ERROR in JSON parsing")
                 }
             }
             
             
             
         }
         dataTask.resume()
        
    }
}



//
  

//import PDFKit


struct APIDatas: View {
    

//    @ObservedObject var result = ModelViewClass()!
    
   
    var body: some View {
        
        
//        ForEach(result.results.userslist!, id: \.id){ item in
//
//        ForEach(results.userslist in item)
            VStack {
//
//                Text(item.fullName ?? "hello")
                Text("item.fullAddress")
            }
        }
}
//}

struct APIDatas_Previews: PreviewProvider {
    static var previews: some View {
        APIDatas()
    }
}
