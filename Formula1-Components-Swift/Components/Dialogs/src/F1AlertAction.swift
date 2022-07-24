//
//  F1AlertAction.swift
//  Formula1-Components-Swift
//
//  Created by Maarten Wubs on 7/24/22.
//

import Foundation
import UIKit
import CoreGraphics

public enum F1ActionEmphasis: Int {
    case low = 0
    case medium = 1
    case heigh = 2
}

public typealias F1ActionHandler = (F1AlertAction) -> Void

/// `F1AlertAction` is passed to an `F1AlertController` to add a button to the alert dialog
public class F1AlertAction: NSObject, NSCopying, UIAccessibilityIdentification {
    public func copy(with zone: NSZone? = nil) -> Any {
        let action = F1AlertAction.init(actionWithTitle: self.title ?? "",
                                        emphasis: self.emphasis,
                                        handler: self.tapHandler)
        action.accessibilityIdentifier = self.accessibilityIdentifier
        return action
    }
    
    /// The `accessibilityIdentifier` for the view associated with this action.
    public var accessibilityIdentifier: String?
    
    /// A convenience method for adding actions that will be rendered as low emphasis button at the
    /// bottom of an alert controller.
    ///
    /// - Parameter title: The title of the button shown on the alert dialog.
    /// - Parameter handler: A block to execute when the user selects the action. This is called
    /// any time the action is selected, even if `dismissOnAction` is `false`
    /// - Returns: An initialized `F1ActionAlert` object
    public init(actionWithTitle title: String,
                handler: F1ActionHandler?) {
        super.init()
        self.title = title
        self.tapHandler = handler
    }
    
    /// A convenience method for adding actions that will be rendered as low emphasis buttons at the
    ///  bottom ao an alert controller.
    ///
    ///  - Parameter title: The title of the button shown on the alert dialog.
    ///  - Parameter emphasis: the emphasis of the button that will be rendered in the alert dialog.
    ///  Unthemed actions will render all empases as text. Apply themers to the alert to achieve
    ///  different appearence for different amphases.
    ///  - Parameter handler: A block to execute when the user slects the action, This is called
    ///  any time the action is slected, even if `dismissOnAction` is `false`.
    ///  - Returns: An initialized `F1ActionAlert` object.
    public init(actionWithTitle title: String,
                emphasis: F1ActionEmphasis,
                handler: F1ActionHandler?) {
        super.init()
        self.title = title
        self.emphasis = emphasis
        tapHandler = handler
    }
    
    /// Alert actions must be initialized with either `init(actionWithTitle:handler)` or
    /// `init(actionWithTitle:emphasis:handler:)`.
    public override init() {}
    
    /// Title of the button shown on the alert.
    public var title: String?
    
    /// The action to execute when the button is pressed.
    public var tapHandler: F1ActionHandler?
    
    /// The `F1ActionEmphasis` emphasis of the button that will be rendered for the action.
    public var emphasis: F1ActionEmphasis = .low
    
    /// Whether actions dismiss the alert on action selection or persist the alert after a selection has
    /// been made. If this is set to `false`, then it is up to the presenting class to dismiss the controller.
    /// Callers may dismiss the controller by calling`dismiss(animated:)` on the presenting view
    /// controller. Example:
    ///
    /// ```
    /// weak var weakkAlertController = alertController
    /// let action = F1AlertAction.init(actionWithTitle: "Title, handler {
    ///     let strongAlertController = weakAlertController
    ///     if let strongAlertController = strongAlertController {
    ///         strongAlertController.presentingViewController.dismiss(animated: true)
    ///         }
    ///     }
    /// })
    /// action.dismissOnAction = false
    /// alertController.addAction(action)
    /// ```
    ///
    /// Defaults to `true` meaning that when a action is performed, it also dismisses the alert.
    public var dismissOnAction: Bool = true
}
