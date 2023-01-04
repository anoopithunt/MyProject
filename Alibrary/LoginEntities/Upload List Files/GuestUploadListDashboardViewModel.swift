//
//  GuestUploadListDashboardViewModel.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 15/03/23.
//

import Foundation
class GuestUploadListDashboardViewModel: ObservableObject{
    
    @Published var publishPDFs = Int()
    @Published var unPublishPDFs = Int()
    @Published var draftPdfs = Int()
    @Published var deletePdfs = Int()
   
    func getUploadListDashboardData() {
        
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "access_token") else {
            return
        }
        
        GuestUploadListDashboardService().getUploadListDashboardData(token: token){ (result) in
            switch result {
            case .success(let results):
                DispatchQueue.main.async {
                    self.publishPDFs = results.publishPDFs
                    self.unPublishPDFs = results.unPublishPDFs
                    self.draftPdfs = results.draftPdfs
                    self.deletePdfs = results.deletePdfs
                    print(results)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

