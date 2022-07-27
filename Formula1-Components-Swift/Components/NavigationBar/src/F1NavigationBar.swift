//
//  F1NavigationBar.swift
//  Formula1-Components-Swift
//
//  Created by Maarten Wubs on 7/20/22.
//

import Foundation
import UIKit

// TODO: [f1n40789kl1-navigation]

protocol F1ButtonBarDelegate {}

/// Specifies the title alignment of the `F1NavigationBar`
enum F1NavigationBatTitleAlignment {
    /// Aligns the title to the center of the NavigationBar
    case center
    
    /// Aligns the title to the left/leading of the NavigationBar
    case leading
}

/// Behaviors that affect the layout of an `F1NavigationBar` title view.
enum F1NavigationBarTitleViewLayoutBehavior {
    /// The title view's width will equal the navigation bar's width minus any space consumed by the
    /// leading and trailing buttons
    ///
    /// The title view's center may not align with the navigation bar's center in the case.
    case fill
    
    /// Align the title view's center with the navigation bar's center, if possible.
    case center
    
    /// Align the title view's center with the navifation bar's center, if possible. Relies in the
    /// title view's intrinsicContentSize to determine its width.
    case centerFit
}

/// This protocol defines all of the properties in `UINavigtionItem` that can be listened to by
/// `F1NavigationBar`.
protocol F1UINavigationItemObservables: NSObject {
    
    var title: String? { get }
    var titleView: UIView? { get }
    var hidesBackButton: Bool { get }
    var leftBarButtonItems: [UIBarButtonItem]? { get }
    var rightBarButtonItems: [UIBarButtonItem]? { get }
    var leftItemsSupplementBackButton: Bool { get }
    var leftBarbButtonItem: UIBarButtonItem { get }
    var rightBarButtonItem: UIBarButtonItem { get }
    
}

/// The `F1NavigationBar` class is a view consisting of a leading and trailing button bar, title label,
/// and an optional title view.
class F1NavigationBarTextColorAccessibilityMutator: NSObject {
    override init() { }
    
    public func mutate(_ navBar: F1NavigationBar) {
        let backgroundColor: UIColor? = navBar.backgroundColor
        if backgroundColor == nil {
            return
        }
    }
}

class F1NavigationBarSandbagView: UIView { }

public class F1NavigationBar: UIView {
    
    private var _observedNavigationItem: UINavigationItem!
    private var _inkColor: UIColor!
    private var _titleLabel: UILabel!
    private var _leadingButtonLane: F1ButtonLane!
    private var _trailingButtonBar: F1ButtonLane!
    private var _titleInsetsAreExplicit: Bool = false
    private var _watchingViewController: UIViewController!
    private var _titleView: UIView!
    
    public var title: String?
    public var titleView: UIView? {
        get { return _titleView }
        set {
            if _observedNavigationItem.titleView is F1NavigationBarSandbagView {
                return
            }
            
            if newValue != nil {
                _observedNavigationItem.titleView = F1NavigationBarSandbagView()
            } else if _observedNavigationItem.titleView != nil {
                _observedNavigationItem.titleView = nil
            }
            
            if self.titleView != titleView {
                self.titleView?.removeFromSuperview()
                _titleView = titleView
            }
            
            if _titleView != nil {
                self.addSubview(_titleView)
            }
            
            _titleLabel.isHidden = _titleView != nil
            self.setNeedsLayout()
        }
    }
    
    public var titleTextAttributes: NSDictionary?
}
