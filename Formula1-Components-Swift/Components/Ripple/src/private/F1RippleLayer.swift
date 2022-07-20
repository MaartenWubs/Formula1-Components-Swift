//
//  F1RippleLayer.swift
//  Formula1-Components-Swift
//
//  Created by Maarten Wubs on 7/16/22.
//

import Foundation
import QuartzCore
import UIKit

let qExpandRippleBeyondSurface: CGFloat = 10
let qRippleStartingScale: CGFloat = 0.6
let qRippleTouchDownDuration: CGFloat = 0.225
let qRippleTouchUpDuration: CGFloat = 0.15
let qRippleFadeInDuration: CGFloat = 0.075
let qRippleFadeOutDuration: CGFloat = 0.075
let qRippleFadeOutDelay: CGFloat = 0.15

let qRippleLayerOpacityString: String = "opacity"
let qRippleLayerPositionString: String = "position"
let qRippleLayerScaleString: String = "transform.scale"

func GetInitialRippleRadius(_ rect: CGRect) -> CGFloat {
    return max(rect.width, rect.height) * qRippleStartingScale / 2
}

func GetFinalRippleRadius(_ rect: CGRect) -> CGFloat {
    return CGFloat(hypot(rect.midX, rect.midY) + qExpandRippleBeyondSurface)
}

/// The Ripple Layer presents and animates the ripple. There can be multiple Ripple Layers
/// as sublayers for F1RippleView. The Ripple Layer subclasses CAShapeLayer to leverage the path
/// property so we can conveniently draw the ripple circle.
public class F1RippleLayer: CAShapeLayer {
    
    /// The ripple layer delegate
    public weak var rippleLayerDelegate: F1RippleLayerDelegate? = nil
    
    /// A bool indicating if the start animation is currently active for this ripple layer
    public var startAnimationActive = false
    
    /// The ripple's touch down animation start time. It is measured in seconds as the
    /// current absolute time when the animation begins.
    public var rippleTouchDownStartTime: CFTimeInterval = 0.0
    
    /// The radius the ripple expands to when activated.
    ///
    /// This only impacts new ripples, if a ripple is already being animated this property will have
    /// no impact.
    public var maximumRadius: CGFloat = 0.0
    
    public override func setNeedsLayout() {
        super.setNeedsLayout()
        
        self.calculateRadiusAndSetPath()
        self.position = CGPoint.init(x: self.bounds.midX, y: self.bounds.midY)
    }
    
    func calculateRadiusAndSetPath() {
        self.setPathFromRadii(self.calculateRadius())
    }
    
    func setPathFromRadii(_ radius: CGFloat) {
        let ovalRect: CGRect = CGRect.init(x: self.bounds.midX, y: self.bounds.midY, width: radius * 2, height: radius * 2)
        let circlePath = UIBezierPath(ovalIn: ovalRect)
        self.path = circlePath.cgPath
    }
    
    func calculateRadius() -> CGFloat {
        return self.maximumRadius > 0 ? self.maximumRadius : GetFinalRippleRadius(self.bounds)
    }
    
    /// Starts the ripple at the given point.
    ///
    /// **point**: The point to start the ripple animation.
    /// **animated**: Whether or not the ripple should be animated or not.
    /// **completion**: A completion block called after the completion of the animation.
    public func startRippleAtPoint(_ point: CGPoint, animated: Bool, completion: @escaping () -> Void) {
        rippleLayerDelegate?.rippleLayerTouchDownAnimationDidBegin(self)
        let finalRadius: CGFloat = self.calculateRadius()
        setPathFromRadii(finalRadius)
        self.opacity = 1
        self.position = CGPoint.init(x: self.bounds.midX, y: self.bounds.midY)
        if animated {
            completion()
            rippleLayerDelegate?.rippleLayerTouchDownAnimationDidEnd(self)
        } else {
            self.startAnimationActive = true
            
            let startingScale: CGFloat = GetInitialRippleRadius(self.bounds) / finalRadius
            let scaleAnimationn = CABasicAnimation()
            scaleAnimationn.keyPath = qRippleLayerScaleString
            scaleAnimationn.fromValue = startingScale
            scaleAnimationn.toValue = 1
            scaleAnimationn.timingFunction = CAMediaTimingFunction(name: .default)
            
            let centerPath = UIBezierPath()
            let startPoint = point
            let endPoint = CGPoint.init(x: self.bounds.midY, y: self.bounds.midY)
            centerPath.move(to: startPoint)
            centerPath.addLine(to: endPoint)
            centerPath.close()
            
            let positionAnimation = CAKeyframeAnimation()
            positionAnimation.keyPath = qRippleLayerPositionString
            positionAnimation.path = centerPath.cgPath
            positionAnimation.keyTimes = [0, 1]
            positionAnimation.values = [0, 1]
            positionAnimation.timingFunction = CAMediaTimingFunction(name: .default)
            
            let fadeInAnimation = CABasicAnimation()
            fadeInAnimation.keyPath = qRippleLayerOpacityString
            fadeInAnimation.fromValue = 0
            fadeInAnimation.toValue = 1
            fadeInAnimation.duration = qRippleFadeInDuration
            fadeInAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
            
            CATransaction.begin()
            let animationGroup = CAAnimationGroup()
            animationGroup.animations = [scaleAnimationn, positionAnimation, fadeInAnimation]
            animationGroup.duration = qRippleTouchUpDuration
            CATransaction.setCompletionBlock { [self] in
                startAnimationActive = false
                completion()
                rippleLayerDelegate?.rippleLayerTouchDownAnimationDidEnd(self)
            }
            self.add(animationGroup, forKey: nil)
            rippleTouchDownStartTime = CACurrentMediaTime()
            CATransaction.commit()
        }
    }
    
    /// Ends the ripple.
    ///
    /// **animated**: Whether or not the ripple should be animated or not.
    /// **completion**: A completion block called after the completion of the animation.
    public func endRipple(animated: Bool, completion: @escaping () -> Void) {
        var delay: CGFloat = 0
        if self.startAnimationActive {
            delay = qRippleFadeOutDelay
        }
        rippleLayerDelegate?.rippleLayerTouchUpAnimationDidBegin(self)
        CATransaction.begin()
        let fadeOutAnimation = CABasicAnimation()
        fadeOutAnimation.keyPath = qRippleLayerOpacityString
        fadeOutAnimation.fromValue = 1
        fadeOutAnimation.toValue = 0
        fadeOutAnimation.duration = animated ? qRippleTouchUpDuration : 0
        fadeOutAnimation.beginTime = self.convertTime(rippleTouchDownStartTime + delay, from: nil)
        fadeOutAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
        fadeOutAnimation.fillMode = .forwards
        fadeOutAnimation.isRemovedOnCompletion = false
        CATransaction.setCompletionBlock { [self] in
            completion()
            rippleLayerDelegate?.rippleLayerTouchUpAnimationDidEnd(self)
            removeFromSuperlayer()
        }
        self.add(fadeOutAnimation, forKey: nil)
        CATransaction.commit()
    }
    
    /// Fades the ripple in by changing the layer's opacity
    ///
    /// **animated**: Whether ot not the fade in should be animated or not.
    /// **completion**: A completion block called after the completion of the animation.
    public func fadeInRipple(animated: Bool, completion: @escaping () -> Void) {
        CATransaction.begin()
        let fadeInAnimation = CABasicAnimation()
        fadeInAnimation.keyPath = qRippleLayerOpacityString
        fadeInAnimation.fromValue = 0
        fadeInAnimation.toValue = 1
        fadeInAnimation.duration = animated ? qRippleFadeInDuration : 0
        fadeInAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
        fadeInAnimation.fillMode = .forwards
        fadeInAnimation.isRemovedOnCompletion = false
        CATransaction.setCompletionBlock {
            completion()
        }
        self.add(fadeInAnimation, forKey: nil)
        CATransaction.commit()
        
    }
    
    /// Fades the ripple out by changing the layer's opacity.
    ///
    /// **animated**: Whether or not the fade out should be animated or not.
    /// **completion**: A completion block called after teh completion of the animation.
    public func fadeOutRipple(animated: Bool, completion: @escaping () -> Void) {
        CATransaction.begin()
        let fadeOutAnimation = CABasicAnimation()
        fadeOutAnimation.keyPath = qRippleLayerOpacityString
        fadeOutAnimation.fromValue = 1
        fadeOutAnimation.toValue = 0
        fadeOutAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
        fadeOutAnimation.fillMode = .forwards
        fadeOutAnimation.isRemovedOnCompletion = false
        CATransaction.setCompletionBlock {
            completion()
        }
        self.add(fadeOutAnimation, forKey: nil)
        CATransaction.commit()
    }
}

