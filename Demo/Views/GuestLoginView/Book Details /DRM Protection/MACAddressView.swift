//
//  MACAddressView.swift
//  Demo
//
//  Created by Anup Mishra on 31/05/23.
//

import SwiftUI
import Network
import AVFoundation

/// In this View I am trying to fetch the data MAC Addresss of device and Device model Name and Restrict of Screen shot Capturing.

struct MACAddressView: View {
    @StateObject var list = DrmProtectionViewModel()
    @State private var interfaceName: String = ""
    @State private var interfaceType: NWInterface.InterfaceType = .other
    @State private var ipAddress: String = ""
    let device = UIDevice.current
    let monitor = NWPathMonitor()
    @State private var isScreenshotTaken = false
    var body: some View {
        ZStack {
           (Color.cgGreen).ignoresSafeArea()
            
            VStack(alignment: .leading){
                ScrollView{
                    
                    VStack {
                        Text("Interface Name: \(interfaceName)")
                    }
                    .onAppear {
                        monitor.pathUpdateHandler = { path in
                            if let interface = path.availableInterfaces.first {
                                DispatchQueue.main.async {
                                    self.interfaceName = interface.name
                                    self.interfaceType = interface.type
                                }
                            }
                        }
                        let queue = DispatchQueue(label: "NetworkMonitor")
                        monitor.start(queue: queue)
                    }
                    Spacer()
                    
                    Group{
                        Text("Device O/S:-- \(device.systemName)")
                            .font(.system(size: 20,weight: .bold))
                            .padding()
                        Text("Device Version:-- \(device.systemVersion)")
                            .font(.system(size: 20,weight: .bold))
                            .padding()
                        Text("Device Name:-- \(device.name)")
                            .font(.system(size: 20,weight: .bold))
                            .padding()
                        Text("Device Model:-- \(device.model)")
                            .font(.system(size: 20,weight: .bold))
                            .padding()
                        Text("MAC Address:--\n \(getDeviceIdentifier())").align(.leading)
                            .font(.system(size: 12, weight: .bold))
                            .padding()
                    }
                    
                    Text("Protected View")
                        .font(.largeTitle)
                        .padding()
                    Text("You cannot take a screenshot of this view.")
                        .padding()
                        .allowsHitTesting(false)
                        .font(.system(size: 22, weight: .semibold))
                    
                    Text("IP Address:\n\(getIPAddress())")
                        .font(.system(size: 24, weight: .bold))
                        .padding()
                    
                }
                    Spacer()
              
                }.padding(12)
                    .foregroundColor(.black)
                    .background(Color.cgYellow)
                    .cornerRadius(8).shadow(2)
                    .padding()
            } .onReceive(NotificationCenter.default.publisher(for: UIApplication.userDidTakeScreenshotNotification)) { _ in
                isScreenshotTaken = true
            }
            .alert(isPresented: $isScreenshotTaken) {
                Alert(title: Text("Screenshot Detected"), message: Text("Screenshots are not allowed in this view."), dismissButton: .default(Text("OK")))
                
            }.onAppear{
//                list.getBookShowListData()
            }
    }
    func getDeviceIdentifier() -> String {
        let device = UIDevice.current
        if let identifierForVendor = device.identifierForVendor {
            return identifierForVendor.uuidString
        }
        
        return "Unknown"
    }
    
    func getNetworkInterfaces() -> String {
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            for interface in path.availableInterfaces {
                print("Interface Name: \(interface.name)")
                print("Interface Type: \(interface.type)")
                // You can access other properties of the interface here
            }
        }
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
        return "\(queue)"
    }
    
    func getIPAddress() -> String {
        var address: String?
        var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while ptr != nil {
                defer { ptr = ptr?.pointee.ifa_next }

                guard let interface = ptr?.pointee else { return "" }
                let addrFamily = interface.ifa_addr.pointee.sa_family
                if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {

                    // wifi = ["en0"]
                    // wired = ["en2", "en3", "en4"]
                    // cellular = ["pdp_ip0","pdp_ip1","pdp_ip2","pdp_ip3"]

                    let name: String = String(cString: (interface.ifa_name))
                    if  name == "en0" || name == "en2" || name == "en3" || name == "en4" || name == "pdp_ip0" || name == "pdp_ip1" || name == "pdp_ip2" || name == "pdp_ip3" {
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        getnameinfo(interface.ifa_addr, socklen_t((interface.ifa_addr.pointee.sa_len)), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST)
                        address = String(cString: hostname)
                    }
                }
            }
            freeifaddrs(ifaddr)
        }
        return address ?? ""
    }
}

struct MACAddressView_Previews: PreviewProvider {
    static var previews: some View {
//        DeviceInfoView()
        MACAddressView()
    }
}



struct MACAddressView1: View {
    @State private var isAnimating = true
    
    var body: some View {
        VStack{
            
            ZStack{
                VStack{
                    Button(action: {
                        self.isAnimating.toggle()
                    }, label: {
                        Text("Animation").foregroundColor(.black).padding()
                            .background(
                            LinearGradient(
                                colors: [.cgYellow, .cgGreen],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        ).cornerRadiusIf(isAnimating, 12)
                    })
                    Spacer()
                    Image("soft").resizable()
                }
                
                if isAnimating{
                    AnimationView(isAnimating: isAnimating)
                        .offset(x: isAnimating ?  0 : UIScreen.main.bounds.width , y: isAnimating ? 215 : UIScreen.main.bounds.height )
//                        .animation(.linear(duration: 3))
                }
                
            }
        }
    }
}

struct CustomShape: Shape {
    var cornerRadious: [CGFloat]
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let topLeft = CGPoint(x: rect.minX, y: rect.minY)
        let topRight = CGPoint(x: rect.maxX, y: rect.minY)
        let bottomRight = CGPoint(x: rect.maxX, y: rect.maxY)
        let bottomLeft = CGPoint(x: rect.minX, y: rect.maxY)
        
        path.move(to: topLeft)
        path.addArc(tangent1End: topRight, tangent2End: bottomRight, radius: cornerRadious[0])
        path.addArc(tangent1End: bottomRight, tangent2End: bottomLeft, radius: cornerRadious[1])
        path.addArc(tangent1End: bottomLeft, tangent2End: topLeft, radius: cornerRadious[2])
        path.addArc(tangent1End: topLeft, tangent2End: topRight, radius: cornerRadious[3])
        path.closeSubpath()
        
        return path
    }
}



struct AnimationView: View{
    @State var isAnimating:Bool //= true
    
    var body: some View{
            
            HStack{
                ZStack{
//                    Rectangle()
//                        .foregroundColor(.clear)
                    HStack{
                        VStack{
                            Spacer()
                            ZStack{
                                Circle().frame(93).foregroundColor(.green)
                                Text("Hello")
                                    .foregroundColor(.white)
                                    .font(.system(size: 32, weight: .bold))
                            }
                        }.padding(28)
                        VStack{
                            HStack{
                                Spacer()
                                ZStack{
                                    Circle().frame(93).foregroundColor(.cgYellow)
                                    Text("Yummy")
                                        .foregroundColor(.cgBrown)
                                        .font(.system(size: 22, weight: .bold))
                                }
                            }
                            Spacer()
                        }.padding(12)
                    }
                }
                
            }.background(LinearGradient(
                colors: [.cgGray, .cgMagenta],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )).frame(width: 350, height:350) .clipShape(CustomShape(cornerRadious: [0, 0, 0, 367]))
                 .offset(x: isAnimating ? 30 : UIScreen.main.bounds.width, y: isAnimating ? 35 : UIScreen.main.bounds.height)
                .animation(.linear(duration: 1), value: isAnimating)
       
    }
}

  
// MARK: - Welcome
public struct DrmProtectionModel:Decodable {
    public let book_details: DrmProtectionBookDetails
    public let partner_details: DrmProtectionPartnerDetails
    public let success: String
    public let data: Int

   
}

// MARK: - BookDetails
public struct DrmProtectionBookDetails: Decodable {
    public let current_page: Int
    public let data: [DrmProtectionDatum]
    public let first_page_url: String?
    public let to: Int
    public let total: Int
}

// MARK: - Datum
public struct DrmProtectionDatum: Decodable  {
    public let id: Int
    public let partner_id: Int
    public let book_id: Int
    public let createdAt: String
    public let book: DrmProtectionBook
    public let partner: DrmProtectionPartner
 
}

// MARK: - Book
public struct DrmProtectionBook: Decodable  {
    public let id: Int
    public let upload_type_id: Int
    public let name: String
    public let tot_pages: Int
    public let title: String
    public let author_name: String
    public let isbn_no: String
    public let size: String
    public let publish_date: String
    public let validity_date: String
    public let url: String
    public let published: String
    public let is_locked: Bool
    public let remaining_device_count: Int
    public let uploadtypename: String
    public let book_media: DrmProtectionPurpleBookMedia
    public let partner_name: DrmProtectionPartnerName
    public let book_medias: [DrmProtectionBookMediaElement]
    public let book_partner_link: DrmProtectionBookPartnerLink
    public let upload_type: DrmProtectionUploadType
 
}

// MARK: - PurpleBookMedia
public struct DrmProtectionPurpleBookMedia: Decodable  {
    public let id: Int
    public let book_media_type_id: Int
    public let media_type_id: Int
    public let book_id: Int
    public let url: String
 
}

// MARK: - BookMediaElement
public struct DrmProtectionBookMediaElement: Decodable  {
    public let id: Int
    public let book_media_type_id: Int
    public let media_type_id: Int
    public let url: String
    public let book_media_type: String
    public let media_type: String
 
}

// MARK: - BookPartnerLink
public struct DrmProtectionBookPartnerLink : Decodable {
    public let id: Int
    public let book_id: Int
    public let purchase_type: Int
 
}

// MARK: - PartnerName
public struct DrmProtectionPartnerName: Decodable  {
    public let id: Int
    public let full_name: String
    public let dob: String
 
}

// MARK: - UploadType
public struct DrmProtectionUploadType: Decodable  {
    public let id: Int
    public let name: String
    public let description: String
 
}

// MARK: - Partner
public struct DrmProtectionPartner: Decodable  {
    public let id: Int
    public let user_id: Int
    public let admission_no: String
    public let roll_no: String
    public let last_name: String
    public let full_name: String
    public let father_name: String
    public let gender: String
    public let dob: String
    public let referal_code: String

    
}

// MARK: - PartnerDetails
public struct DrmProtectionPartnerDetails: Decodable  {
    public let id: Int
    public let user_id: Int
    public let admission_no: String
    public let roll_no: String
    public let role_id: Int
    public let school_id: Int
    public let school_class_link_id: Int
    public let last_name: String
    public let full_name: String
    public let father_name: String
    public let gender: String
    public let dob: String
    public let referal_code: String
    public let partner_role: DrmProtectionPartnerRole

     
}

// MARK: - PartnerRole
public struct DrmProtectionPartnerRole: Decodable  {
    public let id: Int
    public let name: String
    public let guard_name: String
 
}


//MARK: - View Model

class DrmProtectionViewModel: ObservableObject{
   
    @Published var books = [DrmProtectionDatum]()
//    @Published var booksdetails:ShowBookAudioBookDetails?
    @Published var lecture = String()
    @Published var video: String?
    @Published var banner = String()
    @Published var totalPage = Int()
    @Published var currentPage = 1
    @Published var noBooks:Bool = false
    func getBookShowListData() {
        let apiurl = "https://alibrary.in/api/guest/purchased-books?page=1&device_os=windows&device_type=mobile&device_login_ip=192.168.1.10&device_mac_address=47093C9CC4014BD8A08A8EBA96570E4F"
        guard let url = URL(string: apiurl) else {
            // handle invalid URL error
            return
        }
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
        let service = HTTPLoginUtility()
       
        service.getLoginData(from: url, model: DrmProtectionModel.self, token: token){ (result) in
            switch result {
                case .success(let results):
                DispatchQueue.main.async { [self] in
                    
                    
                    self.books = results.book_details.data
                    print(self.books)
                    
                }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
      
}

