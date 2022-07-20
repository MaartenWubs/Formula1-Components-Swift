//
//  F1ActivityIndicator.swift
//  Formula1-Components-Swift
//
//  Created by Maarten Wubs on 7/18/22.
//

import Foundation
import UIKit

//TODO: [f1a210h5] build activity indicator.

// MARK: -Private global properties
let qTotalDetentCount: Int = 5
let qAnimateOutDuration: TimeInterval = 0.1
let qCycleRotation: CGFloat = (3.0 / 2)
let qOuterRotationIncrement: CGFloat = ((1.0 / Double(qTotalDetentCount))
                                        * Double.pi)
let qSpinnerRadius: CGFloat = 12
let qStrokeLength: CGFloat = 0.75
let qStrokeWidth: CGFloat = 2.5

let qSingleCycleRotation: CGFloat = (2 * qStrokeLength + qCycleRotation
                                     + (1.0 / Double(qTotalDetentCount)))

/// Different operating modes for the activity indicator.
///
/// This component can be used as a determinte progress indicator or an indeterminate activity
/// indicator.
///
/// Default value is `F1ActivityIndicatorMode.indeterminate`.
public enum F1ActivityIndicatorMode {
    case indeterminate
    case determinate
}

/// A Formula1 activity indicator
///
/// The activity indicator is a circular spinner that shows progress of an operation. By default the
/// activity indicator assumes indeterminate progress of an unspecified length of time. In contrast to
/// a standard `UIActivityIndicator`, `F1ActivityIndicator` supports showing determinate
/// progress and uses custom animations for indeterminate progress.
@IBDesignable
public class F1ActivityIndicator: UIView {
    
    // MARK: - Public properties
    
    /// The callback delegate. See `F1ActivityIndicatorDelegate`.
    public weak var delegate: F1ActivityDelegate?
    
    /// Whether or not the activity indicator is currently animating.
    public var animated: Bool = false

    /// The array of colors that are cycled through when animating the spinner. Populated with a set of
    /// default colors.
    ///
    /// **Note**: If an empty arry is provided to this property's setter, then the provided array will be
    /// discarded and an array consisting of the default color values will be assigned instead.
    public var cycleColors: [UIColor] = []
    
    // MARK: - Private properties
    
    var _animatingOut = false
    var _animationsAdded = false
    var _animationInProgress = false
    var _bacgrounded = false
    var _cycleInProgress = false
    var currentProgress: CGFloat = 0.0
    var _lastProgress: CGFloat = 0.0
    
    // MARK: - Init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonF1ActivityIndicatorInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonF1ActivityIndicatorInit()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func commonF1ActivityIndicatorInit() {}
    
    // MARK: UIView
    
    public override func willMove(toWindow newWindow: UIWindow?) {
        if let newWindow {
            
        } else {
            
        }
    }
    
    /// Starts the animated activity indicator. Does nothing if the spinner is already animating.
    public func startAnimating() {}
    
    /// Starts the animated activity indicator after performing the provided transition. The animation
    /// cycle will begin on the cycleStartIndex provided. The startTransition will be applied with the
    /// starting and ending positions of the indicator stroke at the moment when the animation will begin
    /// taking into account the provided cycleStartIndex in the range [0,1]. The indicatorMode must be
    /// `F1ActivityIndicatorMode.indeterminate` vefore calling.
    public func startAnimating(with transition: F1ActivityIndicatorTransition,
                               cycleStartIndex: Int) {}
    
    /// Stops the animated activity indicator with a short opcity and stroke width animation. Does nothing
    /// if the spinner is not animating.
    public func stopAnimating() {}
    
    /// Stops the animated activity indicator and then performs the provided transition. The provided
    /// stopTransition will be called with the starting and ending position of the indicator stroke at the
    /// moment when the animation will begin in the range [0,1]. The indicatorMode must be
    /// `F1ActivityIndicatorMode.indeterminate` before calling.
    public func stopsAnimating(with transition: F1ActivityIndicatorTransition) {}
    
    /// Set the mode of the activity indicator. If currently animating, it will animate the transition
    /// between the current  mode to the new mode. Default is `F1ActivityIndicatorMode.indeterminate`
    /// with no animation.
    public func setIndicator(for mode: F1ActivityIndicatorMode, animated: Bool) {}
    
    /// Set the determinate progress of the activity indicator when indicatorMode is
    /// `F1ActivityIndicatorMode.determinate`.
    public func setProgress(for progress: CGFloat, animated: Bool) {}
    
    // MARK: - Private methods
    
    func registerForegroundAndBackgroundNotificationObserversIfNeeded() {}
}

public typealias F1ActivityIndicatorAnimation = (_ strokeStart: CGFloat,
                                                 _ strokeEnd: CGFloat) -> Void

/// Describes an animation that can be provided to an `F1ActivityIndicator` instance to perform
/// before or after its standard cycle animation.
public class F1ActivityIndicatorTransition: NSObject {
    
    /// The animations to be performed by `F1ActivityIndicator`. In the block add CAAnimations to be
    /// animated before or after `F1ActivityIndicator`'s cycle animation.
    /// `F1ActivityIndicator` will trigger these animations and call completion after they complete.
    public var animation: F1ActivityIndicatorAnimation = {_,_ in }
    
    /// The completion block to call after animation's completion. This should be used to clean up
    /// any layers plcaed and animating on the `F1ActivityIndicator`.
    public var completion: (() -> Void)?
    
    /// The duration of the animation.
    public var duration: TimeInterval = 0.0
    
    public override init() {}
    
    public init(coder: NSCoder) {}
    
    public init(animation: F1ActivityIndicatorAnimation) {}
}
