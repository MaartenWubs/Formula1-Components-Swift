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

class F1NavigationBarTextColorAccessibilityMutator: NSObject {
    override init() { }
    
    public func mutate(_ navBar: F1NavigationBar) { }
}

public class F1NavigationBar: UIView {}
