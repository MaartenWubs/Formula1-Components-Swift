//
//  F1ShapeGenerating.swift
//  Formula1-Components-Swift
//
//  Created by Maarten Wubs on 7/24/22.
//

import Foundation
import UIKit

public protocol F1ShapeGenerating: NSCopying {
    func path(for size: CGSize) -> CGPath?
}
