//
//  AppInfo.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 05/06/23.
//

import Foundation
import UIKit
import SwiftUI

struct AppInfo {
    static var supportsMultipleScene: Bool {
        UIApplication.shared.supportsMultipleScenes
    }
    
    static var supportsAlternateIcons: Bool {
        UIApplication.shared.supportsAlternateIcons
    }
    
    static var supportsShakeToEdit: Bool {
        UIApplication.shared.applicationSupportsShakeToEdit
    }
}



struct DeviceInfo {
    static var name: String {
        UIDevice.current.name
    }
    
    static var systemName: String {
        UIDevice.current.systemName
    }
    
    static var model: String {
        UIDevice.current.model
    }
    
    static var systemVersion: String {
        UIDevice.current.systemVersion
    }
    
    static var batteryState: String {
        switch UIDevice.current.batteryState {
        case .charging:
            return "Charging"
            
        case .full:
            return "Full"
            
        case .unplugged:
            return "Unplugged"
            
        default:
            return "Unknown"
        }
    }
    
    static var isBatteryMonitoringEnabled: Bool {
        UIDevice.current.isBatteryMonitoringEnabled
    }
    
    static func setBatteryMonitoring(to value: Bool) -> Bool {
        UIDevice.current.isBatteryMonitoringEnabled = true
        return isBatteryMonitoringEnabled
    }
    
    static var batteryLevel: String {
        guard isBatteryMonitoringEnabled else { return "Unknown" }
        
        let battery = UIDevice.current.batteryLevel
        if battery == -1 {
            return "Unknown"
        }
        
        return "\(battery.formatted(.percent))"
    }
    
    static  func getIPAddress() -> String {
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



struct DeviceInfoView: View {
    
    var body: some View {
        VStack {
            Text("Device Information..")
                .font(.largeTitle)
            Divider()
            Text("Device Name **\(DeviceInfo.name)**")
            Text("System Name **\(DeviceInfo.systemName)**")
            Text("Model **\(DeviceInfo.model)**")
            Group{
                Text("System Version **\(DeviceInfo.systemVersion)**")
                Text("Battery Charging State **\(DeviceInfo.batteryState)**")
                Text("Battery Monitoring Enabled? **\(DeviceInfo.isBatteryMonitoringEnabled.description)**")
                Text("Battery Monitoring Enabled (After change)? **\(DeviceInfo.setBatteryMonitoring(to: true).description)**")
                Text("Battery Charge Level **\(DeviceInfo.batteryLevel)**")
                Text("IP Address  **\(UIDevice.current.getIP() ?? "")**")
            }.font(.system(size: 22))
        }
    }
}
struct DeviceInfoView_Previews: PreviewProvider {
    static var previews: some View {
        DeviceInfoView()
    }
}



extension UIDevice {
    
    /**
     Returns device ip address. Nil if connected via celluar.
     */
    func getIP() -> String? {
        
        var address: String?
        var ifaddr: UnsafeMutablePointer<ifaddrs>?
        
        if getifaddrs(&ifaddr) == 0 {
            
            var ptr = ifaddr
            while ptr != nil {
                defer { ptr = ptr?.pointee.ifa_next } // memory has been renamed to pointee in swift 3 so changed memory to pointee
                
                guard let interface = ptr?.pointee else {
                    return nil
                }
                let addrFamily = interface.ifa_addr.pointee.sa_family
                if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                    
                    guard let ifa_name = interface.ifa_name else {
                        return nil
                    }
                    let name: String = String(cString: ifa_name)
                    
                    if name == "en0" {  // String.fromCString() is deprecated in Swift 3. So use the following code inorder to get the exact IP Address.
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        getnameinfo(interface.ifa_addr, socklen_t((interface.ifa_addr.pointee.sa_len)), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST)
                        address = String(cString: hostname)
                    }
                    
                }
            }
            freeifaddrs(ifaddr)
        }
        
        return address
    }
    
}
