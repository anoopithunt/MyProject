//
//  ProfileView.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 03/12/22.
//

import SwiftUI


struct UserAccountProfileView: View{
    
    @State var mainImage: String = "image"
    @State var profileImage: String = "Anoop"
    @State var qr: String = "Anoop"
    var body: some View{
        
        
        ZStack {
            Image("u").resizable()
            
            VStack{
                ZStack{
                    Image(mainImage).resizable()
                    VStack{
                        HStack{
                            Spacer()
                            
                            Button(action: {
                                
                                
                            }, label: {
                                
                                Image(systemName: "pencil").font(.system(size: 36, weight: .heavy))
                                    .frame(width: 70, height:70)
                                    .foregroundColor(.gray)
                                    .background(Color.white)
                                    .clipShape(Circle())
                            })
                            
                            
                           
                        }
                        Spacer()
                    }.padding()
                    
                }.frame(height: UIScreen.main.bounds.height*0.2)
              
                ProfileView(changeProfileImage: false, openCameraRoll: false, imageSelected:UIImage(imageLiteralResourceName: profileImage)).padding(-35).padding(.bottom, 35)
           
                VStack{
                    Image(qr).resizable().frame(width:125, height: 125).padding()
                    
                    Text("Your publisher profile QR code").foregroundColor(.black).bold()
                    Text("This is your publication profile qr code which when scanned by the user will directly take the when scanned by the user will directly take the user to your publication gallery and read your latest uploads.").foregroundColor(.black.opacity(0.6)).multilineTextAlignment(.center).padding().font(.system(size: 12))
                    
                }.background(Color.white).cornerRadius(6).padding(12).shadow(radius: 2)
                Spacer()
            }
        }
    }
}





struct ProfileView: View {
    
    @State var changeProfileImage = false
    @State var openCameraRoll = false
    @State var imageSelected = UIImage()
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {

                if changeProfileImage {
                    Image(uiImage: imageSelected)
                        .profileImageMod()
                } else {
                    Image("Anoop")
                        .profileImageMod()
                }

            Button(action: {
                changeProfileImage = true
                               openCameraRoll = true
            }, label: {
                Image(systemName: "camera.fill")
                    .frame(width: 30, height: 30)
                    .foregroundColor(.gray)
                    .background(Color.white)
                    .clipShape(Circle())
            })
            
            
        }
        .sheet(isPresented: $openCameraRoll) {
            ImagePicker(selectedImage: $imageSelected, sourceType: .photoLibrary)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserAccountProfileView()
    }
}





import SwiftUI
import UIKit


struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var selectedImage: UIImage
    @Environment(\.presentationMode) private var presentationMode
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        
        return imagePicker
        
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        //leave alone for right now
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
     
        var parent: ImagePicker
     
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
    
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
     
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image
            }
     
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
}
