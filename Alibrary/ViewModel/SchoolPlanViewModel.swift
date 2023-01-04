//
//  SchoolPlanViewModel.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 16/11/22.
//

import Foundation
class SchoolPlanViewModel: ObservableObject {

    @Published var schoolPlanData: [[PublisherPlan]] = []
//    @Published var headings: [String] = []  // <-- here
    @Published var schoolPlanHeading: [String] = []
    
    
    
    func getData() async {
        guard let url = URL(string: "https://www.alibrary.in/api/plans") else { return }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            //       print("\n \(String(data: data, encoding: .utf8) as AnyObject) \n")
            Task{@MainActor in
                let results = try JSONDecoder().decode(PlanModel.self, from: data)
                // the data minus the first array of headings
                schoolPlanData = Array(results.schoolPlans.dropFirst()) // <-- here
               
                // get the headings
            
                if let headers = results.schoolPlans.first { // <-- here
                   
                    for h in headers {
                        switch h {
                           case .integer(_): break
                           case .string(let str):
                            if self.schoolPlanHeading.count < 3{
                                self.schoolPlanHeading.append(str)
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
