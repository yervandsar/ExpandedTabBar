//
//  DarkModeSupport.swift
//  ExpandedTabBar
//
//  Created by Yervand Saribekyan on 6/11/20.
//  Copyright © 2020 Yervand Saribekyan. All rights reserved.
//
#if !os(macOS)
import UIKit

public extension UIColor {
    // MARK: - Default color patterns
    
    /// Background color pattern. light: .white and dark: .black
    static var defaultBackgroundColor: UIColor { .pattern(light: .white, dark: .black) }
    
    /// Icon color pattern. light: .black and dark: .white
    static var defaultIconColor: UIColor { .pattern(light: .black, dark: .white) }
    
    /// Title color pattern. light: .black and dark: .white
    static var defaultTitleColor: UIColor { .pattern(light: .black, dark: .white) }
    
    /// Shadow color pattern. light: .black and dark: .white
    static var defaultShadowColor: UIColor { .black }

    // MARK: - Methods
    
    /// Create color pattern for dark mode support if needed.
    /// - Parameters:
    ///   - light: Color in light mode
    ///   - dark: Color in dark mode
    /// - Returns: Color for device os style.
    class func pattern(light: UIColor, dark: UIColor) -> UIColor {
        if #available(iOS 13, *) {
            return UIColor { $0.userInterfaceStyle == .dark ? dark : light }
        } else {
            return light
        }
    }
}
#endif
