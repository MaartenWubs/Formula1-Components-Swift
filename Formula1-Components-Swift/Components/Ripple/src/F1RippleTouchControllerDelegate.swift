//
//  F1RippleTouchControllerDelegate.swift
//  Formula1-Components-Swift
//
//  Created by Maarten Wubs on 7/17/22.
//

import Foundation
import UIKit

/// Delegate methods for `F1RippleTouchDelegate`
public protocol F1RippleTouchControllerDelegate: NSObject {
    
    /// Controls whether the ripple touch controller should process touches.
    ///
    /// The touch controller will query this method to determine if it should start or continue to
    /// process touches controller the ripple. Returning `false` at the start of a gesture will prevent any
    /// ripple from being displayed, and returning `false` in the middle of a gesture will cancel that gesture
    /// and evaporate the ripple.
    ///
    /// This method returns `true` by default.
    ///
    /// **rippleTouchController**: The ripple touch controller.
    /// **loaction**: The touch location relative to the rippleTouchController view.
    ///
    /// **return**: Returns `true` if the controller should process touches at `location`.
    func rippleTouchController(_ rippleTouchController: F1RippleTouchController, shouldProcessTouchesAt location: CGPoint) -> Bool
    
    /// Notifies the reciever that the ripple touch controller did process an ripple view at the
    /// touch location.
    ///
    /// **rippleTouchController**: The ripple touch controller.
    /// **rippleView**: The ripple view.
    /// **location**: The touch location relative to the `rippleTouchController` superView.
    func rippleTouchController(_ rippleTouchController: F1RippleTouchController, didProcess rippleView: F1RippleView, at location: CGPoint) -> Void
    
    /// Provides an opportunity to add the rippleView anuwhere in the given view's hierarchy.
    ///
    /// If this method is not implemented, the ripple view is added as a subview of the given view
    /// provided in the controller's `addRippleTo` method or convenience initializer `init(withView:)`.
    /// Delegates can choose to insert the ripple view anywhere in the view hierarchy.
    ///
    /// **rippleTouchController**: The ripple touch controller.
    /// **rippleView**: The ripple view.
    /// **view**: The requested superview of the ripple view.
    func rippleTouchController(_ rippleTouchController: F1RippleTouchController, insert rippleView: F1RippleView, into view: UIView) -> Void
    
    /// Returns the ripple view to use for a touch located at location in the `rippleTouchController.view`.
    ///
    /// If the delegate implements the method, the controller wll not create a ripple view of its own and
    /// `rippleTouchController(_: insert: into:)` will not be called. This method allows the
    /// delegate to control the creation and reuse of ripple views.
    ///
    /// **rippleTouchController**: The ripple touch controller.
    /// **location**: The touch location in the coordinates of `rippleTouchController.view`.
    /// **returns**: Aripple view to use at the touch location.
    func rippleTouchController(_ rippleTouchController: F1RippleTouchController, rippleViewAt location: CGPoint) -> F1RippleView
}
