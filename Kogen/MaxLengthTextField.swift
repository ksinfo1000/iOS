//
//  MaxLengthTextField.swift
//  KozhenSpromozhen
//
//  Created by Kogen on 7/28/17.
//  Copyright © 2017 KozhenSpromozhen. All rights reserved.
//

import UIKit

class MaxLengthTextField: UITextField, UITextFieldDelegate {
    
    private var characterLimit: Int?
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        delegate = self
    }
    
    @IBInspectable var maxLength: Int {
        get {
            guard let length = characterLimit else {
                return Int.max
            }
            return length
        }
        set {
            characterLimit = newValue
        }
    }
    
    // 1
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard string.characters.count > 0 else {
            return true
        }

        let currentText = textField.text ?? ""

        let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: string)

        return prospectiveText.characters.count <= maxLength
    }
    
}

class MaxLengthTextView: UITextView, UITextViewDelegate {
    
    private var characterLimit: Int?
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        delegate = self
    }
    
    @IBInspectable var maxLength: Int {
        get {
            guard let length = characterLimit else {
                return Int.max
            }
            return length
        }
        set {
            characterLimit = newValue
        }
    }
    
    // 1
    func textView(_ textView: UITextView, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        print(423)
        guard string.characters.count > 0 else {
            return true
        }
        
        let currentText = textView.text ?? ""
        
        let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        return prospectiveText.characters.count <= maxLength
    }
    
}
