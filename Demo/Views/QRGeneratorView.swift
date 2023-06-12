//
//  QRGeneratorView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 19/01/23.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct QRGeneratorView: View {

    @State var qrURL = "https://alibrary.page.link/?link=https://alibrary.page.link/publisher?id=5&apn=com.primeitzen.alibrary"
    var body: some View {
        VStack {
            Image(uiImage: UIImage(data: getQRCodeDate(text: qrURL)!)!)
                .resizable()
                .frame(width: 200, height: 200)
            QRCodeView(text: qrURL).frame(width: 200, height: 200)
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

struct QRCodeView: View {
    let text: String
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        Image(uiImage: generateQRCode(from: text))
            .interpolation(.none)
            .resizable()
            .scaledToFit()
    }
    
    func generateQRCode(from string: String) -> UIImage {
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")
        if let outputImage = filter.outputImage {
            if let cgImage = CIContext().createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}
