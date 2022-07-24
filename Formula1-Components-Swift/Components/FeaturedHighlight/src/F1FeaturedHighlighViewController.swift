//
//  F1FeaturedHighlighViewController.swift
//  Formula1-Components-Swift
//
//  Created by Maarten Wubs on 7/18/22.
//

import Foundation
import UIKit

// TODO: [f1f55490ggf0-feturesHighlights]

/// A completion block called when the feature highligh is dismissed either by calling
/// `acceptFeature` of `rejectfeature` on the feature highlight or the user accepts
/// or rejects the highlight by tapping somewhere on the highlight view.
public typealias F1FeatureHighlightCompletion = (Bool) -> Void
 
/// F1FeatureHighlighViewController highlights an element of a UI to introduce features or
/// functionality that a user hasn't tried.
public class F1FeaturedHighlighViewController: UIViewController, UIContentSizeCategoryAdjusting {
    public var adjustsFontForContentSizeCategory: Bool = false
    
    /// Initializes the controller
    ///
    /// - Parameter highlightedView: The highlight will be presented above the `center` of `highlightedView`
    /// - Parameter showView: Added to the highlight view and centered at the `center` of `highlightedView`
    /// - Parameter completion: The completion called when the highlight is dismissed
    public init(highlighedView: UIView, and showView: UIView, completion: @escaping F1FeatureHighlightCompletion) {
        super.init(nibName: nil, bundle: nil)
    }
    
    /// Initializes the controller
    ///
    /// This is a convience method for `init(highlightedView:and:completion:)` with a snapshot of
    /// `highlightedView` sent as `showView`
    ///
    /// - Parameter highlightedView: The highlight will be presented above the `center` of `highlightedView`
    public init(highlightedView: UIView, completion: @escaping F1FeatureHighlightCompletion) {
        super.init(nibName: nil, bundle: nil)
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
