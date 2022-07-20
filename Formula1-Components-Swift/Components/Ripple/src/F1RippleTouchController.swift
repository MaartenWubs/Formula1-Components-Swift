//
//  F1RippleTouchController.swift
//  Formula1-Components-Swift
//
//  Created by Maarten Wubs on 7/17/22.
//

import Foundation
import UIKit

// TODO: [f1r4390f290-ripple] fill in the todo's and check documentation.

/// The F1RippleTouchController is a convenience controller that adds all the neededtouch tracking
/// and logic to provide the correct ripple effect based on the user interacting with the view the
/// ripple is added to.
public class F1RippleTouchController: NSObject {
    
    private var rapWentOutsideOfBounds = true
    private var deferred = true
    
    struct _delegateFlags {
        public var shouldProcessAtTouchLocation: Bool
        public var didProcessRippleAtTouchLocation: Bool
        public var insertRippleIntoView: Bool
        public var rippleViewAtTouchLocation: Bool
    }
    
    /// A weak reference to the view that the ripple is added to, and that responds to the user
    /// events.
    public weak var view: UIView?
    
    /// The ripple view added to the view
    public var rippleView: F1RippleView!
    
    /// A delegate to extend the behaviour of the touch controller.
    public var delegate: F1RippleTouchControllerDelegate?
    
    /// The gesture recognizer used to bind the touch events to the ripple.
    public var gestureRecognizer: UILongPressGestureRecognizer!
    
    /// If set to `false`, the ripple gesture will fail and not be initiated if ther are other competing
    /// gestures that belong to a UIScrollView. This helps the ripple not be invoked if a user wants
    /// to scroll but does so while tapping on a view that incorporates a ripple.
    public var shouldProcessRippleWithScrollViewGesture = true
    
    /// Initializes the controller and adds the initialized ripple view as a subview of the provided view.
    ///
    /// **Note**: When using this initializer, calling `addRipple(to:)` is not needed.
    ///
    /// **view**: The view that responds to the touch events for the ripple. The ripple
    /// is added to it as a subview.
    /// **Returns** an `F1RippleTouchController` instance.
    public func initWithView(_ view: UIView) -> F1RippleTouchController {
        return self.initWithView(view, deferred: false)
    }
    
    /// Initializes the controller
    ///
    /// **Note**: To effectively use the controller a call to `addRipple(to:)` is needed to provide a view
    /// that responds to the touch events for the ripple. The ripple is added to the viewas a subview.
    ///
    /// **Returns**: an `F1RippleTouchController` instance.
    public override init() {
        super.init()
        self.gestureRecognizer = UILongPressGestureRecognizer(target: self,
                                                              action: #selector(handleRippleGesture))
        self.gestureRecognizer.minimumPressDuration = 0
        self.gestureRecognizer.delegate = self
        self.gestureRecognizer.cancelsTouchesInView = false
        self.gestureRecognizer.delaysTouchesEnded = false
        shouldProcessRippleWithScrollViewGesture = true
    }
    
    /// Initializes the controller and based on the deffered parameter is adding the ripple view
    /// immediately as subview of the provided view.
    ///
    /// **Note**: If `true` is passed for the deferred parameter and
    /// `rippleTouchController(_:insert:into:)` is not implemented, the rippleView will
    /// beautomatically added as the top subview to the given view when the first tap event is happening.
    /// When `rippleTouchController(_:insert:into:)` is implemented, it's the responsibility of
    /// the delegate to add the ripple view in the proper position within the view's hierarchy if the delegate
    /// method is called.
    ///
    /// - **view**: The view that responds to the touch events for the ripple. The ripple
    /// is added to it as a subview.
    /// - **deferred**: Whether the insertion of the rippleView to the provided view should be
    /// happened deferred.
    /// **Returns** an `F1RippleTouchController` instance.
    public func initWithView(_ view: UIView, deferred: Bool) -> F1RippleTouchController {
        self.deferred = deferred
        if deferred {
            self.attatchGestureRecognizer(to: view)
        } else {
            self.configureRipple(with: view)
        }
        return self
    }
    
    /// Adds the ripple view as a subview to the provided view, and adds the ripple's gesture recognizer
    /// to it.
    ///
    /// **Note**: The needs to be called if using the `init` initializer rather that the `initWithView(_:)`
    /// initializer.
    ///
    /// - **view**: The view that responds to the touch events for the ripple. The ripple
    /// is added to it as a subview.
    public func addRipple(to view: UIView) {
        self.configureRipple(with: view)
    }
    
    func setDelegate(_ delegate: F1RippleTouchControllerDelegate) {
        self.delegate = delegate
        
    }
    
    func attatchGestureRecognizer(to view: UIView) {
        self.view?.removeGestureRecognizer(gestureRecognizer)
        self.view = view
        self.view?.addGestureRecognizer(gestureRecognizer)
    }
    
    func configureRipple(with view: UIView) {
        self.attatchGestureRecognizer(to: view)
        self.insertRippleView(into: view)
    }
    
    func insertRippleView(into view: UIView) {
        if let rippleView = self.rippleView {
            self.delegate!.rippleTouchController(self, insert: rippleView, into: view)
        } else {
            self.view?.addSubview(rippleView)
        }
        rippleView.frame = view.bounds
    }
    
    @objc
    func handleRippleGesture(_ recognizer: UILongPressGestureRecognizer) {
        // TODO
    }
}

// MARK: - Delegate methods

extension F1RippleTouchController: UIGestureRecognizerDelegate {
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        // TODO
        return true
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                                  shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        // This can be overwritten if an other priority is neccecary.
        return true
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                                  shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if !self.shouldProcessRippleWithScrollViewGesture &&
            otherGestureRecognizer.view!.isKind(of: UIScrollView.self) &&
            otherGestureRecognizer.isKind(of: UITapGestureRecognizer.self) &&
            otherGestureRecognizer.isKind(of: UILongPressGestureRecognizer.self) {
            return true
        }
        return false
    }
}

extension F1RippleTouchController: F1RippleTouchControllerDelegate {
    @objc public func rippleTouchController(_ rippleTouchController: F1RippleTouchController, shouldProcessTouchesAt location: CGPoint) -> Bool {
        return true
    }
    
    @objc public func rippleTouchController(_ rippleTouchController: F1RippleTouchController, didProcess rippleView: F1RippleView, at location: CGPoint) {
        
    }
    
    @objc public func rippleTouchController(_ rippleTouchController: F1RippleTouchController, insert rippleView: F1RippleView, into view: UIView) {
        
    }
    
    @objc public func rippleTouchController(_ rippleTouchController: F1RippleTouchController, rippleViewAt location: CGPoint) -> F1RippleView {
        return F1RippleView()
    }
}
