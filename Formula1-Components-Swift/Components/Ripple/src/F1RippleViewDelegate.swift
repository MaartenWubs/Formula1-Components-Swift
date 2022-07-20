//
//  F1RippleViewDelegate.swift
//  Formula1-Components-Swift
//
//  Created by Maarten Wubs on 7/16/22.
//

import Foundation
import UIKit

/// The ripple view delegate protocol. Clients may implement this protocol to recieve updates on the
/// ripple's animation lifecycle.
public protocol F1RippleViewDelegate: NSObject {
    
    /// Called when the ripple view begin its touch down animation.
    ///
    /// **rippleView**: The `F1RippleView`.
    func rippleTouchDownAnimationDidBegin(_ rippleView: F1RippleView) -> Void
    
    /// Called when the ripple view ended its touch down animation.
    ///
    /// **rippleView**: The `F1RippleView`.
    func rippleTouchDownAnimationDidEnd(_ rippleView: F1RippleView) -> Void
    
    /// Called when the ripple view began its touch up animation.
    ///
    /// **rippleView**: The `F1RippleView`.
    func rippleTouchUpAnimationDidBegin(_ rippleView: F1RippleView) -> Void
    
    /// Called when the ripple view ended its touch up animation
    ///
    /// **rippleView**: The `F1RippleView`.
    func rippleTouchUpAnimationDidEnd(_ rippleView: F1RippleView) -> Void
    
}
