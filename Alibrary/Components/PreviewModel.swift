//
//  PreviewModel.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 10/07/22.
//

import SwiftUI

struct PreviewsModel: View {


    @State var authorName: String
    @State var Published: String
    @State var Pages: Int
    var body: some View {
        ZStack{
            Image("u")


        VStack {
            Image("13")
                .resizable()
                .cornerRadius(22)
                .frame(width: UIScreen.main.bounds.width/1.8, height: 333, alignment: .center)
                .shadow(radius: 12)
                .padding()
            VStack(alignment: .leading, spacing: 7) {
                HStack(spacing: 24){
                    Text("Author")
                        .font(.system(size: 22))
                    Spacer()
                    Text(authorName)
                        .foregroundColor(.gray)
                        .bold()


                }
                .padding(.horizontal)
                Spacer()

                HStack(spacing: 24){
                    Text("Published")
                        .font(.system(size: 22))
                    Spacer()
                    Text(Published)
                        .foregroundColor(.gray)
                        .bold()


                }
                .padding(.horizontal)
                Spacer()
                HStack(spacing: 24){
                    Text("Pages")
                        .font(.system(size: 22))
                    Spacer()
                    Text(String(Pages))
                        .foregroundColor(.gray)
                        .bold()


                }
                .padding(6)


                }
                .frame(width: UIScreen.main.bounds.width*0.9, height: 143)
                .background(Color.white)

                .cornerRadius(24)
                .shadow(radius: 2)
                .padding()
//            Spacer()
            ButtonView(btnName: "Preview")
                .padding(.top,35)





        }.frame(width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height)


        }
//        Spacer()

    }
}

struct PreviewsModel_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PreviewsModel(authorName: "India Today", Published: "January", Pages: 122)
            Spacer()
        }
        
    }
}
