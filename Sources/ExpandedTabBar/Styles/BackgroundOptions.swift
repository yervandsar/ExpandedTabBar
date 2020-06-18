//
//  BackgroundOptions.swift
//  ExpandedTabBar
//
//  Created by Yervand Saribekyan on 6/11/20.
//  Copyright © 2020 Yervand Saribekyan. All rights reserved.
//
#if !os(macOS)
import UIKit

/// BackgroundOptions protocol declaration
public protocol BackgroundOptions {
    
    /// Background color.
    var color: UIColor { get set }
    
    /// Background alpha.
    var alpha: CGFloat { get set }
    
    /// Close on tap to background.
    var closeOnTap: Bool { get set }
}

/// BackgroundOptions declaration
public struct BackgroundDefaultOptions: BackgroundOptions {
    
    /// Background color.
    public var color: UIColor = .clear
    
    /// Background alpha.
    public var alpha: CGFloat = 0.3
    
    /// Close on tap to background.
    public var closeOnTap: Bool = true
    
    public init() { }
    
}
#endif
