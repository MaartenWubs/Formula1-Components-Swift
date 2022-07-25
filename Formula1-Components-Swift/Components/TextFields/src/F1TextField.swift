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
    
    // MARK: Private properties
    
    var _cursorColor: UIColor?
    var _inputLayoutStrut: UILabel!
    
    var _fundament: F1TextInputCommonFundament!
    var fundament: F1TextInputCommonFundament {
        get { return _fundament }
        set { _fundament = newValue }
    }
    
    var _underlineY: NSLayoutConstraint!
    var underlineY: NSLayoutConstraint {
        get { return _underlineY }
        set { _underlineY = newValue}
    }
    
    // MARK: Initializers
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func dealloc() {}
    
    func commonF1TextFieldInitialization() {
        super.borderStyle = .none
        
    }
    
    // MARK: Public properties
    
    /// This label should always have the same layout as the input field (which is private API.)
    ///
    /// Unfortunately the include private baseline strut (which is the label returened for baseline-based
    /// auto layout) has bugs that keep it from matching custom layout. I recreated it but also allow it to
    /// have a width in case someone needs other kinds of auto layout constraints based off the input.
    ///
    /// It always has an alpha of 0.0
    public var inputLayoutStrut: UILabel {
        get { return _inputLayoutStrut }
        set { _inputLayoutStrut = newValue }
    }
    
    /// An overlay view in the leading side.
    ///
    /// - Note: if RTL is engaged, this will return the `.rightView` and if LTR, it will
    /// return the `.leftView`.
    public var leadingView: UIView?
    
    /// Controls when the leading view will display.
    public var leadingViewMode: UITextField.ViewMode = .unlessEditing
    
    /// A block that is invoked when the `F1TextField` recieves a call to
    /// `traitCollectionDidChange`. The block is called after the call to the superclass.
    public var traitCollectionDidChange: ((_ textField: F1TextField,
                                           _ previousTraitCollection: UITraitCollection) -> Void)?
    
    // MARK: - Propertie implementation
    
    func clearButton() -> UIButton! {
        return UIButton.init()
    }
}

// MARK: Public methods

extension F1TextField {
    
}

// MARK: Delegates

extension F1TextField: F1Elevatable {
    public var f1_currentElevation: CGFloat {
        return 0.0
    }
    
    public var f1_elevationDidChange: ((F1Elevatable, CGFloat) -> Void)? {
        return nil
    }
}

extension F1TextField: F1ElevationOverriding {
    public var f1_overrideBaseElevation: CGFloat {
        return 0.0
    }
}
