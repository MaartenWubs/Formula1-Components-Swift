//
//  F1Math.swift
//  Formula1-Components-Swift
//
//  Created by Maarten Wubs on 7/16/22.
//

import Foundation
import UIKit
import CoreGraphics

public func F1DegreesToRadians(_ degrees: CGFloat) -> CGFloat {
    return degrees * Double.pi / 180.0
}

public func F1CGFloatEquals(_ a: CGFloat, _ b: CGFloat) -> Bool {
    let constantK: CGFloat = 3
    let epsilon: CGFloat = .ulpOfOne
    let min: CGFloat = .leastNormalMagnitude
    
    return (abs(a - b) < constantK * epsilon * abs(a + b) || abs(a - b) < min)
}

/// Checks wheter the provided floating point number is approximately zero based on a small
/// epsilon.
///
/// Note that ULP-based comparisons are not used because ULP-space is significantly distorted
/// around zero.
public func F1IsFloatApproximatelyZero(_ value: CGFloat) -> Bool {
    return (abs(value) < .ulpOfOne)
}

/// Checks wheter the provided floating point number is exactly zero
public func F1CIsCGFloatExactlyZero(_ value: CGFloat) -> Bool {
    return (value == 0)
}

public func F1Ceil(_ value: CGFloat, forScale scale: CGFloat) -> CGFloat {
    if F1CGFloatEquals(scale, 0) {
        return 0
    }
    return ceil(value * scale) / scale
}

/// Round the given value to floor with provided scale factor.
/// If **Scale** is zero, then the rounded value will be zero.
///
/// **value**: The value to round.
/// **scale**: The scale factor.
/// **return**: The floor value calculated using the rpovided scale factor.
public func F1FloorValue(_ value: CGFloat,
                      forScale scale: CGFloat) -> CGFloat {
    if F1CGFloatEquals(scale, 0) {
        return 0
    }
    
    return floor(value * scale) / scale
}

/// Expand `rect` to the smallest standardized rect containing it with pixel-aligned origin
/// and size. If **scale** is zero, then a scale of 1 will be used instead.
///
/// **rect**: the rectangle to align.
/// **scale**: the scale factor to use for pixel alignment.
///
/// **return**: the input rectangle aligned to the nearest pixels using the provided scale
/// factor.
public func F1AlignRect(_ rect: CGRect, toScale scale: CGFloat) -> CGRect {
    var internalScale = scale
    if CGRectIsNull(rect) {
        return CGRectNull
    }
    if F1CGFloatEquals(internalScale, 0) {
        internalScale = 1
    }
    
    if F1CGFloatEquals(internalScale, 1) {
        return CGRectIntegral(rect)
    }
    
    let originalMinimumPoint: CGPoint = CGPointMake(CGRectGetMinX(rect),
                                                    CGRectGetMinY(rect))
    let newOrigin: CGPoint = CGPointMake(floor(originalMinimumPoint.x * internalScale) / internalScale,
                                         floor(originalMinimumPoint.y * internalScale) / internalScale)
    
    let adjustWidthHeight: CGSize = CGSizeMake(originalMinimumPoint.x - newOrigin.x,
                                               originalMinimumPoint.y - newOrigin.y)
    return CGRectMake(newOrigin.x,
                      newOrigin.y,
                      ceil((CGRectGetWidth(rect) + adjustWidthHeight.width) * internalScale) / internalScale,
                      ceil((CGRectGetHeight(rect) + adjustWidthHeight.height) * internalScale) / internalScale)
}

public func F1RoundPoint(_ point: CGPoint, withScale scale: CGFloat) -> CGPoint {
    if F1CGFloatEquals(scale, 0) {
        return CGPointZero
    }
    return CGPointMake(round(point.x * scale) / scale,
                       round(point.y * scale) / scale)
}

/// Expand `size` to the closest larger pixel-aligned value. If **scale** is zero,
/// then a `CGSizeZero` will be returned.
///
/// **size**: the size to align.
/// **scale**: the scale factor to use for pixel alignment.
///
/// **return** the size aligned to the closest larger pixel-aligned value using the
/// provided scale factor.
public func F1CeilSize(_ size: CGSize, withScale scale: CGFloat) -> CGSize {
    if F1CGFloatEquals(scale, 0) {
        return CGSizeZero
    }
    return CGSizeMake(ceil(size.width * scale) / scale,
                      ceil(size.height * scale) / scale)
}

/// Align the centerPoint of a view so that its origin is pixel-aligned to the nearest pixel. Returns
/// `CGRectZero` if **scale** is zero or **bounds** is `CGRectNull`.
///
/// **center**: the unaligned center of the view.
/// **bounds**: the bounds of the view.
/// **scale**: the native scaling factor for pixel alignment.
///
/// **return** the center point of the view such that its origin will be pixel-aligned.
public func F1RoundCenter(_ center: CGPoint,
                   withBounds bounds: CGRect,
                   andScale scale: CGFloat) -> CGPoint {
    if F1CGFloatEquals(scale, 0) || CGRectIsNull(bounds) {
        return CGPointZero
    }
    
    let halfWidth: CGFloat = CGRectGetWidth(bounds) / 2
    let halfHeight: CGFloat = CGRectGetHeight(bounds) / 2
    var origin: CGPoint = CGPointMake(center.x - halfWidth,
                                      center.y - halfHeight)
    origin = F1RoundPoint(origin, withScale: scale)
    return CGPointMake(origin.x + halfWidth, origin.y + halfHeight)
}

/// Compare two edge insets using `F1CGFloatEquals`.
/// **insets1**: An edge inset to compare with insets2.
/// **insets2**: An edge inset to compare with insets1.
public func F1EdgeInsets(_ insets1: UIEdgeInsets,
                  equalsEdgeInsets insets2: UIEdgeInsets) -> Bool {
    let topEqual = F1CGFloatEquals(insets1.top, insets2.top)
    let leftEqual = F1CGFloatEquals(insets1.left, insets2.left)
    let bottomEqual = F1CGFloatEquals(insets1.bottom, insets2.bottom)
    let rightEqual = F1CGFloatEquals(insets1.right, insets2.right)
    return topEqual && leftEqual && bottomEqual && rightEqual
}
