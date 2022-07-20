//
//  UIColor+Formula1Elevation.swift
//  Formula1-Components-Swift
//
//  Created by Maarten Wubs on 7/18/22.
//

import Foundation
import CoreGraphics
import UIKit

/// Provides extension to UIColor for Formula1 Elevation usage.
extension UIColor {
    
    /// Returns a color that takes the specified elevation value into account.
    /// The colot is the blended color of Surface and Elevation Overlay. Negative
    /// elevation is treated as 0.
    /// Pattern-based UIColor is not supported.
    /// - **elevation**: The `f1_absoluteElevation` value to use when resolving the color.
    public func f1_resolvedColor(with elevation: CGFloat) -> UIColor {
        // TODO
        return .clear
    }
    
    /// Returns a color that takes the specified elevation value and traits into account when there is a
    /// color appearance differnece between current traits and previous traits. When `userInterface` is
    /// `UIUserInterfaceStyle.dark` in currentTraitCollection, elevation will be used to resolve the
    /// color.
    ///
    /// Negative elevation is treated as 0.
    /// Pattern-based UIColor is not supported.
    ///
    public func f1_resolvedColor(with traitCollection: UITraitCollection,
                                 previous previousTraitCollection: UITraitCollection,
                                 elevation: CGFloat) -> UIColor {
        // TODO
        return .clear
    }
}
