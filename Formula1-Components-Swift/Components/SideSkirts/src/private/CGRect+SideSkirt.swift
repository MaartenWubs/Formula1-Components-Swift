//
//  CGRect+SideSkirt.swift
//  Formula1-Components-Swift
//
//  Created by Maarten Wubs on 7/22/22.
//

import Foundation
import CoreGraphics
import UIKit

extension CGRect {
    internal func verticallyCentered(_ rect: CGRect,
                                     _ padding: UIEdgeInsets,
                                     _ height: CGFloat,
                                     _ pixelScale: CGFloat) -> CGRect {
        let viewHeight: CGFloat = rect.height + padding.top + padding.bottom
        var yValue = (height - viewHeight) / 2
        yValue = round(yValue * pixelScale) / pixelScale
        return rect.offsetBy(dx: 0, dy: yValue)
    }
}
