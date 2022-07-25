//
//  F1Button.swift
//  Formula1-Components-Swift
//
//  Created by Maarten Wubs on 7/20/22.
//

import Foundation
import UIKit

// TODO: [f1b40005ba-buttonView]

let kKVOContextCornerRadius = UnsafeMutablePointer<Any>(.none)


public class F1Button: UIButton {
    
    var _userElevation: NSMutableDictionary?
    var _backgroundColors: NSMutableDictionary?
    var _borderColors: NSMutableDictionary?
    var _borderWidths: NSMutableDictionary?
    var _shadowColors: NSMutableDictionary?
    var _imageTintColors: NSMutableDictionary?
    var _fonts: NSMutableDictionary?
    var _enabledAlpha: CGFloat?
    var _hasCustomDisabledTitleColor: Bool = false
    var _imageTintStatefulAPIEnabled: Bool = false
    var _nontransformedTitles: NSMutableDictionary?
    var _accessibilityLabelExplicitValue: String?
    var _f1_adjustFontForCOntentSizeCategory: Bool = false
    var _cornerRadiusObserverAdded: Bool = false
    var _inkMaxRippleRadius: CGFloat = 0
    var _shapedLayer: F1ShapeMediator?
    var _currentElevation: CGFloat = 0.0
    
    // TODO: Make F1StatefulRippleView
    //var _rippleView: F1StatefulRippleView
    //public var rippleView: F1StatefulRippleView {
    //    get { return _rippleView }
    //}
    
    var _inkView: F1InkView = .init()
    
    public var inkView: F1InkView {
        get { return _inkView }
        set { _inkView = newValue }
    }
    
    private(set) var ssLayer: F1ShapedShadowLayer?
    
    var _accessibilityTraitsIncludeButton: Bool = false
    public var accessibilityTraitsIncludeButton: Bool {
        get { return _accessibilityTraitsIncludeButton }
        set { _accessibilityTraitsIncludeButton = newValue }
    }
    
    var _enableTitleFontForState: Bool = false
    public var enableTitleFontForState: Bool {
        get { return _enableTitleFontForState }
        set { _enableTitleFontForState = newValue }
    }
    
    var _visibleAreaInsets: UIEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 0)
    public var visibleAreaInsets: UIEdgeInsets {
        get {
            if _visibleAreaInsets != .zero {
                return _visibleAreaInsets
            }
            var visibleAreaInsets: UIEdgeInsets = .zero
            if self.centerVisibileArea {
                var visibleAreaSize: CGSize
                if self.layoutTitleWithConstraints {
                    visibleAreaSize = self.systemLayoutSizeFitting(.init(width: self.bounds.size.width,
                                                                         height: self.bounds.size.height))
                } else {
                    visibleAreaSize = self.sizeThatFits(.init(width: CGFloat.greatestFiniteMagnitude,
                                                              height: CGFloat.greatestFiniteMagnitude))
                }
                let additionalHeight: CGFloat = max(0, self.bounds.height - visibleAreaSize.height)
                let additionalWidth: CGFloat = max(0, self.bounds.width - visibleAreaSize.width)
                visibleAreaInsets.top = ceil(additionalHeight * 0.5)
                visibleAreaInsets.bottom = additionalHeight - visibleAreaInsets.top
                visibleAreaInsets.left = ceil(additionalWidth * 0.5)
                visibleAreaInsets.right = additionalWidth - visibleAreaInsets.left
            }
            return visibleAreaInsets
        }
        set {
            if newValue == _visibleAreaInsets {
                return
            }
            
            _visibleAreaInsets = visibleAreaInsets
            
            if visibleAreaInsets == UIEdgeInsets.zero && !self.centerVisibileArea {
                self.shapeGenerator = nil
                
                if _cornerRadiusObserverAdded {
                    self.ssLayer?.removeObserver(self,
                                                 forKeyPath: NSStringFromSelector(Selector(("cornerRadius"))),
                                                 context: kKVOContextCornerRadius)
                    _cornerRadiusObserverAdded = false
                }
            } else {
                let shapeGenerator = self.generateShape(with: self.ssLayer!.cornerRadius,
                                                        visibleAreaInsets: visibleAreaInsets)
                self.configureLayerWith(shapeGenerator)
                if !_cornerRadiusObserverAdded {
                    self.ssLayer!.addObserver(self,
                                              forKeyPath: NSStringFromSelector(Selector(("cornerRadius"))),
                                              options: .new,
                                              context: kKVOContextCornerRadius)
                    _cornerRadiusObserverAdded = true
                }
            }
        }
    }
    
    var _visibleAreaLayoutGuideView: UIView = .init()
    public var visibleAreaLayoutGuideView: UIView {
        get { return _visibleAreaLayoutGuideView}
        set { _visibleAreaLayoutGuideView = newValue }
    }
    
    var hitAreaInsets: UIEdgeInsets?
    var currentVisibleAreaInsets: UIEdgeInsets?
    var lastRecordedIntrinsicContentSize: CGSize?
    var titleTopConstraint: NSLayoutConstraint?
    var titleBottomConstraint: NSLayoutConstraint?
    var titleLeadingConstriant: NSLayoutConstraint?
    var titleTrailingConstraint: NSLayoutConstraint?
    
    var qEnablePerformantShadow: Bool = false
    
    // MARK: - Public properties
    public var centerVisibileArea: Bool = false
    
    public var layoutTitleWithConstraints: Bool = false
    
    public var shapeGenerator: F1ShapeGenerating? = nil
    
    // MARK: - Private methods
    
    func generateShape(with cornerRadius: CGFloat,
                       visibleAreaInsets: UIEdgeInsets) -> F1RectangleShapeGenerator {
        return .init()
    }
    
    func configureLayerWith(_ shapeGenerator: F1ShapeGenerating) {}
}

// MARK: Public Methods
extension F1Button {
    
}

// MARK: Delegates
extension F1Button: F1Elevatable {
    public var f1_currentElevation: CGFloat {
        return _currentElevation
    }
    
    public var f1_elevationDidChange: ((F1Elevatable, CGFloat) -> Void)? {
        return nil
    }
}

extension F1Button: F1ElevationOverriding {
    public var f1_overrideBaseElevation: CGFloat {
        return 0
    }
}
