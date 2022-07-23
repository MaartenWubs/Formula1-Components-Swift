//
//  F1ElevationOverriding.swift
//  Formula1-Components-Swift
//
//  Created by Maarten Wubs on 7/17/22.
//

import Foundation
import CoreGraphics

/// Provides APIs for `UIView` to communicate their elevation throughout the view hierarchy.
public protocol F1ElevationOverriding {

    /// Used by `Formula1ElevationResponding` instead of `f1_baseElevation`.
    ///
    /// This can be used in cases where there is elevation behind an object that is not part of the
    /// view hierarchy, like a `UIPresentationController`
    ///
    /// **Note**: If set to a negative value, this property is ignored as part of the `f1_baseElevation`
    /// calculation.
    var f1_overrideBaseElevation: CGFloat { get }
}
