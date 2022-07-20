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
}
