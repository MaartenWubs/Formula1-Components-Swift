//
//  F1Elevatable.swift
//  Formula1-Components-Swift
//
//  Created by Maarten Wubs on 7/17/22.
//

import Foundation
import CoreGraphics

/// Provides APIs for `UIView` to communicate their elevation throughout the view hierarchy.
public protocol F1Elevatable: NSObject {
    
    /// The current elevation of the conforming `UIView`.
    var f1_currentElevation: CGFloat { get }
    
    /// This block is called when the elevation changes for the conforming `UIView` of `UIViewController`
    /// reciever or one of its direct ancestors in the view hierarchy.
    ///
    /// Use this block to respond to elevation changes in the view or its ancestor views.
    ///
    /// - Parameter absoluteElevation: The `f1_currentElevation` plus the `f1_currentElevation`
    /// of all ancestor views. This equates to `f1_absoluteElevation` of the UIView+Formula1ElevationResponding
    /// category.
    /// - Parameter object: The reciever (self) which conforms to the protocol.
    var f1_elevationDidChange: ((_ objecct: F1Elevatable, _ absoluteElevation: CGFloat) -> Void)? { get }
}
