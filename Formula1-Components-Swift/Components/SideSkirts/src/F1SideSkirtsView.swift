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

let F1SideSkirtContentPadding: UIEdgeInsets = .init(top: 4, left: 4, bottom: 4, right: 4)
let F1SideSkirtImagePadding: UIEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 0)
let F1SideSkirtTitlePadding: UIEdgeInsets = .init(top: 3, left: 8, bottom: 4, right: 8)
let F1SideSkirtAccessoryPadding: UIEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 0)

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
    
    // MARK: - Public method
    // TODO: Add documentation...
    
    public func setBackgroundColor(for state: UIControl.State) -> UIColor? { return nil }
    
    public func setBackgroundColor(_ background: UIColor?, for state: UIControl.State) { }
    
    public func borderColor(for state: UIControl.State) -> UIColor? { return nil }
    
    public func setBorderColor(_ color: UIColor?, for state: UIControl.State) { }
    
    public func borderWidth(for state: UIControl.State) -> CGFloat { return 0.0 }
    
    public func setBorderWidth(_ width: CGFloat, for state: UIControl.State) { }
    
    public func elevation(for state: UIControl.State) -> F1ShadowElevation? { return nil }
    
    public func setElevation(_ elevation: F1ShadowElevation, for state: UIControl.State) { }
    
    public func inkColor(for state: UIControl.State) -> UIColor? { return nil }
    
    public func setInkColor(_ color: UIColor?, for state: UIControl.State) { }
    
    public func rippleColor(for state: UIControl.State) -> UIColor? { return nil }
    
    public func setRippleColor(_ color: UIColor?, for state: UIControl.State) { }
    
    public func shadowColor(for state: UIControl.State) -> UIColor? { return nil }
    
    public func setShadowColor(_ color: UIColor?, for state: UIControl.State) { }
    
    public func titleColor(for state: UIControl.State) -> UIColor? { return nil }
    
    public func setTitleColor(_ color: UIColor?, for state: UIControl.State) { }
    
}
