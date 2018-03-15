//
//  ExpandedTabBarOptions.swift
//  ExpandedTabBar
//
//  Created by Yervand Saribekyan on 3/13/18.
//  Copyright © 2018 Yervand Saribekyan. All rights reserved.
//

import UIKit

public struct ExpandedTabBarOptions {

    public static var `default`: ExpandedTabBarOptions {
        return ExpandedTabBarOptions()
    }

    public init() {}

    /// Background view options
    public var backgroundColor: UIColor = ExpandedTabBarDefaultOptions.backgroundColor
    public var backgroundAlpha: CGFloat = ExpandedTabBarDefaultOptions.backgroundAlpha

    /// List's container options
    public var containerBackgroundColor: UIColor = ExpandedTabBarDefaultOptions.containerBackgroundColor
    public var containerBackgroundAlpha: CGFloat = ExpandedTabBarDefaultOptions.containerBackgroundAlpha
    public var containerCornerRadius: CGFloat = ExpandedTabBarDefaultOptions.containerCornerRadius
    public var containerBottomMargin: CGFloat = ExpandedTabBarDefaultOptions.containerBottomMargin
    public var containerItemsSpace: CGFloat = ExpandedTabBarDefaultOptions.containerItemsSpace
    public var shadow: ExpandedTabBarShadowOptions?

    /// Item View Options
    public var titleFont: UIFont = ExpandedTabBarDefaultOptions.titleFont
    public var titleColor: UIColor = ExpandedTabBarDefaultOptions.titleColor
    public var itemHeight: CGFloat = ExpandedTabBarDefaultOptions.itemHeight
    public var imageContentMode: UIViewContentMode = ExpandedTabBarDefaultOptions.imageContentMode
    public var spaceBetweenImageTitle: CGFloat = ExpandedTabBarDefaultOptions.spaceBetweenImageTitle

}

public struct ExpandedTabBarShadowOptions {

    public static var `default`: ExpandedTabBarShadowOptions {
        return ExpandedTabBarShadowOptions()
    }

    public init() {}

    public var color: UIColor = ExpandedTabBarShadowDefaultOptions.color
    public var offset: CGSize = ExpandedTabBarShadowDefaultOptions.offset
    public var opacity: Float = ExpandedTabBarShadowDefaultOptions.opacity
    public var radius: CGFloat = ExpandedTabBarShadowDefaultOptions.radius

}
