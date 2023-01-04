//
//  MaterialClass.swift
//  Alibrary
//
//  Created by Sandeep Kesarwani on 14/07/22.
//

import Foundation
import MaterialComponents.MaterialTextControls_FilledTextAreas
import MaterialComponents.MaterialTextControls_FilledTextFields
import MaterialComponents.MaterialTextControls_OutlinedTextAreas
import MaterialComponents.MaterialTextControls_OutlinedTextFields
class MaterialClass: UIViewController {
    let estimatedFrame = ...
    let textField = MDCFilledTextField(frame: estimatedFrame)
    textField.label.text = "Phone number"
    textField.placeholder = "555-555-5555"
    textField.leadingAssistiveLabel.text = "This is helper text"
    textField.sizeToFit()
    view.addSubview(textField)
}
