//
//  F1Palettes.swift
//  Formula1-Components-Swift
//
//  Created by Maarten Wubs on 7/18/22.
//

import Foundation
import UIKit

/// Tint color name.
public enum F1PaletteTint: NSString, Hashable {
    case tint50 = "50"
    case tint100 = "100"
    case tint200 = "200"
    case tint300 = "300"
    case tint400 = "400"
    case tint500 = "500"
    case tint600 = "600"
    case tint700 = "700"
    case tint800 = "800"
    case tint900 = "900"
}

/// Accent color name
public enum F1PaletteAccent: NSString, Hashable {
    case accent100 = "A100"
    case accent200 = "A200"
    case accent400 = "A400"
    case accent700 = "A700"
}

/// A palette of Formula1 colors.
///
/// Formula1 palettes have a set of named tint colors and an optional set of named accent colors. This
/// class provides access to the pre-defined set of Formula1 palettes. `F1Palette` objects are
/// immutable; It is safe to use them from multiple threads in your app.
public class F1Pallete: NSObject {
    // TODO: [f1e35t73] Get the stored palettes and the initializers.
    
    /// Returns an initialized palette object with a custom set of tints and accents.
    public func initWith(_ tints: [F1PaletteTint: UIColor],
                         accents: [F1PaletteAccent: UIColor]) {
        
    }
}
