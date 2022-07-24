//
//  F1AlertAction.swift
//  Formula1-Components-Swift
//
//  Created by Maarten Wubs on 7/24/22.
//

import Foundation
import UIKit
import CoreGraphics

public typealias F1ActionHandler = (F1AlertAction) -> Void

/// `F1AlertAction` is passed to an `F1AlertController` to add a button to the alert dialog
public class F1AlertAction: NSObject, NSCopying, UIAccessibilityIdentification {
    public func copy(with zone: NSZone? = nil) -> Any {
        return ""
    }
    
    public var accessibilityIdentifier: String?
    
    /// A convenience method for adding actions that will be rendered as low emphasis button at the
    /// bottom of an alert controller.
    ///
    /// - Parameter title: The title of the button shown on the alert dialog.
    /// - Parameter handler: A block to execute when the user selects the action. This is called
    /// any time the action is selected, even if `dismissOnAction` is `false`
    /// - Returns: An initialized `F1ActionAlert` object
    public init(actionWithTitle title: String, handler: @escaping F1ActionHandler) {}
}
