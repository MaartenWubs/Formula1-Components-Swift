//
//  UIColor+Formula1Dynamic.swift
//  Formula1-Components-Swift
//
//  Created by Maarten Wubs on 7/16/22.
//

import Foundation
import UIKit

extension UIColor {
    @available(iOS 13, *)
    public func colorWithUserInterfaceStyleDarkColor(_ darkColor: UIColor,
                                                     _ defaultColor: UIColor) -> UIColor {
        return .init { traitCollection in
            if traitCollection.userInterfaceStyle == UIUserInterfaceStyle.dark {
                return darkColor
            } else {
                return defaultColor
            }
        }
    }
    
    @available(iOS 13.0, *)
    public func colorWithAccessibilityContrastHigh(_ highContrastColor: UIColor,
                                                   _ normal: UIColor) -> UIColor {
        return UIColor { traitCollection in
            if traitCollection.accessibilityContrast == UIAccessibilityContrast.high {
                return highContrastColor
            } else {
                return normal
            }
        }
    }
    
    @available(iOS 13.0, *)
    func f1_resolvedColorWithTraitCollection(_ traitCollection: UITraitCollection) -> UIColor {
        return self.resolvedColor(with: traitCollection)
    }
}
