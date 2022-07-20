//
//  UIApplication+F1AppExtension.swift
//  Formula1-Components-Swift
//
//  Created by Maarten Wubs on 7/18/22.
//

import Foundation
import UIKit

/// UIApplication extension for working with sharedApplication inside of app.
extension UIApplication {
    
    /// Returns sharedApplication if it is available otherwise returns nil
    func f1_safeSharedApplication() -> UIApplication {
        let app = UIApplication.shared
        return app
    }
    
    func f1_isAppExtension() -> Bool {
        let isAppExtension = (Bundle.main.executablePath as NSString?)?.range(of: ".appex/").location != NSNotFound
        return isAppExtension
    }
}
