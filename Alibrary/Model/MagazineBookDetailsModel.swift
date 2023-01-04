//
//  MagazineBookDetailsModel.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 07/11/22.
//

import Foundation
import SwiftUI

struct MagazinesView: View {
    @State var searchText: String = ""
    var columns: [GridItem] {
        [GridItem(.flexible()),
       GridItem(.flexible())]
    }
    @Environment(\.dismiss) var dismiss
//    @StateObject var list = MagazineBookDetailsVm()
    @ObservedObject var listData: MagazineBookDetailsViewModel

    init(){
   
         listData = MagazineBookDetailsViewModel()
    }
    var body: some View {
        VStack(spacing: 2){
            
            HStack{
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "arrow.left").font(.title).foregroundColor(.white).font(.system(size: 22)).padding()
                })
                
                
                Text("Magazines").font(.system(size: 28)).bold().foregroundColor(.white)
                Spacer()
            }.frame(width: UIScreen.main.bounds.width,height: 75).background(Color.orange)
            SearchBar(searchText: $searchText)
     
            ScrollView {
                
                LazyVGrid(columns: columns)  {
                    ForEach(0..<(listData.data.count), id: \.self){ i in
                        
                          if i == self.listData.data.count-1{

                              MagazineDataCellView(data: self.listData.data[i], isLast: true, listData: self.listData)


                          }
                          else{
                              MagazineDataCellView(data: self.listData.data[i], isLast: false, listData: self.listData )
                              
                          }
                    }
                }
              }
    }
}
    
}

struct MagazinesView_Previews: PreviewProvider {
    static var previews: some View {
        MagazinesView()
    }
}







//Model of MagazineBooksDetails



import Foundation

public struct MagazineBookDetailsModel: Decodable {
    public let bookDetails: MagazineBookDetails

}

// MARK: - MagazinesBookDetails
public struct MagazineBookDetails: Decodable {
    public let data: [MagazineData]
    public let last_page: Int
    public let current_page: Int
    public let next_page_url: String?
    public let path: String
    public let per_page: Int

}



public struct MagazineData: Decodable {
    public let id: Int
    public let tot_pages: Int
    public let author_name: String
    public let title: String
    public let tot_view: Int
    public let created_by: Int
    public let published: String
    public let category_name: String
    public let publisherName: String
    public let totalLikes: Int
    public let url: String

}
 






