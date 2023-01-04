//
//  MagazinePageApi.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 07/11/22.
//

import SwiftUI



struct MagazinePageApi: View{
  
    var body: some View{
        NavigationView{
          
            
            
            MagazinesPaginationScrollView()
           
                .navigationBarTitle("Pagination Magazines ScrollView")
                
        }
    }
}

struct MagazinePageApi_Previews: PreviewProvider {
    static var previews: some View {
        MagazinePageApi()
            
    }
}



struct MagazinesPaginationScrollView:View{
    var items: [GridItem] {
        Array(repeating: .init(.adaptive(minimum: 180)), count: 2)
      }
    @ObservedObject var listData: MagazineBookDetailsViewModel

    init(){
   
         listData = MagazineBookDetailsViewModel()
    }
    
   
    var body: some View{
      ScrollView {
          
          LazyVGrid(columns: items)  {
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



struct MagazineDataCellView: View{
     var isLoading = true
    
    var data: MagazineData
    var isLast: Bool
    @StateObject var listData:MagazineBookDetailsViewModel
    var body: some View{
        VStack{
            if isLast{
                  
                AsyncImage(url: URL(string: data.url)){ image in


                        image
                        .resizable().scaledToFit().cornerRadius(12)}placeholder: {
             
                    
                    CircleProgressView().frame(width: 65,height: 65)
                }
                    

                    .onAppear{
                       
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                         
                            if self.listData.data.count != self.listData.totalPage{
                                self.listData.updateData()
                            }
                        }
                    }
                
              
            }
            else{
                
                MagazinesTemplateView(imgUrl: data.url, authorName: data.title, publisherName: data.publisherName, published: data.published, totalLikes: data.totalLikes)
             

            }
        }

        .padding(.horizontal, 2)
    }

}
