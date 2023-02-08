//
//  GuestDraftView.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 26/02/23.
//

import SwiftUI

struct GuestDraftView: View {
    var body: some View {
        
        
        NavigationView{
            ZStack{
                Image("u").resizable()
                //                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .ignoresSafeArea()
                
                VStack(spacing: 0){
                    ScrollView{
                        HStack(spacing: 25){
                            Button(action: {
                                
                            },
                                   label: {
                                
                                Image(systemName: "arrow.backward")
                                    .font(.system(size:22, weight:.heavy))
                                    .foregroundColor(.white)
                            })
                            Text("Upload List")
                                .font(.system(size: 22, weight: .medium))
                                .foregroundColor(.white)
                            Spacer()
                            Image("cloud_screen")
                                .resizable()
                                .frame(width: 30, height: 25)
                            
                        }.padding(.horizontal)
                            .frame(width: UIScreen.main.bounds.width, height: 65)
                            .background(Color("orange"))
                        
                        VStack{
                            AsyncImage(url: URL(string: "")){img in
                                img.resizable()
                                    .frame(width: UIScreen.main.bounds.width/2.3, height: 215)
                            }placeholder: {
                                Image("logo_gray")
                                    .resizable()
                                    .frame(width: UIScreen.main.bounds.width/2.3, height: 215)
                            }
                            Rectangle()
                                .foregroundColor(.black)
                                .frame(height: 2)
                            Text("title")
                        }.background(Color("gray"))
                            .padding()
                            .frame(width: UIScreen.main.bounds.width/2.25, height: 215)
                    }
                Spacer()
                }
            }
        }
    }
}

struct GuestDraftView_Previews: PreviewProvider {
    static var previews: some View {
        GuestDraftView()
    }
}



// MARK: - Welcome
public struct Welcome {
    public let bookDetails: BookDetails

}

// MARK: - BookDetails
public struct BookDetails {
    public let currentPage: Int
    public let data: [Datum]
    public let to: Int
    public let total: Int

}

// MARK: - Datum
public struct Datum {
    public let id: Int
    public let html_url: String
    public let tot_pages: Int
    public let title: String
    public let url: String
    public let book_media: BookMedia

}

// MARK: - BookMedia
public struct BookMedia {
    public let id: Int
    public let book_id: Int
    public let url: String
    public let created_by: Int

}
