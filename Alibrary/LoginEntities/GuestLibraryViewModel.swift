//
//  GuestLibraryViewModel.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 19/04/23.
//

import Foundation
//MARK: View model

class GuestLibraryViewModel: ObservableObject{
    
    @Published var guestPDFCount = Int() //= ()
    @Published var guestStackCount = Int() //= ()
    @Published var ownPDFCount = Int() //= ()
    @Published var ownStackCount = Int() //= ()
//    @Published var librariesCount: [Int] = []  //= ()
   
    func getLibraryData() {
        
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
        
        GuestLibraryModelService().getLibraryData(token: token){ (result) in
            switch result {
            case .success(let results):
                DispatchQueue.main.async {
                    self.guestPDFCount = results.guestPDFCount
                    self.guestStackCount = results.guestStackCount
                    self.ownPDFCount = results.ownPDFCount
                    self.ownStackCount = results.ownStackCount
//                    self.librariesCount[0] = results.guestStackCount
//                    self.librariesCount[1] = results.guestPDFCount
//                    self.librariesCount[2] = results.ownStackCount
//                    self.librariesCount[3] = results.ownPDFCount
                    print(self.guestPDFCount)

                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

