//
//  CAMediaTimingFunction+F1AnimationTiming.swift
//  Formula1-Components-Swift
//
//  Created by Maarten Wubs on 7/18/22.
//

import Foundation
import UIKit

public enum F1AnimationTimingFunction {
    
}

/// Formula1 animation curves
extension UIView.AnimationCurve {
    
    /// Returns the corresponding `CAMediaTimingFunction` for the given curve specified by an
    /// enum. The most common curve is `easeInOut`.
    ///
    /// - **type**: A Formula1 media timing function.
    public func f1_function(with type: F1AnimationTimingFunction) -> UIView.AnimationCurve {
        // TODO
        
    }
}
