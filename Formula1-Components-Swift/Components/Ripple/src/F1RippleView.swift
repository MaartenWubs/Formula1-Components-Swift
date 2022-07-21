//
//  F1RippleView.swift
//  Formula1-Components-Swift
//
//  Created by Maarten Wubs on 7/16/22.
//

import Foundation
import UIKit

public enum F1RippleStyle: Int {
    case bounded = 0
    case unbounded
}

// MARK: - Public methods

/// A UIView that draws and animates the Formula1 Design ripple effect for touch interactions.
///
/// The Ripple is a visual flourish consisting of an animated circle with various scale, opacity and
/// position animations applied simultaneously to give the illusion of ink applied to a paper surface.
///
/// The touch feedback ripple effect is a prominent entity across all our interactable components:
/// i.e., buttons, cards, tab bars, list items.
///
/// There can be multiple riples occurring at the same time, each represented by an F1RippleLayer.
public class F1RippleView: UIView {

    /// The ripple view delegate.
    public weak var rippleViewDelegate: F1RippleViewDelegate? = nil
   
    /// The ripple style indicating if the ripple is bounded or unbounded to the view.
    public var rippleStyle: F1RippleStyle? = nil
    
    /// The ripple's color.
    public var rippleColor: UIColor = UIColor.clear
    
    /// The maximum radius the ripple can expand to.
    ///
    /// This property is ignored if `rippleStyle` is set the `F1RippleStyle.bounded`.
    public var maximumRadius: CGFloat = 0.0
    
    /// The ripple color if the currently active ripple.
    public var activeRippleColor: UIColor = UIColor.clear
    
    /// When rippleStyle is `F1RippleStyle.bounded`, this flag affects whether the layer's mask will use
    /// the super view's `layer.shadowPath` as the mask path.
    ///
    /// This behavior only takes effect if the ripple view's parent view has a non-nil `shadowPath`.
    ///
    /// This behavioral flag will eventually become `false` be default and the be deleted. The `true`
    /// behavior is undesired because it assumes that the frame of the ripple vew always matches the
    /// bounds of the superview. When this assumption is false, such as when the ripple's origin is
    /// non-zero, the ripple's mask tends to be bigger than it should be resulting in an incorrectly
    /// clipped ripple effect. Consider disabling this behavior and explicitly setting a layer mask
    /// instead.
    ///
    /// changing the value to `false` does not clear the mask if it was already set.
    ///
    /// default value is `true`.
    public var usesSuperviewShadowLayerAsMask: Bool = true
    
    /// A block that is invoked when the `F1RippleView` recieves a call to `traitCollectionDidChange:`.
    /// The block is called after the call to the superclass.
    public var traitCollectionDidChange:((_ ripple: F1RippleView,
                                          _ previousTraitCollection: UITraitCollection?) -> Void)?
    
    var activeRippleLayer: F1RippleLayer?
    
    var maskLayer: CAShapeLayer?
    
    /// Cancels all the existing ripples.
    ///
    /// **animated**: Whether to animate the cancellation of hte ripples or not.
    public func cancelAllRipples(animated: Bool, completion: @escaping () -> Void) {
        let sublayers = layer.sublayers!
        if animated {
            var latestBeginTouchDownRippleTime: CFTimeInterval = .leastNormalMagnitude
            for sublayer in sublayers {
                if sublayer.isKind(of: F1RippleLayer.self) {
                    let rippleLayer = F1RippleLayer()
                    latestBeginTouchDownRippleTime = max(latestBeginTouchDownRippleTime,
                                                         rippleLayer.rippleTouchDownStartTime)
                }
            }
            let group = DispatchGroup()
            for sublayer in sublayers {
                if sublayer.isKind(of: F1RippleLayer.self) {
                    let rippleLayer = F1RippleLayer()
                    if rippleLayer.startAnimationActive {
                        rippleLayer.rippleTouchDownStartTime = latestBeginTouchDownRippleTime + qRippleFadeOutDelay
                    }
                    group.enter()
                    rippleLayer.endRipple(animated: animated) {
                        group.leave()
                    }
                }
            }
            group.notify(queue: .main) {
                completion()
            }
        } else {
            for sublayer in sublayers {
                if sublayer.isKind(of: F1RippleLayer.self) {
                    let rippleLayer = F1RippleLayer()
                    rippleLayer.removeFromSuperlayer()
                }
            }
            completion()
        }
    }
    
    /// Fades the ripple in by changing its opacity.
    ///
    /// **animated**: Whether or not the fade in should be animated or not.
    /// **completion**: A completion block called after the completion of the animation.
    public func fadeIn(_ animated: Bool, completion: @escaping () -> Void) {
        if let activeRippleLayer = activeRippleLayer {
            activeRippleLayer.fadeInRipple(animated: animated, completion: completion)
        } else {
            completion()
            return
        }
    }
    
    /// Fades the ripple out by changing its opacity
    ///
    /// **animated**: Whether or not the fade out should be animated or not.
    /// **completion**: A completion block ccalled after the completion of the animation.
    public func fadeOut(_ animated: Bool, completion: @escaping () -> Void) {
        if let activeRippleLayer = activeRippleLayer {
            activeRippleLayer.fadeOutRipple(animated: animated, completion: completion)
        } else {
            completion()
            return
        }
    }
    
    /// Begins the ripple's touch down animation at the given point. This presents the ripple and leaves it
    /// on the view. If animated, it animates the expanding ripple circle effect.
    /// To then remove the ripple, `beginTouchUp(_ animated:)` needs to be called.
    ///
    /// **point**: The point to start the ripple animation.
    /// **animated**: Whether or not the ripple should be animated or not.
    /// **completion**: A completion block called after the completion of the animation.
    public func beginTouchDownAt(_ point: CGPoint,
                                 animated: Bool,
                                 completion: @escaping () -> Void) {
        let rippleLayer = F1RippleLayer()
        rippleLayer.rippleLayerDelegate = self
        self.updateRippleStyle()
        self.setColor(for: rippleLayer)
        rippleLayer.frame = self.bounds
        if self.rippleStyle == F1RippleStyle.bounded {
            rippleLayer.maximumRadius = self.maximumRadius
        }
        self.layer.addSublayer(rippleLayer)
        rippleLayer.startRippleAtPoint(point, animated: animated, completion: completion)
        self.activeRippleLayer = rippleLayer
    }
    
    /// Begins the ripple's touch up animation. This removes the ripple from the view. If animated, the ripple
    /// dissolves using an animted opacity change.
    ///
    /// **animated**: Whether or not the ripple should be animted or not.
    /// **completion**: A completion block called after the completion of the animation.
    public func beginTouchUp(_ animated: Bool, completion: @escaping () -> Void) {
        if let activeRippleLayer = activeRippleLayer {
            activeRippleLayer.endRipple(animated: animated, completion: completion)
        } else {
            completion()
            return
        }
    }
    
    /// Enumerates the given view's subviews for an instance of the `F1RippleView` and returns it if found,
    /// orcreates and adds a new instance of `F1RippleView` if not.
    ///
    /// This method is a convenience method for adding ripple to an arbitrary view without needing to
    /// subclass the target view. Use this method is situations where you expect there to be many distinct
    /// ripple views. in existence for a single ripple touch controller. Example scenarious include:
    ///
    /// - Adding ripple to individual collection view/table view cells.
    ///
    /// This method can be used in your `F1RippleTouchController` delegate's
    /// - `rippleTouchController(_:, rippleViewAt:)` implementation.
    public func injectViewIn(_ view: UIView) -> F1RippleView {
        for subview in view.subviews {
            if subview.isKind(of: F1RippleView.self) {
                return subview as! F1RippleView
            }
        }
        
        let newRippleView = F1RippleView(frame: view.bounds)
        newRippleView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(newRippleView)
        return newRippleView
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonF1RippleViewInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonF1RippleViewInit()
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if let traitCollectionDidChange = traitCollectionDidChange {
            traitCollectionDidChange(self, previousTraitCollection)
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.activeRippleLayer?.fillColor = self.activeRippleColor.cgColor
    }
    
    public override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        
        if let subLayers = self.layer.sublayers {
            if subLayers.count > 0 {
                self.updateRippleStyle()
            }
            for subLayer in subLayers {
                subLayer.frame = self.bounds.standardized
                subLayer.setNeedsLayout()
            }
        }
    }
    
    public override func action(for layer: CALayer, forKey event: String) -> CAAction? {
        if (event == "path") || (event == "shadowPath") {
            let pendingAnimation = F1RipplePendingAnimation()
            pendingAnimation.animationSourceLayer = self.superview?.layer
            pendingAnimation.fromValue = layer.presentation()?.value(forKey: event)
            pendingAnimation.toValue = nil
            pendingAnimation.keyPath = event
            
            return pendingAnimation
        }
        return nil
    }
}

let qRippleDefaultAlpha: CGFloat = 0.12

// MARK: - Private methods.

extension F1RippleView {
    func commonF1RippleViewInit() {
        usesSuperviewShadowLayerAsMask = true
        self.isUserInteractionEnabled = false
        self.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        let defaultRipplColor = UIColor(white: 0, alpha: qRippleDefaultAlpha)
        rippleColor = defaultRipplColor
        rippleStyle = F1RippleStyle.bounded
    }
    
    func updateRippleStyle() {
        self.layer.masksToBounds = self.rippleStyle == F1RippleStyle.bounded
        if self.rippleStyle == F1RippleStyle.bounded {
            if self.usesSuperviewShadowLayerAsMask && ((self.superview?.layer.shadowPath) != nil) {
                if let maskLayer = maskLayer {
                    maskLayer.delegate = self
                }
                maskLayer?.path = self.superview?.layer.shadowPath
                layer.mask = maskLayer
            }
        } else {
            layer.mask = nil
        }
    }
    
    func setRippleStyle(_ rippleStyle: F1RippleStyle) {
        self.rippleStyle = rippleStyle
        self.updateRippleStyle()
    }
    
    func setUsesSuperviewShadownLayerAsMask(_ value: Bool) {
        usesSuperviewShadowLayerAsMask = value
        if usesSuperviewShadowLayerAsMask {
            self.setNeedsLayout()
        }
    }
    
    func setColor(for rippleLayer: F1RippleLayer) {
        if traitCollection.responds(to: #selector(UITraitCollection.performAsCurrent(_:))) {
            traitCollection.performAsCurrent { [self] in
                rippleLayer.fillColor = rippleColor.cgColor
            }
        }
    }
    
    func setActiveRippleColor(_ activeRippleColor: UIColor) {
        self.activeRippleColor = activeRippleColor
        if let activeRippleLayer = activeRippleLayer {
            activeRippleLayer.fillColor = activeRippleColor.cgColor
        }
    }
}

// MARK: - Delegate methods

extension F1RippleView: F1RippleViewDelegate {
    @objc
    public func rippleTouchDownAnimationDidBegin(_ rippleView: F1RippleView) {
    }
    
    @objc
    public func rippleTouchDownAnimationDidEnd(_ rippleView: F1RippleView) {
    }
    
    @objc
    public func rippleTouchUpAnimationDidBegin(_ rippleView: F1RippleView) {
    }
    
    @objc
    public func rippleTouchUpAnimationDidEnd(_ rippleView: F1RippleView) {
    }

}

extension F1RippleView: F1RippleLayerDelegate {
    public func rippleLayerTouchDownAnimationDidBegin(_ rippleView: F1RippleLayer) {
        if rippleViewDelegate!.responds(to: #selector(rippleTouchDownAnimationDidBegin(_:))) {
            self.rippleViewDelegate?.rippleTouchDownAnimationDidBegin(self)
        }
    }
    
    public func rippleLayerTouchDownAnimationDidEnd(_ rippleView: F1RippleLayer) {
        if rippleViewDelegate!.responds(to: #selector(rippleTouchDownAnimationDidEnd(_:))) {
            self.rippleViewDelegate?.rippleTouchDownAnimationDidEnd(self)
        }
    }
    
    public func rippleLayerTouchUpAnimationDidBegin(_ rippleView: F1RippleLayer) {
        if rippleViewDelegate!.responds(to: #selector(rippleTouchUpAnimationDidBegin(_:))) {
            self.rippleViewDelegate?.rippleTouchUpAnimationDidBegin(self)
        }
    }
    
    public func rippleLayerTouchUpAnimationDidEnd(_ rippleView: F1RippleLayer) {
        if rippleViewDelegate!.responds(to: #selector(rippleTouchUpAnimationDidEnd(_:))) {
            self.rippleViewDelegate?.rippleTouchUpAnimationDidEnd(self)
        }
    }
}

