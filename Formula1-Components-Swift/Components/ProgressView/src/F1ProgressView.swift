//
//  F1ProgressView.swift
//  Formula1-Components-Swift
//
//  Created by Maarten Wubs on 7/20/22.
//

import Foundation
import UIKit

// TODO: [f1p040ac644-progressView]

/// The mode the progress bar is in.
public enum F1ProgressViewMode {
    
    /// Display the progress in a determinate way.
    case determinate
    
    /// Display the progress in an indeterminate way.
    case indeterminate
}

/// The animation mode when animating backward progress.
public enum F1ProgressViewBackwardsAnimationMode {
    
    /// Animated negative progress by resetting to 0 and then animating
    /// to the new value.
    case reset
    
    /// Animate negative progress by animating from the current value.
    case amimate
}

/// A linear determinate progress view.
@IBDesignable
public class F1ProgressView: UIView {
    
    /// The color shown fo the portion of the progress view that is filled.
    public var progressTintColor: UIColor?
    
    /// An array of color objects used to defining the color of each gradient stop.
    /// All colors are spread uniformly across the range.
    ///
    /// Setting `progressTintColor` resets this propery to `nil`.
    ///
    /// The default is `nil`.
    public var progressTintColors: [UIColor]?
    
    ///The color shown for the portion of the progress view that is not filled.
    public var trackTintColor: UIColor?
    
    /// The corner radius for both the portion of the progress view that is filled and the track.
    ///
    /// This is not equivalent to configuring `self.layer.cornerRadius`; it instead configures the
    /// progress and the trackviews directly.
    ///
    /// Under `F1ProgressViewMode.indeterminate` mode, the progress view is fully rounded if this
    /// value is larger than 0
    ///
    /// The default is set to 0.
    public var cornerRadius: CGFloat = 0
    
    /// The current progress.
    ///
    /// The current progress is represented by a floating-point value betweem 0.0 and 1.0, inclusive, where
    /// 1.0 indicates the completion of the task. The default value is 0.0. Values less than 0.0 and
    /// greater than 1.0 are pinned to the 1.0 limit.
    /// To animate progress, use `setProgress(_:animated:completion:)`.
    public var progress: Float = 0.0
    
    /// If the progress view shows a constant loading animation, use `F1ProgressViewMode.indeterminate`
    /// or if based on progress, use `F1ProgressViewMode.determinate`.
    /// The default value is `F1ProgressViewMode.determinate`
    public var mode: F1ProgressViewMode = .determinate
    
    /// Indicates of the progress view is animating when `mode` is `F1ProgressViewMode.indeterminate`.
    ///
    /// The default value is `false`
    public var animating: Bool = false
    
    /// The backward progress animation mode.
    ///
    /// When animating progress which is lower than the current progress value, this mode
    /// will determine which animation to use. The default is `F1ProgressViewBackwardsAnimationMode.reset`.
    public var backwardProgressAnimationmode: F1ProgressViewBackwardsAnimationMode = .reset
}
