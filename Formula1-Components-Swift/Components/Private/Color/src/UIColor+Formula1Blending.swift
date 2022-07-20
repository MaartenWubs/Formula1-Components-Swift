//
//  UIColor+Formula1Blending.swift
//  Formula1-Components-Swift
//
//  Created by Maarten Wubs on 7/16/22.
//

import Foundation
import UIKit

func blendColorChannel(_ value: CGFloat, _ bValue: CGFloat,
                       _ alpha: CGFloat, _ bAlpha: CGFloat) -> CGFloat {
    return ((1 - alpha) * bValue * bAlpha + alpha * value) / (alpha + bAlpha * (1 - alpha))
}

extension UIColor {
    public func f1_blendColor(_ color : UIColor,
                       withBackgroundColor backgroundColor: UIColor) -> UIColor {
        var red: CGFloat = 0.0, green: CGFloat = 0.0, blue: CGFloat = 0.0, alpha: CGFloat = 0.0
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        var bRed: CGFloat = 0.0, bGreen: CGFloat = 0.0, bBlue: CGFloat = 0.0, bAlpha: CGFloat = 0.0
        backgroundColor.getRed(&bRed, green: &bGreen, blue: &bBlue, alpha: &bAlpha)
        
        return .init(red: blendColorChannel(red, bRed, alpha, bAlpha),
                     green: blendColorChannel(green, bGreen, alpha, bAlpha),
                     blue: blendColorChannel(blue, bBlue, alpha, bAlpha),
                     alpha: alpha + bAlpha * (1 - alpha))
    }
}
