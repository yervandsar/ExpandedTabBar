//
//  ContainerTabOptions.swift
//  ExpandedTabBar
//
//  Created by Yervand Saribekyan on 6/11/20.
//  Copyright © 2020 Yervand Saribekyan. All rights reserved.
//
#if !os(macOS)
import UIKit

/// ContainerTabOptions protocol declaration
public protocol ContainerTabOptions: AnyObject {
    
    /// Item height.
    var itemHeight: CGFloat { get set }
    
    /// Title font.
    var titleFont: UIFont { get set }
    
    /// Title color.
    var titleColor: UIColor { get set }
    
    /// Icon color.
    var iconColor: UIColor { get set }
    
    /// Icon content mode.
    var iconContentMode: UIView.ContentMode { get set }
    
    /// Space between icon and title
    var iconTitleSpace: CGFloat { get set }
    
}

/// ContainerTabOptions declaration
public final class ContainerTabBarOptionsFactory: ContainerTabOptions {
    
    /// Item height.
    public var itemHeight: CGFloat = 35
    
    /// Title font.
    public var titleFont: UIFont = .systemFont(ofSize: 16)
    
    /// Title color.
    public var titleColor: UIColor = .defaultTitleColor
    
    /// Icon color.
    public var iconColor: UIColor = .defaultIconColor
    
    /// Icon content mode.
    public var iconContentMode: UIView.ContentMode = .scaleAspectFit
    
    /// Space between icon and title
    public var iconTitleSpace: CGFloat = 8

}
#endif
