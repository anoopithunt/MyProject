//
//  PublisherPlanViewModel.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 16/11/22.
//

import Foundation
class PublisherPlanViewModel: ObservableObject {
    @Published var datas: [[PublisherPlan]] = []

    @Published var headings: [String] = []

    
    
    
    func getData() async {
        guard let url = URL(string: "https://www.alibrary.in/api/plans") else { return }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            //       print("\n \(String(data: data, encoding: .utf8) as AnyObject) \n")
            Task{@MainActor in
                let results = try JSONDecoder().decode(PlanModel.self, from: data)
                // the data minus the first array of headings
                datas = Array(results.publisherPlans.dropFirst()) // <-- here
               
                // get the headings
                if let headers = results.publisherPlans.first { // <-- here
                    for h in headers {
                        switch h {
                           case .integer(_): break
                           case .string(let str):
                            if self.headings.count < 3{
                                self.headings.append(str)
                            }
                          
                        }
                    }
                }
             
            }
        } catch {
            print("---> error: \(error)")
        }
    }
}
