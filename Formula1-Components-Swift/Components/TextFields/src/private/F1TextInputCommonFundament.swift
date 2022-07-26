//
//  F1TextInputCommonFundament.swift
//  Formula1-Components-Swift
//
//  Created by Maarten Wubs on 7/25/22.
//

import Foundation
import UIKit

let F1TextInputClearButtonTouchTargetSize: CGFloat = 48

class F1TextInputClearButton: UIButton {
    
    public var minimumTouchTargetInsets: UIEdgeInsets = .init()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let width: CGFloat = self.bounds.size.width
        let height: CGFloat = self.bounds.size.height
        let verticalInsets: CGFloat = min(0, -(F1TextInputClearButtonTouchTargetSize - height) / 2)
        let horizontalInsets: CGFloat = min(0, -(F1TextInputClearButtonTouchTargetSize - width) / 2)
        self.minimumTouchTargetInsets = .init(top: verticalInsets,
                                              left: horizontalInsets,
                                              bottom: verticalInsets,
                                              right: horizontalInsets)
    }
    
    // TODO
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if self.minimumTouchTargetInsets == UIEdgeInsets.zero {
            return true
        }
        return false
    }
}

class F1TextInputCommonFundament: NSObject {
    
    // MARK: - Public properties
    
    public var leadingView: UIView?
    
    public var leadingViewMode: UITextField.ViewMode = .never
    
    public var textColor: UIColor?
    
    public var sizeThatFitsWidthHint: CGFloat = 0.0
    
    // MARK: Private properties
    
    private var _f1_adjustsFontForContentSizeCategory: Bool!
    
    private var _isRegisteredForKVO: Bool!
    private var isRegisteredForKVO: Bool {
        get { return _isRegisteredForKVO }
        set { _isRegisteredForKVO = newValue }
    }
    
    private var clearButtonCenterY: NSLayoutConstraint!
    private var clearButtonTrailing: NSLayoutConstraint!
    private var clearButtonWidth: NSLayoutConstraint!
    
    private var _leadingUnderlineLeading: NSLayoutConstraint!
    private var leadingUnderlineLeading: NSLayoutConstraint {
        get { return _leadingUnderlineLeading }
        set { _leadingUnderlineLeading = newValue }
    }
    
    private var _leadingUnderlineTrailing: NSLayoutConstraint!
    private var leadingUnderlineTrailing: NSLayoutConstraint {
        get { _leadingUnderlineTrailing }
        set { _leadingUnderlineTrailing = newValue }
    }
    
    private var _trailingUnderlineLeading: NSLayoutConstraint!
    private var trailingUnderlineLeading: NSLayoutConstraint {
        get { _trailingUnderlineLeading }
        set { _trailingUnderlineLeading = newValue }
    }
    
    private var _trailingUnderlineTrailing: NSLayoutConstraint!
    private var trailingUnderlineTrailing: NSLayoutConstraint {
        get { _trailingUnderlineTrailing }
        set { _trailingUnderlineTrailing = newValue}
    }
    
    private var placeholderLeading: NSLayoutConstraint!
    private var placeholderLeadingLeadingViewTrailing: NSLayoutConstraint!
    private var placeholderTop: NSLayoutConstraint!
    private var placeholderTrailing: NSLayoutConstraint!
    private var placeholderTrailingTrailingViewLeading: NSLayoutConstraint!
    private var _textInput: UIView!
    private var textInput: UIView {
        get { _textInput }
        set {
            _textInput = newValue
            _textInput.setNeedsLayout()
        }
    }
    
    override init() { }
    
    init(aDecoder: NSCoder) {}
    
    func copy(with zoen: NSZone) -> Self { return self }
    
    func dealloc() { }
    
    func commonF1TextInputCommonFundamentInit() { }
    
    func setupClearButton() { }
    
    func setupPlaceholderLabel() { }
    
    func setupUnderlineSlabels() { }
    
    func setupUnderlineView() { }
    
    func clearText() { }
    
    // MARK: - Border
    
    func setupBorder() { }
    
    func unsubscribeFromNotifications() { }
    
    // MARK: - KVO
    
    func subscribeForKVO() { }
    
    func unsubscribeFromKVO() { }
    
    // MARK: - Mirrored layout
    
    func layoutSubviewsOfInput() { }
    
    func updateConstraintsOfInput() { }
    
    // MARK: - Clear button
    
    func updateClearButton() { }
    
    func updateClearButtonConstraints() { }
    
    func clearButtonAlpha() -> CGFloat { return 0.0 }
    
    func drawClearButtonImage() -> UIImage { return UIImage.init() }
    
    func clearButtonDidTouch() { }
    
    // MARK: - Properties implementation
    
    func setTextInsetsMode(_ mode: UITextInputMode) { } //TODO: Make F1TextInputTextInsetsMode
    
    func attributedPlaceholder() -> AttributedString { return "" }
    
    func setAttributedPlaceholder(_ placeholder: AttributedString) { }
    
    func setBorderPath(_ path: UIBezierPath) { }
    
    func setClearButtonMode(_ mode: UITextInputMode) { }
    
    func cursorColor() -> UIColor { return .clear }
    
    func setCursorColor(_ color: UIColor) { }
    
    func setEnabled(_ enabled: Bool) { }
    
    func font() -> UIFont { return .systemFont(ofSize: 16) }
    
    func setFont(_ font: UIFont) { }
    
    func setHidesPlaceholderOnInput(_ hides: Bool) { }
    
    func isEditing() -> Bool { return false }
    
    func placeholder() -> String { return "placeholder" }
    
    func setPlaceholder(_ placeholder: String) { }
    
    func text() -> String { return "" }
    
    func setText(_ text: String) { }
    
    func setTextColor(_ color: UIColor) { }
    
    func textInsets() -> UIEdgeInsets { return .init() }
    
    func trailingView() -> UIView { return .init() }
    
    func setTrailingView(_ view: UIView) { }
    
    func trailingViewMode() -> UITextField.ViewMode { return .never }
    
    func setTrailingViewMode(_ mode: UITextField.ViewMode) { }
    
    // MARK: - Layout
    
    func updateTextColor() { }
    
    func updateFontsForDynamicType() { }
    
    func needsUpdateConstraintsForPlaceholderToTextInsets() -> Bool { return false }
    
    func needsUpdateConstraintsForPlaceholderToOverlayViewsPosition() -> Bool {
        return false
    }
    
    func updatePlaceholderToOverlayViewsPosition() { }
    
    func updatePlaceholderAlpha() { }
    
    func updatePlaceholderPosition() { }
    
    func placeholderDefaultConstraints() -> [AnyObject] { return .init() }
    
    func updateUnderlineLabels() { }
    
    // MARK: Text Input
    
    func didBeginEditing() { }
    
    func didChange() { }
    
    func didEndEditing() { }
    
    func didSetFont(_ previousFont: UIFont) { }
    
    func didSetText() { }
    
    // MARK: - KVO
    
    func observeValueForKeyPath(_ keyPath: String,
                                of object: AnyObject,
                                change: NSDictionary,
                                context: Void) { }
    
    // MARK: - Accessibility
    
    func f1_adjustsFontForContentSizeCategory() -> Bool { return false }
    
    func f1_setAdjustsFontForContentSizeCategory(_ adjusts: Bool) { }
    
    func contentSizeCategoryDidChange(_ notification: Notification) { }
}
