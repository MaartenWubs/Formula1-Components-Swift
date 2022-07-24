//
//  F1FeaturedHighlightView.swift
//  Formula1-Components-Swift
//
//  Created by Maarten Wubs on 7/18/22.
//

import Foundation
import UIKit

// TODO: [f1f55490ggf0-feturesHighlights]

public class F1FeaturedHighlighView: UIView, UIContentSizeCategoryAdjusting {
    public var adjustsFontForContentSizeCategory: Bool = false
    
    public var innerHighlightColor: UIColor?
    public var outerHighlightColor: UIColor?
    public var titleFont: UIFont?
    public var titleColor: UIColor?
    public var bodyFont: UIFont?
    public var bodyColor: UIColor?
    
    public var f1_legacyFontScaling = false
    
    public var traitCollectionDidChange: ((_ featureHighlight: F1FeaturedHighlighView,
                                           _ previousTraitCollection: UITraitCollection?) -> Void)?
}
