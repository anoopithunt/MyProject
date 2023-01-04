//
//  String+Extension.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 27/07/22.
//

import Foundation
extension String {
    func trimmed() -> String{
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
