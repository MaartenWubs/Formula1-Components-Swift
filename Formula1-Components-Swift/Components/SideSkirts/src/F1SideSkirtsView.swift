//
//  F1SideSkirtsView.swift
//  Formula1-Components-Swift
//
//  Created by Maarten Wubs on 7/20/22.
//

import Foundation
import UIKit

// TODO: [f1s3304f03-sideSkirts]

// MARK: - Global properties
let F1SideSkirtBackgroundColor: UInt32 = 0xEBEBEB
let F1SideSkirtSelectedDarkenPercent: CGFloat = 0.16
let F1SideSkirtDisabledLightenPercent: CGFloat = 0.38
let F1SideSkirtTitleColorWhite: CGFloat = 0.13
let F1SideSkirtTitleColorDisbaledLightenPercent: CGFloat = 0.38

let qF1SideSkirtMinimumSizeDefault: CGSize = .init(width: 0, height: 32)

let F1SideSkirtContentPadding: UIEdgeInsets = .init(top: 4, left: 4, bottom: 4, right: 4)
let F1SideSkirtImagePadding: UIEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 0)
let F1SideSkirtTitlePadding: UIEdgeInsets = .init(top: 3, left: 8, bottom: 4, right: 8)
let F1SideSkirtAccessoryPadding: UIEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 0)

let qEnablePerformantShadow = false

let kKVOContextF1SideSkirtView = ("kKVOContextF1SideSkirtView" as NSString).utf8String

/// Side skirts are compact elemets that represent an attribute, text, enity, or action.
///
/// Side skirts contain an optional leading image, a title label and an optional trailing view.
/// They can also contain a leading image that appears only when the side skirt is selected.
///
/// Side skirts currently support two horizontalAlignment syles: centered and default.
/// In the defautl mode, the image and text will be left-aligned, and the eccessory view will
/// be right aligned. In the centered mode, all three will appear together in the center of the
/// side skirt.
public class F1SideSkirtsView: UIControl {
    
    // MARK: - Public properties
    
    /// A UIImageView that leads the title label.
    public var imageView: UIImageView = .init()
    
    /// A UIIMageView that leads the title label. Appears in front of the imageView. Only visible
    /// when the side skirt is selected.
    ///
    /// This image view is typically used to show some icon that denotes the side skirt as selected,
    /// such as a checkmark. If imageView has no image then the side skirt will require resizing when
    /// selceted or deselected to account for the changing visibility of selectedImageView.
    public var selectedImageView: UIImageView = .init()
    
    ///A UIView that trails the title label.
    ///
    ///It will be given a size based on the value returned from `sizeThatFits()`
    public var accessoryView: UIView?
    
    /// The title label.
    ///
    /// **Note**: The title color is controlled by `setTitleColor(for:)` and the
    /// title font is controlled bt `setTitleFont`.
    public var titleLabel: UILabel = .init()
    
    /// Padding around the side skirt content. Each subview can be further padded with their individual
    /// padding property.
    ///
    /// The side skirt uses this property to determine `instrinsicContentSize` and `sizeThatFits`
    ///
    /// Defaults to (4, 4, 4, 4)
    public var contentPadding: UIEdgeInsets = F1SideSkirtContentPadding
    
    /// Padding around the image view. Only used if the image view has a non nil image.
    ///
    /// The side skirt uses this property to determine `instrinsicContentSize` and `sizeThatFits`
    ///
    /// Defaults to (0, 0, 0, 0)
    public var imagePadding: UIEdgeInsets = F1SideSkirtImagePadding
    
    /// Padding around the accessory view. Only used if the accessory has a non nil image.
    ///
    /// The side skirt uses this property to determine `instrinsicContentSize` and `sizeThatFits`
    ///
    /// Defaults to (0, 0, 0, 0)
    public var accessoryPadding: UIEdgeInsets = F1SideSkirtAccessoryPadding
    
    /// Padding around the title.
    ///
    /// The side skirt uses this property to determine `instrinsicContentSize` and `sizeThatFits`
    ///
    /// Defaults to (3, 8, 4, 8). The top padding is shorter so the default height of a side skirt is 32 pts.
    public var titlePadding: UIEdgeInsets = F1SideSkirtTitlePadding
    
    /// Font used to render the title.
    ///
    /// If nil, the side skirt will use the system font.
    public var titleFont: UIFont?
    
    /// The shape generator used to define the side skirt's shape.
    public var shapeGenerator: F1ShapeGenerating?
    
    /// The corner radius for the side skirt.
    ///
    /// Use this property to configure corner radius insted of `self.layer.cornerRadius`
    ///
    /// By default it is set to 16, to make the default height rounded.
    public var cornerRadius: CGFloat = 16
    
    /// The minimum dimensions of the side skirt. A non-positive value for either height or width is
    /// equivalent
    /// to no minimum for that dimension.
    ///
    /// Defaults to a minimum height of 32 pts, and no minimum width.
    public var minimumSize: CGSize = .init(width: CGFloat.zero, height: 32)
    
    /// A boolean value that determines wheteher the visible area is centered in the bounds of the view.
    ///
    /// If set to `true`, the visisble area is centered in the bounds of the view, which is often used to
    /// configure invisible tappable area. If set to `false`, the visible are fills its bounds. This property
    /// doesn't affect the result of `sizeThatFits`
    ///
    /// The default value is `false`.
    public var centerVisibleArea: Bool = false
    
    /// The calculated inset or outset margins for the rectangle surrounding all of the side skirt'svisibla area.
    ///
    /// When `centerVisibleArea` is `false`, this value is `UIEdgesInsets.zero`
    public var visibleAreaInsets: UIEdgeInsets = .zero
    
    // MARK: - Private properties
    
    var contentRect: CGRect = .zero
    //var layer: F1ShapedShadowLayer // TODO: make F1ShapedShadowLayer
    var showImageView: Bool = false
    var showSelectedImageView: Bool = false
    var showAccessoryView: Bool = false
    var shouldFullyRoundedCorner: Bool = false
    var inkView: F1InkView = .init()
    var rippleView: F1RippleView = .init()
    var rippleColors: [NSNumber : UIColor] = [:]
    var pixelScale: CGFloat = .zero
    var enableRippleBehavior: Bool = false
    var currentVisibleAreaInsets: UIEdgeInsets = .init()
    var currentCornerRadius: CGFloat = .zero
    
    var _backgroundColors: [NSNumber : UIColor]?
    var _borderColors: [NSNumber : UIColor]?
    var _borderWidths: [NSNumber : NSNumber]?
    var _elevations: [NSNumber : NSNumber]?
    var _inkColors: [NSNumber : UIColor]?
    var _shadowColors: [NSNumber : UIColor]?
    var _titleColors: [NSNumber : UIColor]?
    
    var _titleFont: UIFont?
    
    var _f1_adjustsFontForContentSizeCategory: Bool = false
    var _currentElevation: CGFloat = 0.0
    
    // MARK: - Init
    
    public override class var layerClass: AnyClass {
        return super.layerClass
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonF1SideSkirtViewInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonF1SideSkirtViewInit()
    }
    
    func commonF1SideSkirtViewInit() {
        minimumSize = qF1SideSkirtMinimumSizeDefault
        self.isAccessibilityElement = true
        self.accessibilityTraits = UIAccessibilityTraits.button
        _currentElevation = 0
        if qEnablePerformantShadow {
            
        }
        
    }
    
    func dealloc() {
        removeTarget(self, action: nil, for: UIControl.Event.allEvents)
    }
    
    // MARK: - Public method
    
    /// A color used as the side skirt's `backgroundColor` for `state`.
    ///
    /// If no background color has been set for a given state, the returend value will fall back to the
    /// value set for `UIControl.State.normal`.
    ///
    ///  - Parameter state: The control state.
    ///  - Return: The background color.
    public func backgroundColor(for state: UIControl.State) -> UIColor? { return nil }
    
    /// A color used as the side skirt's `backgroundColor`
    ///
    /// Defaults to blue.
    ///
    /// - Parameter backgroundColor: The background color.
    /// - Parameter state: The control state.
    public func setBackgroundColor(_ background: UIColor?, for state: UIControl.State) { }
    
    /// Returns the border color for a particular control state.
    ///
    /// If no border width has been set for a given state, the returned value will fall back to the value
    /// set for `UIControl.State.normal`
    ///
    /// - Parameter state: The control color.
    /// - Return: The border color for the requested state.
    public func borderColor(for state: UIControl.State) -> UIColor? { return nil }
    
    /// Sets the border color for a particular control state.
    ///
    /// - Parameter borderColor: The border color.
    /// - Parameter state: The control state.
    public func setBorderColor(_ color: UIColor?, for state: UIControl.State) { }
    
    /// Returns the border width for a particular control state.
    ///
    /// If no border width has been set for a given state, the returned value will back to the value
    /// set for `UIControl.State.normal`.
    ///
    /// - Parameter state: The control state.
    /// - Return: The border width for the requested state.
    public func borderWidth(for state: UIControl.State) -> CGFloat { return 0.0 }
    
    /// Sets the border width for a particular control state.
    ///
    /// - Parameter borderWidth: The border width.
    /// - Parameter state: The control state.
    public func setBorderWidth(_ width: CGFloat, for state: UIControl.State) { }
    
    /// Returns the elevation for a particular control state.
    ///
    /// If no elevation has been set for a given state, the returned value will fall back to the value set
    /// for `UIControl.State.normal`
    ///
    /// - Parameter state: The control state.
    /// - Return: The elevation for the requested state.
    public func elevation(for state: UIControl.State) -> F1ShadowElevation? { return nil }
    
    /// Sets the elevation for a particular control state.
    ///
    /// - Parameter elevation: The elevation.
    /// - Parameter state: The control state.
    public func setElevation(_ elevation: F1ShadowElevation, for state: UIControl.State) { }
    
    /// Returns the ink color for a particular control state.
    ///
    /// If no ink color has been set for a given state, the returned value will fall back to the value
    /// set for `UIControl.State.normal`. Defaults to nil. When nil `F1InkView.defaultColor`
    /// is used.
    ///
    /// - Parameter state: The control state.
    /// - Return: The ink color for the requested state,
    public func inkColor(for state: UIControl.State) -> UIColor? { return nil }
    
    /// Sets the ink color for a particular control state.
    ///
    /// - Parameter inkColor: The ink color.
    /// - Parameter state: The control state.
    public func setInkColor(_ color: UIColor?, for state: UIControl.State) { }
    
    /// Returns the ripple color associated with the specified state.
    ///
    /// The ripple color for the specified state. If no ripple color has been set for the specific state,
    /// the method returns the title associated with the `UIControl.State.normal` state.
    ///
    /// **Note**: Defaults to `nil`. When `nil` transparent black is used.
    ///
    /// - Parameter state: The state uses the ripple color.
    /// - Return: The ripple color for the requested state.
    public func rippleColor(for state: UIControl.State) -> UIColor? { return nil }
    
    /// Sets the ripple color for a particular control state.
    ///
    /// - Parameter rippleColor: The ripple color to use for the specified state.
    /// - Parameter state: The state that uses the specified ripple color.
    public func setRippleColor(_ color: UIColor?, for state: UIControl.State) { }
    
    /// Returns the shadow color for a particular control state.
    ///
    /// If no shadow color has been set for a given state, the returned value will fall back to the value
    /// set for `UIControl.State.normal`.
    ///
    /// - Parameter state: The control state.
    /// - Return: The shadow color for the requested state.
    public func shadowColor(for state: UIControl.State) -> UIColor? { return nil }
    
    /// Sets the shadow color for a particular control state.
    ///
    /// - Parameter elevation: The shadow color.
    /// - Parameter state: The control state.
    public func setShadowColor(_ color: UIColor?, for state: UIControl.State) { }
    
    /// Retruns the title color for a particular control state.
    ///
    /// If no title color has been set for a given state, the returned value will fall back to the value
    /// set for `UIControl.State.normal`.
    ///
    /// - Parameter state: The control state.
    /// - Return: The title color for the required state.
    public func titleColor(for state: UIControl.State) -> UIColor? { return nil }
    
    /// Sets the title color for a particular control state.
    ///
    /// - Parameter titleColor: The title color.
    /// - Parameter state: The control state.
    public func setTitleColor(_ color: UIColor?, for state: UIControl.State) { }
    
}

extension F1SideSkirtsView: F1Elevatable {
    public var f1_currentElevation: CGFloat {
        return _currentElevation
    }
    
    public var f1_elevationDidChange: ((F1Elevatable, CGFloat) -> Void)? {
        return nil
    }
  
}

extension F1SideSkirtsView: F1ElevationOverriding {
    public var f1_overrideBaseElevation: CGFloat {
        return 0.0
    }
}
