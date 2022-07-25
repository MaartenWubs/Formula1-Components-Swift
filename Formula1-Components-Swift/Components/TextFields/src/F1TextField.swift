//
//  F1TextField.swift
//  Formula1-Components-Swift
//
//  Created by Maarten Wubs on 7/18/22.
//

import Foundation
import UIKit

// TODO: [f1t40204902312-textFields]

public class F1TextField: UITextField {
    
    var _cursorColor: UIColor?
    var _inputLayoutStrut: UILabel?
    
    var _fundament: F1TextInputCommonFundament!
    public var fundament: F1TextInputCommonFundament {
        get { return _fundament }
        set { _fundament = newValue }
    }
    
    var _underlineY: NSLayoutConstraint!
    public var underlineY: NSLayoutConstraint {
        get { return _underlineY }
        set { _underlineY = newValue}
    }
}
