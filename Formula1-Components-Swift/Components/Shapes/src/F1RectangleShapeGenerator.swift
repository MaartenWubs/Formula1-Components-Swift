//
//  F1RectangleShapeGenerator.swift
//  Formula1-Components-Swift
//
//  Created by Maarten Wubs on 7/25/22.
//

import Foundation
import UIKit

public class F1RectangleShapeGenerator: NSObject, F1ShapeGenerating {
    public func path(for size: CGSize) -> CGPath? {
        return nil
    }
    
    public func copy(with zone: NSZone? = nil) -> Any {
        return ""
    }
}
