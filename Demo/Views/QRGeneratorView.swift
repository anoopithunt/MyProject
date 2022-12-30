//
//  QRGeneratorView.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 19/01/23.
//

import SwiftUI
//import Firebase
//import FirebaseFirestore

struct QRGeneratorView: View {
//    @State var data: [String: Any] = [:]
//    let db = Firestore.firestore()
//    init(){
//        let collectionRef = db.collection("myCollection")
//        collectionRef.addSnapshotListener { (querySnapshot, error) in
//            if let error = error {
//                print("Error getting documents: \(error)")
//            } else {
//                for document in querySnapshot!.documents {
//                    let data = document.data()
//                    print(data)
//                }
//            }
//        }
//        self.data = data
//    }
    

    @State var qrURL = "https://alibrary.page.link/?link=https://alibrary.page.link/publisher?id=5&apn=com.primeitzen.alibrary"
    var body: some View {
        VStack {
            TextField("Enter code", text: $qrURL)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding().hidden()
           
            Image(uiImage: UIImage(data: getQRCodeDate(text: "Anoop Mishra")!)!)
                .resizable()
                .frame(width: 200, height: 200)
        }
    }
    
    func getQRCodeDate(text: String) -> Data? {
        let filter = CIFilter(name: "CIQRCodeGenerator")!
        let data = Data(qrURL.utf8)
        filter.setValue(data, forKey: "inputMessage")
        let createCIImage = filter.outputImage!
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        let scaledCIImage = createCIImage.transformed(by: transform)
        let createUIImage = UIImage(ciImage: scaledCIImage)
        return createUIImage.pngData()!
        
    }
}

struct QRGeneratorView_Previews: PreviewProvider {
    static var previews: some View {
        QRGeneratorView()
    }
}
