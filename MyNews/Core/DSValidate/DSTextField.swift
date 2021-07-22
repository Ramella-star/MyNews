//
//  DSTextField.swift
//  validation
//
//  Created by Dmitriy Soloshenko on 17.04.2020.
//  Copyright © 2020 Dmitriy Soloshenko. All rights reserved.
//

import UIKit

class DSTextField: UITextField, IValidatable
{
    @IBInspectable var valueRequired :Bool         = true
    @IBInspectable var borderMistakeColor :UIColor = .red
    @IBInspectable var borderEmptyColor :UIColor   = .red
    @IBInspectable var borderFilledColor :UIColor  = .lightText
    @IBInspectable var expression :String          = ""
    //@IBInspectable var mistake :String             = ""
    @IBInspectable var showMistake :Bool           = true

    @IBOutlet var validateDelegates: [IValidationManager]?
    
    var isValid: Bool {
        if self.textContentType == .password {
            return !(self.text?.isEmpty ?? true)
        }else {
            //if self.text?.isEmpty ?? true {
                //self.label.text = "Your email is requaried"
            //} else {
                //self.label.text = "Invalid email address"
            //}
            return  self.text.verification(self.expression, required:self.valueRequired)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.adjustView()
    }
    
    //override func layoutSubviews() {
        //self.appendLabel()
        //super.layoutSubviews()
    //}
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.adjustView()
    }
    
    private func adjustView() {
        self.addTarget(self, action: #selector(self.textEditAction(_:)), for: .editingChanged)
        //self.addTarget(self, action: #selector(self.selectTextField(_:)), for: .editingDidBegin)
        
        //self.addTarget(self, action: #selector(self.unselectTextField(_:)), for: .editingDidEnd)
    }
    
    @objc func textEditAction(_ sender: UITextField) {
        self.handleDelegateAction(sender)
        sender.borderColor = self.calcBorderColor(sender)
        //self.label.isHidden = self.isValid
    }
    
    private func calcBorderColor(_ sender: UITextField) -> UIColor {
        if !self.isValid {
            return self.borderMistakeColor
        }
        
        if let text = sender.text, text.count > 0 {
            return self.borderFilledColor
        }
        
        return self.borderEmptyColor
    }
    
    private func handleDelegateAction(_ sender: UITextField) {
        guard let list = self.validateDelegates else { return }

        for validateDelegate in list {
            validateDelegate.verificated()
        }
    }
}
