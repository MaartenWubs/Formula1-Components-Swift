//
//  F1AlertController.swift
//  Formula1-Components-Swift
//
//  Created by Maarten Wubs on 7/17/22.
//

import Foundation
import CoreGraphics
import UIKit

// TODO: [f1d48949f9-dialogs]

/// `F1AlertController` displays an alert message to the user, similar to `UIAlertController`.
///
/// `F1AlertController` class is intended to be used as-is and does not support subclassing. The view
/// hierarchy for this class is private and must not be modified.
public class F1AlertController: UIViewController {
    
    /// Convenience constructor to create and return a view controller for siaplaying an alert
    /// to the user.
    ///
    /// After creating the alert controller, add actions to the controller by calling `addAction()`.
    ///
    /// - Parameter title: The title of the alert
    /// - Parameter messgae: Descriptive text that summarizes a dexicion in a sentence of two.
    /// - Returns: An initialized `F1AlertController` object.
    public init(with title: String?, and message: String?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    /// Convenience constructor to create and return a view controller for displaying an alert
    /// to the user.
    ///
    /// After creating the alert controller, add actions to the controller by calling `addAction()`.
    ///
    /// - Note Set `attributedMessage` to respond to link-tap events, if needed.
    ///
    /// - Note This method receives an `AttributedString` for the display message. Use
    /// `init(with:String?,and:String?)` for regular `String` support.
    ///
    /// - Parameter title: The title of the alert.
    /// - Parameter attributedMessage: Descriptive text that summarizes a decision in a sentence of two.
    /// - Returns: An initialized `F1AlertController` object.
    public init(with title: String?, and attributedMessage: AttributedString?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    /// An object conforming to `F1AlertControllerDelegate`. When non-nil, the
    /// `F1AlertController` will call the appropriate `F1AlertControllerDelegate`
    /// methods on this object.
    public var delegate: F1AlertControllerDelegate? = nil
    
    /// The font applied to the alert's title
    public var titleFont: UIFont? = nil
    
    /// The color applied to the alert's title
    public var titleColor: UIColor? = nil
    
    /// The alignment applied to the title of the Alert. Defaults to `NSTextAlignment.natural`.
    public var titleAlignment: NSTextAlignment = .natural
    
    /// An optional icon or image that appears obove the title of the Alert Controller.
    ///
    /// - Note: To proportionally scale large images to fit the available space, set
    /// `titleIconAlignment` to `F1ContentAlignmentJustified.horizontal`
    public var titleIcon: UIImage?
    
    /// The tint color applied to the titleIcon. Leave empty to preserve original image colors.
    public var titleIconTintColor: UIColor? = nil
    
    /// The alignment applied to the tittle icon.
    ///
    /// To preservice backward compatibility, the default alignment of the title icon matches the alignment
    /// if the title, set by `titleAlignment`. The `titleIconAlignment` value will automatically
    /// match `titleAlignment` until the value of `titleIconAlignment` is first set.
    public var titleIconAlignment: NSTextAlignment = .natural
    
    /// The font applied to the alert's message.
    public var messageFont: UIFont?
    
    /// The color applied to the alert's message.
    ///
    /// - Note: If `messageColor` is set (including if set to nil), it will override foregroundColor
    /// attributes that were set by the attributed message text.
    public var messageColor: UIColor?
    
    /// The alignment applied to the alert's message. Defaults to `NSTextAlignment.natural`
    public var messageAlignment: NSTextAlignment = .natural
    
    /// The semi-transparent color which is applied to the overlay covering the content
    /// behind the Alert (the scrim) when presented by `F1DialogPresentationController`.
    public var scrimColor: UIColor?
    
    /// The Alert background color.
    public var backgroundColor: UIColor?
    
    /// The corner radius applied to the Alert Controller view. Defaults to 0.0
    public var cornerRadius: CGFloat = 0.0
    
    /// The elevation that will be applied to the Alert Controller view.
    // TODO: Make this default to 24.
    public var elevation: F1ShadowElevation?
    
    /// The color of the shadow that will be applied to the `F1AlertController` view. Defaults
    /// to black.
    public var shadowColor: UIColor = .black
    
    /// High level description of the alert or decision being made.
    ///
    /// Use title only for high-risk situations, such as the potential loss of connectivity. If used,
    /// users should be able to understand the choices based on the title and button text alone.
    public var alertTitle: String?
    
    /// A custom accessibility label for the title
    ///
    /// When `nil` the title accessibilityLabel will be set to the value of the `alertTitle`.
    public var titleAccessibilityLabel: String?
    
    /// Descriptive text that summarizes a decision in a sentence or two.
    public var message: String?
    
    /// Descriptive text that summarizes a descision in a sentence or two, in an attributed string
    /// format.
    ///
    /// If provided and non-nil, will be used instead of `message` property.
    ///
    /// - Note: Set `attributedMessageAction` to respond to link-tap events, if needed.
    public var attributedMessage: AttributedString?
    
    /// The color applied to links in the attributed message. When `nil`, UIKit's default
    /// tint color will be used.
    public var sttributedLinkColor: UIColor? = .tintColor
    
    /// A custom accessibility label for the message.
    ///
    /// When `nil` the message accessibilityLabel will be set to the value of the `message`
    public var messageAccessibilityLabel: String?
    
    /// A custom accessibility label for the title icon view.
    public var imageAccessibilityLabel: String?
    
    /// Accessory view that contains custom UI.
    ///
    /// The size of the accessory view is determined through Auto Layout. If your view uses manual
    /// layout, you can either add a height constraint (e.g.
    ///  `view.heightAnchor.constraint(equalToConstant:)`) or you can override
    ///  `systemLayoutSizeFittingSize(_:_:_:)`.
    ///
    ///  If the content of the view changes and the height needs to be recalculated, call
    ///  `alert.accessoryViewNeedsLayout`. Note that `F1AccessoryAlertController`
    ///  will automatically recalculate the accessory view's size if the alert's width changes.
    public var accessoryView: UIView?
    
    /// Notifies the alert controller that the size of the accessory view needs to be recalculated due to
    /// contant changes.  Note that `F1AccessorizedAlertController` will automatically
    /// recalculate the accessory view's size if the alert's width changes.
    public func accessoryViewNeedsLayout() {}
    
    /// Duration of the dialog fade-in or fade-out presentation animation.
    ///
    /// Defaults to 0.23 seconds.
    public var opacityAnimationDuration: TimeInterval = 0.23
    
    /// Duration of scale-up or scale-down presentation animation.
    ///
    /// Defaults to 0 seconds.
    public var scaleAnimationDuration: TimeInterval = 0
    
    /// The starting scale factor of the alert during the presentation animation, between 0 and 1.
    /// The "animate in" transition scales the alert from this value to 1.0.
    ///
    /// Defaults to 1.0 (no scaling).
    public var initialScaleFactor: CGFloat = 1.0
    
    /// By setting this property to `true`, the ripple component will be used instead of
    /// Ink to display visual feedback to the user.
    ///
    ///Defaults to `false`
    public var enableRipple: Bool = false
    
    /// A block that is invoked when the `F1AlertController` receives a cill to
    /// `traitCollectionDidChange()`. The block is called after the call to the superclass.
    public var traitCollectionDidChange: ((_ alertController: F1AlertController?,
                                           _ previousTraitCollection: UITraitCollection?) -> Void)?
    
    /// `F1AlertController` handles its own transitioning delegate.
    public func setTransitioningDelegate(_ transitioningDelegate: UIViewControllerTransitioningDelegate?) -> Void {}
    
    /// `F1AlertController.modalPresentationstyle` is always `UIModalPresentationStyle.custom`
    public func setModalPresentationStyle(_ modal: UIModalPresentationStyle) -> Void {}
    
    /// Whether or not title should scroll with the content.
    ///
    /// If the title does not pin to the top of the content, it will scroll woth the message when the message
    /// scrolls.
    ///
    /// Defaults to `true`
    public var titlePinsToTop: Bool = true
}
