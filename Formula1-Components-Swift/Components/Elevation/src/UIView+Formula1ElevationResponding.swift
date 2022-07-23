//
//  UIView+Formula1ElevationResponding.swift
//  Formula1-Components-Swift
//
//  Created by Maarten Wubs on 7/18/22.
//

import Foundation
import CoreGraphics
import UIKit

/// Allows elevation changes to propagate down the view hieratchy and allows objects
/// conforming to `F1Elevatable` to react to those changes accordingly
extension UIView {
    
    /// Returns the sum of all `f1_currentElevation` of the superviews going up the view
    /// hierarchy recursively.
    ///
    /// If a view in the hierarchy conforms to `F1ElevationOverriding` and `f1_overrideBaseElevation`
    /// is non-negative, then the sum of the current total plus the value of `f1_overrideBaseElevation`
    /// is returned.
    ///
    /// If a `UIViewController` conforms to `F1Elevatable` of `F1ElevationOverriding` then its `view`
    /// will report the view controllers base elevation.
    public func f1_baseElevation() -> CGFloat  {
        var totalElevation: CGFloat = 0
        var current: UIView = self

        let elevatableCurrent = current.objectConformingToElevationInResponderChain()
        
        if current != self {
            totalElevation += elevatableCurrent?.f1_currentElevation ?? 0.0
        }
        
        let elevatableCurrentOverride = current.objectConformingToOverrideInResponderChain()
        if elevatableCurrentOverride != nil && (elevatableCurrentOverride?.f1_overrideBaseElevation ?? 0) >= 0 {
            totalElevation += elevatableCurrentOverride?.f1_overrideBaseElevation ?? 0.0
        }
        
        if let superview = current.superview {
            current = superview
        }

        return totalElevation
    }
    
    /// Returns the sum of the view's `f1_currentElevation` with the `f1_currentElevation` of its
    /// superview going up the view hierarchy recursively.
    ///
    /// This value is effectively the sum of `f1_baseElevation` and `f1_currentElevation`.
    public func f1_absoluteElevtaion() -> CGFloat {
        var elevation = f1_baseElevation()
        let elevatableSelf = objectConformingToElevationInResponderChain()
        elevation += elevatableSelf?.f1_currentElevation ?? 0.0
        return elevation
    }
    
    /// Should be called when the view's `f1_currentElevation` has changed. Will be called on the
    /// reciever's `subviews
    ///
    /// If a `UIView` views conform to `F1Elevatioin` then `f1_elevationDidChange()` is called.
    public func f1_elevationDidChange() {
        let base = f1_baseElevation
        self.f1_elevationDidChangeWithBaseElevation(base())
        
    }
    
    /// Checks whether a `UIView` or it's managing `UIViewController` confrom to
    /// `F1ElevationOverride`
    ///
    /// - Returns: the conforming `UIView` then `UIViewController`, otherwise `nil`.
    func objectConformingToOverrideInResponderChain() -> F1ElevationOverriding? {
        if self is F1ElevationOverriding {
            return self as? F1ElevationOverriding
        }
        
        let nextResponder = next
        if (nextResponder is UIViewController) && nextResponder is F1ElevationOverriding {
            return nextResponder as? F1ElevationOverriding
        }
        
        return nil
    }
    
    /// Checks whether a `UIView` or it's managing `UIViewController` confrom to
    /// `F1Elevation`
    ///
    /// - Returns: the conforming `UIView` then `UIViewController`, otherwise
    /// `nil`.
    func objectConformingToElevationInResponderChain() -> F1Elevatable? {
        if self is F1Elevatable {
            return self as? F1Elevatable
        }
        
        let nextResponder = next
        if (nextResponder is UIViewController) && nextResponder is F1Elevatable {
            return self as? F1Elevatable
        }
        return nil
    }
    
    func f1_elevationDidChangeWithBaseElevation(_ baseElevation: CGFloat) {
        var elevation: CGFloat = baseElevation
        let elevatableSelf = self.objectConformingToElevationInResponderChain()
        if elevatableSelf?.f1_elevationDidChange != nil {
            elevation += elevatableSelf?.f1_currentElevation ?? 0.0
            elevatableSelf?.f1_elevationDidChange!(elevatableSelf!, elevation)
        }
        
        for subview in subviews {
            subview.f1_elevationDidChangeWithBaseElevation(elevation)
        }
    }
}
