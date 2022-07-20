//
//  F1RippleLayerDelegate.swift
//  Formula1-Components-Swift
//
//  Created by Maarten Wubs on 7/16/22.
//

import Foundation
import UIKit

/// The ripple layer delegate protocol to let `F1RippleLayer` know of the layer's
/// ripple animation timeline.
public protocol F1RippleLayerDelegate: CALayerDelegate {
    
    /// Called when the ripple layer began its touch down animation
    ///
    /// **rippleLayer**: the `F1RippleLayer`
    func rippleLayerTouchDownAnimationDidBegin(_ rippleView: F1RippleLayer) -> Void

    /// Called when the ripple layer ended its touch down animation
    ///
    /// **rippleLayer**: the `F1RippleLayer`
    func rippleLayerTouchDownAnimationDidEnd(_ rippleView: F1RippleLayer) -> Void
    
    /// Called when the ripple layer began its touch up animation
    ///
    /// **rippleLayer**: the `F1RippleLayer`
    func rippleLayerTouchUpAnimationDidBegin(_ rippleView: F1RippleLayer) -> Void
    
    /// Called when the ripple layer ended its touch up animation
    ///
    /// **rippleLayer**: the `F1RippleLayer`
    func rippleLayerTouchUpAnimationDidEnd(_ rippleView: F1RippleLayer) -> Void
}
