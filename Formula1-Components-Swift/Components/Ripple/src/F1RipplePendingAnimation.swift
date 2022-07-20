//
//  F1RipplePendingAnimation.swift
//  Formula1-Components-Swift
//
//  Created by Maarten Wubs on 7/17/22.
//

import Foundation
import UIKit

class F1RipplePendingAnimation: NSObject, CAAction {
    
    weak var animationSourceLayer: CALayer? = nil
    
    var keyPath: String?
    var fromValue: Any?
    var toValue: Any?
    
    func run(forKey event: String,
             object anObject: Any,
             arguments dict: [AnyHashable : Any]?) {
        if !(anObject is CAShapeLayer) {
            return
        }
        
        let layer = anObject as? CAShapeLayer
        let boundsAction = animationSourceLayer?.animation(forKey: "bounds.size")
        let isBasicAnimation = boundsAction?.isKind(of: CABasicAnimation.self)
        if !isBasicAnimation! {
            return
        }
        let animation = boundsAction?.copy() as? CABasicAnimation
        animation?.keyPath = self.keyPath ?? ""
        animation?.fromValue = self.fromValue!
        animation?.toValue = self.toValue!
        
        layer?.add(animation!, forKey: event)
    }
}
