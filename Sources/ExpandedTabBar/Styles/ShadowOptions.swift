//
//  ShadowOptions.swift
//  ExpandedTabBar
//
//  Created by Yervand Saribekyan on 6/11/20.
//  Copyright © 2020 Yervand Saribekyan. All rights reserved.
//
#if !os(macOS)
import UIKit

/// ShadowOptions protocol declatation.
public protocol ShadowOptions: AnyObject {
    
    /// Color.
    var color: UIColor { get set }
    
    /// Offset.
    var offset: CGSize { get set }
    
    /// Opacity.
    var opacity: Float { get set }
    
    /// Radius.
    var radius: CGFloat { get set }
}

/// ShadowOptions declatation.
public final class ShadowOptionsFactory: ShadowOptions {
    
    /// Color.
    public var color: UIColor = .defaultShadowColor
    
    /// Offset.
    public var offset: CGSize = .zero
    
    /// Opacity.
    public var opacity: Float = 0.5
    
    /// Radius.
    public var radius: CGFloat = 5
    
    public init() { }

}

public extension UIView {
    
    /// Set shadow on view with ShadowOptions
    /// - Parameter options: ShadowOptions
    func setShadow(_ options: ShadowOptions) {
        layer.shadowColor = options.color.cgColor
        layer.shadowOpacity = options.opacity
        layer.shadowOffset = options.offset
        layer.shadowRadius = options.radius
        layer.shouldRasterize = true

        layer.masksToBounds = false
        layer.rasterizationScale = UIScreen.main.scale
    }
}
#endif
